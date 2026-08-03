import { MizAiError, mizAiError } from "./errors.ts";
import { logEvent } from "./observability.ts";
import type {
  IncomingLocation,
  IncomingSelectedCity,
  NormalizedPlace,
  SearchNearbyPlacesArgs,
  SearchNearbyPlacesResult,
  ToolExecutionContext,
} from "./types.ts";

const NEARBY_URL = "https://places.googleapis.com/v1/places:searchNearby";
const TEXT_URL = "https://places.googleapis.com/v1/places:searchText";
export const PLACES_ATTEMPT_TIMEOUT_MS = 12000;
const PLACES_MAX_ATTEMPTS = 2;
const MAX_RESULTS = 10;

const PLACE_FIELD_MASK = [
  "places.id",
  "places.displayName",
  "places.formattedAddress",
  "places.location",
  "places.rating",
  "places.userRatingCount",
  "places.currentOpeningHours.openNow",
  "places.primaryType",
  "places.types",
  "places.businessStatus",
].join(",");

interface PlacesApiPlace {
  id?: string;
  displayName?: { text?: string };
  formattedAddress?: string;
  location?: { latitude?: number; longitude?: number };
  rating?: number;
  userRatingCount?: number;
  currentOpeningHours?: { openNow?: boolean };
  primaryType?: string;
  types?: string[];
  businessStatus?: string;
}

interface PlacesApiResponse {
  places?: PlacesApiPlace[];
}

export interface PlacesRequestOptions {
  attemptTimeoutMs?: number;
  maxAttempts?: number;
}

function clampRadius(radiusMeters: number | undefined): number {
  const value = radiusMeters ?? 5000;
  return Math.min(20000, Math.max(500, value));
}

function clampRating(rating: number | undefined): number | undefined {
  if (rating === undefined) return undefined;
  return Math.min(5, Math.max(0, rating));
}

/** Haversine distance in meters — mirrors the formula shape used client-side
 * in `DeviceLocationService._distanceKm` (Dart), reimplemented here since
 * Edge Functions cannot import Dart code. */
function distanceMeters(
  from: { latitude: number; longitude: number },
  to: { latitude: number; longitude: number },
): number {
  const earthRadiusMeters = 6371000;
  const toRad = (deg: number) => (deg * Math.PI) / 180;
  const dLat = toRad(to.latitude - from.latitude);
  const dLon = toRad(to.longitude - from.longitude);
  const lat1 = toRad(from.latitude);
  const lat2 = toRad(to.latitude);
  const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(lat1) * Math.cos(lat2) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
  return earthRadiusMeters * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
}

function resolveCenter(
  location: IncomingLocation | null,
  selectedCity: IncomingSelectedCity | null,
): {
  center: { latitude: number; longitude: number };
  source: "current_location" | "selected_city";
  city: string | null;
} {
  if (location) {
    return { center: location, source: "current_location", city: selectedCity?.name ?? null };
  }
  if (selectedCity) {
    return {
      center: { latitude: selectedCity.latitude, longitude: selectedCity.longitude },
      source: "selected_city",
      city: selectedCity.name,
    };
  }
  throw mizAiError("LOCATION_REQUIRED");
}

async function fetchWithTimeout(
  url: string,
  init: RequestInit,
  context: ToolExecutionContext,
  options: PlacesRequestOptions,
): Promise<Response> {
  const maxAttempts = options.maxAttempts ?? PLACES_MAX_ATTEMPTS;
  for (let attempt = 1; attempt <= maxAttempts; attempt++) {
    const remainingMs = context.deadlineMs - Date.now();
    if (remainingMs <= 0) throw mizAiError("PLACES_TIMEOUT", "total request deadline reached");
    const controller = new AbortController();
    const timeout = setTimeout(
      () => controller.abort(),
      Math.max(1, Math.min(options.attemptTimeoutMs ?? PLACES_ATTEMPT_TIMEOUT_MS, remainingMs)),
    );
    const startedAt = Date.now();
    try {
      const response = await fetch(url, { ...init, signal: controller.signal });
      if (response.status >= 500) {
        logEvent(context.requestId, "places_attempt", {
          attempt,
          success: false,
          errorCode: "PLACES_UNAVAILABLE",
          durationMs: Date.now() - startedAt,
        });
        if (attempt < maxAttempts && context.deadlineMs > Date.now()) continue;
        throw mizAiError("PLACES_UNAVAILABLE", `Places temporary error: ${response.status}`);
      }
      return response;
    } catch (error) {
      if (error instanceof MizAiError) throw error;
      const timedOut = error instanceof DOMException && error.name === "AbortError";
      logEvent(context.requestId, "places_attempt", {
        attempt,
        success: false,
        errorCode: timedOut ? "PLACES_TIMEOUT" : "PLACES_UNAVAILABLE",
        durationMs: Date.now() - startedAt,
      });
      if (attempt < maxAttempts && context.deadlineMs > Date.now()) continue;
      throw mizAiError(
        timedOut ? "PLACES_TIMEOUT" : "PLACES_UNAVAILABLE",
        timedOut ? "Places request timed out" : "Places network request failed",
      );
    } finally {
      clearTimeout(timeout);
    }
  }
  throw mizAiError("PLACES_UNAVAILABLE", "Places attempt loop exited unexpectedly");
}

function normalizePlace(
  place: PlacesApiPlace,
  center: { latitude: number; longitude: number },
): NormalizedPlace | null {
  const id = place.id;
  const name = place.displayName?.text;
  const latitude = place.location?.latitude;
  const longitude = place.location?.longitude;
  if (!id || !name || latitude === undefined || longitude === undefined) return null;
  return {
    id,
    name,
    address: place.formattedAddress ?? "",
    latitude,
    longitude,
    rating: place.rating ?? null,
    reviewCount: place.userRatingCount ?? null,
    openNow: place.currentOpeningHours?.openNow ?? null,
    primaryType: place.primaryType ?? null,
    types: place.types ?? [],
    distanceMeters: Math.round(distanceMeters(center, { latitude, longitude })),
    photoReference: null,
  };
}

async function callPlacesApi(
  url: string,
  apiKey: string,
  body: unknown,
  context: ToolExecutionContext,
  options: PlacesRequestOptions,
): Promise<PlacesApiResponse> {
  const response = await fetchWithTimeout(
    url,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": apiKey,
        "X-Goog-FieldMask": PLACE_FIELD_MASK,
      },
      body: JSON.stringify(body),
    },
    context,
    options,
  );

  if (response.status === 401 || response.status === 403) {
    throw mizAiError("PLACES_CONFIGURATION_ERROR", `Places API auth error: ${response.status}`);
  }
  if (response.status === 429) {
    throw mizAiError("PLACES_QUOTA_EXCEEDED", "Places API quota exceeded");
  }
  if (!response.ok) {
    const text = await response.text().catch(() => "");
    throw mizAiError("PLACES_CONFIGURATION_ERROR", `Places API error ${response.status}: ${text}`);
  }
  return (await response.json()) as PlacesApiResponse;
}

export async function searchNearbyPlaces(
  args: SearchNearbyPlacesArgs,
  context: ToolExecutionContext,
  options: PlacesRequestOptions = {},
): Promise<SearchNearbyPlacesResult> {
  const apiKey = Deno.env.get("GOOGLE_PLACES_API_KEY");
  if (!apiKey) {
    throw mizAiError("PLACES_CONFIGURATION_ERROR", "GOOGLE_PLACES_API_KEY is not configured");
  }
  if (!Array.isArray(args.placeTypes) || args.placeTypes.length === 0) {
    throw mizAiError("INVALID_TOOL_CALL", "placeTypes must be a non-empty array");
  }

  const { center, source, city } = resolveCenter(context.location, context.selectedCity);
  const radiusMeters = clampRadius(args.radiusMeters);
  const minimumRating = clampRating(args.minimumRating);

  const query = typeof args.query === "string" ? args.query.trim() : "";
  const raw = query.length > 0
    ? await callPlacesApi(
      TEXT_URL,
      apiKey,
      {
        textQuery: `${query} ${args.placeTypes.join(" ")}`.trim(),
        locationBias: { circle: { center, radius: radiusMeters } },
        includedType: args.placeTypes[0],
        openNow: args.openNow,
        minRating: minimumRating,
        rankPreference: args.sortBy === "distance" ? "DISTANCE" : "RELEVANCE",
        pageSize: MAX_RESULTS,
      },
      context,
      options,
    )
    : await callPlacesApi(
      NEARBY_URL,
      apiKey,
      {
        includedTypes: args.placeTypes,
        maxResultCount: MAX_RESULTS,
        locationRestriction: { circle: { center, radius: radiusMeters } },
        rankPreference: args.sortBy === "distance" ? "DISTANCE" : "POPULARITY",
      },
      context,
      options,
    );

  const places = (raw.places ?? [])
    .map((place) => normalizePlace(place, center))
    .filter((place): place is NormalizedPlace => place !== null)
    .filter((place) => (minimumRating === undefined ? true : (place.rating ?? 0) >= minimumRating))
    .slice(0, MAX_RESULTS);

  if (args.sortBy === "distance") {
    places.sort((a, b) => (a.distanceMeters ?? 0) - (b.distanceMeters ?? 0));
  } else if (args.sortBy === "rating") {
    places.sort((a, b) => (b.rating ?? 0) - (a.rating ?? 0));
  }

  return {
    places,
    searchCenter: { source, city },
    appliedFilters: { radiusMeters, openNow: args.openNow ?? null },
  };
}
