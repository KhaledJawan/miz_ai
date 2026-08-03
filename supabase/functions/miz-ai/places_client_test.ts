import { assertEquals, assertRejects } from "jsr:@std/assert@1";
import { MizAiError } from "./errors.ts";
import { searchNearbyPlaces } from "./places_client.ts";
import type { SearchNearbyPlacesArgs, ToolExecutionContext } from "./types.ts";

const contextWithCity: ToolExecutionContext = {
  location: null,
  selectedCity: { name: "Trier", latitude: 49.75, longitude: 6.64 },
  foodProfileContext: null,
  locale: "en",
  userId: null,
  deadlineMs: Date.now() + 60000,
  requestId: "places-test",
};

function withApiKey<T>(run: () => Promise<T>): Promise<T> {
  const prior = Deno.env.get("GOOGLE_PLACES_API_KEY");
  Deno.env.set("GOOGLE_PLACES_API_KEY", "test-key");
  return run().finally(() => {
    if (prior === undefined) Deno.env.delete("GOOGLE_PLACES_API_KEY");
    else Deno.env.set("GOOGLE_PLACES_API_KEY", prior);
  });
}

function stubFetch(
  handler: (input: string | URL | Request, init?: RequestInit) => Response | Promise<Response>,
): () => void {
  const original = globalThis.fetch;
  globalThis.fetch =
    ((input: string | URL | Request, init?: RequestInit) =>
      Promise.resolve(handler(input, init))) as typeof fetch;
  return () => {
    globalThis.fetch = original;
  };
}

const samplePlace = {
  id: "places/abc123",
  displayName: { text: "Café Central" },
  formattedAddress: "Hauptstraße 1, Trier",
  location: { latitude: 49.751, longitude: 6.641 },
  rating: 4.5,
  userRatingCount: 120,
  currentOpeningHours: { openNow: true },
  primaryType: "cafe",
  types: ["cafe", "food"],
  businessStatus: "OPERATIONAL",
};

Deno.test("searchNearbyPlaces throws PLACES_CONFIGURATION_ERROR when the key is missing", async () => {
  const prior = Deno.env.get("GOOGLE_PLACES_API_KEY");
  Deno.env.delete("GOOGLE_PLACES_API_KEY");
  try {
    await assertRejects(
      () => searchNearbyPlaces({ placeTypes: ["cafe"] }, contextWithCity),
      MizAiError,
    );
  } finally {
    if (prior !== undefined) Deno.env.set("GOOGLE_PLACES_API_KEY", prior);
  }
});

Deno.test("searchNearbyPlaces throws LOCATION_REQUIRED without location or selectedCity", () =>
  withApiKey(async () => {
    const restore = stubFetch(() => new Response(JSON.stringify({ places: [] }), { status: 200 }));
    try {
      await assertRejects(
        () =>
          searchNearbyPlaces(
            { placeTypes: ["cafe"] },
            { ...contextWithCity, selectedCity: null },
          ),
        MizAiError,
      );
    } finally {
      restore();
    }
  }));

Deno.test("searchNearbyPlaces uses searchNearby (types only) when no query is given", () =>
  withApiKey(async () => {
    let calledUrl = "";
    const restore = stubFetch((input) => {
      calledUrl = String(input);
      return new Response(JSON.stringify({ places: [samplePlace] }), { status: 200 });
    });
    try {
      await searchNearbyPlaces({ placeTypes: ["cafe"] }, contextWithCity);
      assertEquals(calledUrl.includes(":searchNearby"), true);
    } finally {
      restore();
    }
  }));

Deno.test("searchNearbyPlaces uses searchText when a free-text query is given", () =>
  withApiKey(async () => {
    let calledUrl = "";
    const restore = stubFetch((input) => {
      calledUrl = String(input);
      return new Response(JSON.stringify({ places: [samplePlace] }), { status: 200 });
    });
    try {
      await searchNearbyPlaces(
        { placeTypes: ["cafe"], query: "quiet coffee" },
        contextWithCity,
      );
      assertEquals(calledUrl.includes(":searchText"), true);
    } finally {
      restore();
    }
  }));

Deno.test("searchNearbyPlaces retries one timeout then returns PLACES_TIMEOUT", () =>
  withApiKey(async () => {
    let attempts = 0;
    const original = globalThis.fetch;
    globalThis.fetch = ((_input: string | URL | Request, init?: RequestInit) => {
      attempts++;
      return new Promise<Response>((_resolve, reject) => {
        init?.signal?.addEventListener(
          "abort",
          () => reject(new DOMException("aborted", "AbortError")),
        );
      });
    }) as typeof fetch;
    try {
      const error = await assertRejects(
        () =>
          searchNearbyPlaces(
            { placeTypes: ["cafe"] },
            { ...contextWithCity, deadlineMs: Date.now() + 1000 },
            { attemptTimeoutMs: 5 },
          ),
        MizAiError,
      );
      assertEquals((error as MizAiError).code, "PLACES_TIMEOUT");
      assertEquals(attempts, 2);
    } finally {
      globalThis.fetch = original;
    }
  }));

Deno.test("searchNearbyPlaces sends a non-empty explicit field mask header", () =>
  withApiKey(async () => {
    let fieldMask: string | null = null;
    const restore = stubFetch((_input, init) => {
      const headers = new Headers(init?.headers);
      fieldMask = headers.get("X-Goog-FieldMask");
      return new Response(JSON.stringify({ places: [] }), { status: 200 });
    });
    try {
      await searchNearbyPlaces({ placeTypes: ["restaurant"] }, contextWithCity);
      assertEquals(typeof fieldMask, "string");
      assertEquals((fieldMask as unknown as string).includes(" "), false);
      assertEquals((fieldMask as unknown as string).length > 0, true);
    } finally {
      restore();
    }
  }));

Deno.test("searchNearbyPlaces normalizes places and computes distance", () =>
  withApiKey(async () => {
    const restore = stubFetch(() =>
      new Response(JSON.stringify({ places: [samplePlace] }), { status: 200 })
    );
    try {
      const result = await searchNearbyPlaces({ placeTypes: ["cafe"] }, contextWithCity);
      assertEquals(result.places.length, 1);
      const place = result.places[0];
      assertEquals(place.name, "Café Central");
      assertEquals(place.rating, 4.5);
      assertEquals(typeof place.distanceMeters, "number");
      assertEquals(result.searchCenter.source, "selected_city");
      assertEquals(result.searchCenter.city, "Trier");
    } finally {
      restore();
    }
  }));

Deno.test("searchNearbyPlaces returns an empty list on no results, not an error", () =>
  withApiKey(async () => {
    const restore = stubFetch(() => new Response(JSON.stringify({}), { status: 200 }));
    try {
      const result = await searchNearbyPlaces({ placeTypes: ["cafe"] }, contextWithCity);
      assertEquals(result.places, []);
    } finally {
      restore();
    }
  }));

Deno.test("searchNearbyPlaces maps a 429 to PLACES_QUOTA_EXCEEDED", () =>
  withApiKey(async () => {
    const restore = stubFetch(() => new Response("rate limited", { status: 429 }));
    try {
      const error = await assertRejects(
        () => searchNearbyPlaces({ placeTypes: ["cafe"] }, contextWithCity),
        MizAiError,
      );
      assertEquals((error as MizAiError).code, "PLACES_QUOTA_EXCEEDED");
    } finally {
      restore();
    }
  }));

Deno.test("searchNearbyPlaces maps a 401 to PLACES_CONFIGURATION_ERROR", () =>
  withApiKey(async () => {
    const restore = stubFetch(() => new Response("unauthorized", { status: 401 }));
    try {
      const error = await assertRejects(
        () => searchNearbyPlaces({ placeTypes: ["cafe"] }, contextWithCity),
        MizAiError,
      );
      assertEquals((error as MizAiError).code, "PLACES_CONFIGURATION_ERROR");
    } finally {
      restore();
    }
  }));

Deno.test("searchNearbyPlaces filters results below minimumRating", () =>
  withApiKey(async () => {
    const lowRated = { ...samplePlace, id: "places/low", rating: 2.0 };
    const restore = stubFetch(() =>
      new Response(JSON.stringify({ places: [samplePlace, lowRated] }), { status: 200 })
    );
    try {
      const result = await searchNearbyPlaces(
        { placeTypes: ["cafe"], minimumRating: 4 } as SearchNearbyPlacesArgs,
        contextWithCity,
      );
      assertEquals(result.places.length, 1);
      assertEquals(result.places[0].id, "places/abc123");
    } finally {
      restore();
    }
  }));

Deno.test("searchNearbyPlaces clamps radius to the allowed range", () =>
  withApiKey(async () => {
    let sentBody: Record<string, unknown> = {};
    const restore = stubFetch((_input, init) => {
      sentBody = JSON.parse(String(init?.body));
      return new Response(JSON.stringify({ places: [] }), { status: 200 });
    });
    try {
      await searchNearbyPlaces(
        { placeTypes: ["cafe"], radiusMeters: 999999 } as SearchNearbyPlacesArgs,
        contextWithCity,
      );
      const restriction = sentBody.locationRestriction as { circle: { radius: number } };
      assertEquals(restriction.circle.radius, 20000);
    } finally {
      restore();
    }
  }));
