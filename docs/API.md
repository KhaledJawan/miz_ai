# API Contracts — Miz

Related: [`docs/ARCHITECTURE.md`](ARCHITECTURE.md), [`docs/DATABASE.md`](DATABASE.md), [`AGENTS.md`](../AGENTS.md) (AI Agent, Backend Agent).

## 1. Mizzz independence

Miz and Mizzz are separate Merlin ICT products with separate data stores. Miz's client and backend logic **never** query Mizzz's database directly — the only allowed integration surface is a versioned HTTP API that Mizzz exposes and Miz consumes as a client, identical in trust level to any third-party API. If a future feature needs Mizzz data, it gets a named contract here before implementation, not an ad-hoc database link.

## 2. Internal API surface (Miz backend ↔ Miz client)

Primary data access is Supabase's generated REST/Realtime interface, governed entirely by RLS (see `docs/DATABASE.md`). Anything that needs server-side logic beyond row access (recommendation ranking, AI orchestration) is a Supabase Edge Function or equivalent stateless service, called by the client the same way as any REST endpoint — the client never embeds business logic that should live server-side and be shared across platforms.

### 2.1 Shared Central Food Catalog contract

The authoritative catalog lives in the separate Mizzz Supabase project and extends Mizzz's existing `catalog.items` model. Miz AI does not duplicate those rows in its own Supabase project and its Flutter client does not connect to the Mizzz database. The Miz AI backend may consume two versioned, bounded PostgREST RPC endpoints exposed by Mizzz:

- `food_catalog_v1_search(p_query, p_language_code, p_item_type, p_limit)` returns at most 50 verified, non-archived candidates after exact-name, verified-alias, translation, full-text, trigram, and optional server-side vector ranking.
- `food_catalog_v1_detail(p_food_id, p_language_code)` returns one verified safe-to-publish detail object and controlled dietary status values. Absence means unknown/not public, never “safe.”

Both run as invoker and remain subject to Mizzz RLS. Any Miz AI integration must call them server-side over HTTPS using only the lowest-privilege project credential required for public reads. Search/OCR/user/AI inputs enter controlled observation or search-event RPCs and never write trusted records. Mutation, proposals, review, merges, embedding workers, imports, and audit remain backend/admin contracts and are not exposed as Gemini tools. This database contract is prepared; a Miz AI repository/tool adapter is not enabled until a milestone explicitly wires and tests the cross-project HTTP call.

## 3. AI integration — Gemini via the `miz-ai` Edge Function

### 3.1 Abstraction

`features/conversation/domain/conversation_service.dart` defines the only interface the chat feature depends on:

```dart
abstract interface class ConversationService {
  Future<ConversationReply> respond(ConversationRequest request);
}
```

`features/conversation/data/miz_ai_service.dart` (`MizAiService`) implements it by calling the `miz-ai` Supabase Edge Function through `supabase_flutter`'s `FunctionsClient` — **never** Gemini or Google Places directly from Flutter, and neither `GEMINI_API_KEY` nor `GOOGLE_PLACES_API_KEY` ever reaches the client. This indirection exists so a provider or model change is a single-file swap on the Edge Function side, never a feature-level Flutter rewrite (see `docs/DECISIONS.md`). `UnavailableConversationService` remains the default adapter whenever Supabase isn't configured (local/offline/test builds), so the honest-unavailable behavior documented below is preserved exactly as before this integration.

### 3.2 Request/response contract

`ConversationRequest`: `message`, bounded `history` (capped client-side, re-capped server-side), optional `location` (precise device coordinates, read transiently and never persisted — see `docs/SECURITY.md`), optional `selectedCity` (name + known coordinates, from the existing city picker), `locale`, and an optional `foodProfileContext` — a minimized summary the client computes from the **local, not-yet-Supabase-synced** Food Profile database (`buildFoodProfileAiContext`, `features/food_profile/domain/food_profile_ai_context.dart`). The Edge Function re-validates/clamps this context rather than trusting it verbatim (`supabase/functions/miz-ai/food_profile.ts`) — see §3.5.

`ConversationReply`: `text`, `places` (typed `AiPlace` results, never fabricated — see §3.4), `toolExecutions` (internal-only, never rendered to the user), `requiresLocation`, `requiresClarification`/`clarificationQuestion` (currently surfaced as normal assistant text — Gemini's own clarifying questions are plain conversational replies, not a distinct structured mode), and `conversationId`.

Completed/displayed threads are archived independently through `ConversationHistoryRepository` into local Drift storage when the user opens History, starts a new chat, or leaves the route. This archive is not a backend API and is never sent wholesale to `miz-ai`; only the active controller's bounded history remains part of an individual `ConversationRequest`.

The UI (`ConversationPage`) renders `text` as a normal message bubble, `places` as result cards under it, and reacts to `requiresLocation` with a dedicated "choose a location" card that reuses the existing city picker (`AppRoutes.city`) — it never parses free text to decide what to show beyond that one structured flag.

### 3.3 Edge Function architecture (`supabase/functions/miz-ai/`)

Gemini's **Interactions API** (`POST https://generativelanguage.googleapis.com/v1beta/interactions`) is used — the current officially recommended approach for new function-calling work, verified against live docs rather than assumed. The model is configurable via the `GEMINI_MODEL` secret/env var; unset, it defaults to `gemini-3.6-flash` (a current, non-preview Flash model appropriate for low-latency text + function calling).

The trust boundary is strict: **Gemini proposes a function call (name + arguments); it never executes anything.** `supabase/functions/miz-ai/gemini_loop.ts` runs the bounded (max 3 rounds, `TOOL_LOOP_LIMIT` beyond that) send → inspect → validate+execute → continue loop. The only supported names are `search_nearby_places` and `get_user_food_profile`. Every name is checked against that fixed allowlist and every argument is strictly validated for required fields, types, enums, lengths, ranges, duplicates, and unknown properties before execution. Unknown tools and invalid arguments become safe `function_result` errors that Gemini may recover from; they never reach Google and never crash the request. Trusted location (from `request.location` or a known-city lookup) is injected by the server itself; the search schema has no latitude/longitude field at all.

Gemini is treated as an unreliable provider. Each interaction attempt is bounded to 35 seconds and may retry once only for timeout, network failure, or provider 5xx; the first retry uses only the current message instead of full history. Google Places uses a separate 12-second attempt deadline with the same single transient retry. Every provider/tool call shares a 58-second total request deadline, Gemini output is capped at 1,024 tokens, Places results at 10, history at 12 turns, and tool rounds at 3. Authentication, validation, permission, quota/rate-limit, and other non-transient failures are never retried. Provider responses are runtime-validated before the loop reads them, and validated Places data is returned as partial success if final narration fails. When typed place cards exist, model-authored place narration is discarded entirely so unsupported embellishments cannot accompany provider-grounded results.

Location ownership is explicit: Flutter alone requests permission and obtains GPS or a selected city; the backend alone calls Places; Gemini receives only whether trusted location exists. With no location it is instructed to emit a private sentinel that the backend converts to `requiresLocation=true`. If it instead invents `get_user_location`, `request_location`, `access_gps`, or `get_current_position`, the loop still converts that attempt to the same structured location flow.

Two tools ship now:

- **`search_nearby_places`** — real Google Places (New) results via `places_client.ts` (`searchNearby` for type-only queries, `searchText` when a free-text `query` is given), with an explicit field mask, clamped radius/rating/result-count, and normalized output. Never returns the Google API key or a raw provider error.
- **`get_user_food_profile`** — returns only the requested sections of the server-revalidated `foodProfileContext`, never precise location, never raw interaction history.

Architected for (not built until needed): `get_restaurant_details`, `get_restaurant_menu`, `search_food`, `analyze_food_image`, `analyze_restaurant_menu`, `save_bookmark`, `create_reservation` — the same allowlist/validate/dispatch pattern extends to each without touching `gemini_loop.ts`.

### 3.4 Food safety in AI-driven recommendations

Gemini never functions as the allergy/restriction filter. `TrustedFoodProfileContext` keeps allergies, intolerances, strict restrictions, and personal dislikes on fully separate fields end-to-end (mirroring `FoodEligibilityService`'s axes in the local Food Profile — see `docs/DATABASE.md`); the system instruction (`system_instruction.ts`) explicitly forbids inventing place data, claiming allergy safety on missing ingredient data, or inferring religion/ethnicity/health/nationality from food preferences. A future recommendation pipeline still runs candidates through the deterministic `FoodEligibilityService` before Gemini ranks/explains them — Gemini explains and ranks, it does not decide safety.

### 3.5 Extension points (architected now, not built until their milestone)

| Capability | Where it plugs in | Status |
|---|---|---|
| Function calling | `supabase/functions/miz-ai/tools.ts` allowlist + dispatch | **implemented** (`search_nearby_places`, `get_user_food_profile`) |
| More tools | same allowlist/validate/dispatch pattern | architected, listed above, not built |
| Structured outputs | `MizAiResponse` is already a typed, validated shape | implemented for the chat contract itself |
| Voice | new `ai/voice/` adapter feeding a future provider-agnostic client | not implemented (UI shows disabled mic per `docs/DESIGN.md`) |
| Realtime API | alternate transport instead of request/response | not implemented |
| RAG | a retrieval step composed before the Gemini call, adding context to the request | not implemented |
| Vision | `CameraAnalysisService`; food/menu photos go only to `analyze-food`/`analyze-menu`; live Miz QR decoding is local and trusted verification remains remote-only | Food/menu analysis and QR decoding implemented; trusted QR verification not implemented |
| MCP | a tool-registration layer alongside the existing allowlist | not implemented |
| Multi-provider | swapping `gemini_client.ts` for another provider behind the same `ConversationService`/Edge Function boundary | not implemented, architecture supports it |

Do not build any row in this table until a milestone explicitly requires it (`CLAUDE.md` §11).

## 4. Camera, OCR, and Miz QR contracts

The client owns only device capture workflow and local validation. `CameraCaptureService` uses the native camera/photo picker after an explicit tap, recovers interrupted Android picker results, and treats camera files as temporary while never deleting a gallery original. Menu mode accepts one to four JPEG, PNG, WebP, HEIC, or HEIF pages; each image is limited to 3 MiB and the raw total to 8 MiB before encoding.

`CameraAnalysisService.analyzeMenu` sends the confirmed temporary pages and requested locale to the `analyze-menu` Edge Function. Flutter never calls Gemini directly. The function validates the request again, sends a prompt-before-images multimodal interaction, requests a shallow schema-constrained JSON object with delimiter-safe flat dish records, then decodes, semantically validates, and bounds every result field before returning `MenuAnalysisResult` with sections, dish explanations, printed prices, dietary tags, possible-allergen warnings, confidence, and notes. Malformed individual dish records are discarded without failing an otherwise usable menu. Images are inline request data, are not written to Storage/database, use provider interaction storage disabled, and are excluded from logs. Trusted Miz QR verification still reports unavailable rather than fabricating trust.

`CameraAnalysisService.recognizeFood` sends one explicitly confirmed temporary image and locale to `analyze-food`. The same client/server MIME and size limits apply. The server returns at most three typed name/description/confidence candidates and an overview; malformed candidates are dropped. The prompt and UI explicitly forbid interpreting appearance as confirmed ingredients, nutrition, restaurant source, or allergy safety. The image is inline, never stored, excluded from logs, and provider interaction storage is disabled.

Miz QR local format is `miz://v1/{restaurant|table}/{public_token}?exp=…&sig=…`. The client validates scheme/version/scope, bounded public-token/signature shape, and expiry. It never treats local validation as authenticity: the backend verifies the signature, publication status, branch/table status, and session permission before returning a typed navigation target. Arbitrary URLs and internal database identifiers are rejected.

## 5. Error contract

Repositories map their underlying exceptions to typed, feature-scoped exceptions before returning to `domain`/`presentation`. Presentation never catches raw Supabase/provider exceptions. A failed `miz-ai` call returns `success:false`, `errorCode`, localized-safe `userMessage`, `retryAvailable`, and `technicalMessage:null`; raw provider bodies, tool arguments, stack traces, and credentials are never returned. Stable codes are `AI_TIMEOUT`, `AI_UNAVAILABLE`, `AI_RATE_LIMIT`, `AI_CONFIGURATION_ERROR`, `AI_QUOTA_EXCEEDED` (legacy compatibility), `PLACES_TIMEOUT`, `PLACES_UNAVAILABLE`, `PLACES_CONFIGURATION_ERROR`, `PLACES_QUOTA_EXCEEDED`, `LOCATION_REQUIRED`, `NO_RESULTS`, `INVALID_TOOL_CALL`, `INVALID_TOOL_ARGUMENTS`, `TOOL_LOOP_LIMIT`, `SERVER_ERROR`, and `INVALID_REQUEST`. Flutter maps these into distinct timeout, busy, Places unavailable, no-results, location, temporarily unavailable, and generic retry states instead of one catch-all card.

## 6. Versioning

Any Edge Function / custom endpoint is versioned in its path (`/v1/...`). Breaking changes get a new version rather than mutating `/v1` under existing clients, since mobile clients can't force-upgrade instantly.
