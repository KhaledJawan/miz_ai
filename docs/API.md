# API Contracts — Miz

Related: [`docs/ARCHITECTURE.md`](ARCHITECTURE.md), [`docs/DATABASE.md`](DATABASE.md), [`AGENTS.md`](../AGENTS.md) (AI Agent, Backend Agent).

## 1. Mizzz independence

Miz and Mizzz are separate Merlin ICT products with separate data stores. Miz's client and backend logic **never** query Mizzz's database directly — the only allowed integration surface is a versioned HTTP API that Mizzz exposes and Miz consumes as a client, identical in trust level to any third-party API. If a future feature needs Mizzz data, it gets a named contract here before implementation, not an ad-hoc database link.

## 2. Internal API surface (Miz backend ↔ Miz client)

Primary data access is Supabase's generated REST/Realtime interface, governed entirely by RLS (see `docs/DATABASE.md`). Anything that needs server-side logic beyond row access (recommendation ranking, AI orchestration) is a Supabase Edge Function or equivalent stateless service, called by the client the same way as any REST endpoint — the client never embeds business logic that should live server-side and be shared across platforms.

## 3. AI integration — OpenAI Responses API

### 3.1 Abstraction

`ai/core/ai_client.dart` defines the only interface features are allowed to depend on:

```dart
abstract class AiClient {
  Future<AiResponse> respond(AiRequest request);
}
```

`ai/openai/openai_responses_client.dart` implements it against the OpenAI Responses API. This indirection exists so a provider or model change is a single-file swap, never a feature-level rewrite (see `docs/DECISIONS.md`).

### 3.2 Current contract (Milestone 7 scope — not implemented in Milestone 1)

`AiRequest`: conversation context (Summary Chips so far, free-text input if any, user preference snapshot, location if granted).

`AiResponse`: a typed, validated payload — never raw text handed to the UI. Minimum shape:

```dart
class AiResponse {
  final UiMode mode;          // enum mirroring docs/DESIGN.md §3's screen modes
  final Map<String, dynamic> payload; // mode-specific, validated against a schema per mode
  final String? assistantNote; // optional short human-readable line, not the primary UI
}
```

The UI layer switches on `mode` and renders the corresponding screen/widget tree with `payload` — it never parses free text to decide what to show. Before Milestone 7, this same `AiResponse` shape is produced by the scripted `FLOW`-based logic (Milestone 2), so the eventual AI swap doesn't change any presentation code.

### 3.3 Extension points (architected now, not built until their milestone)

| Capability | Where it plugs in | Status |
|---|---|---|
| Function calling | `AiRequest.tools` (empty for now) | not implemented |
| Structured outputs | `AiResponse.payload` already assumes a schema-validated shape; formalize with the Responses API's structured-output mode when implemented | partially prepared |
| Voice | new `ai/voice/` adapter feeding the same `AiClient` | not implemented (UI shows disabled mic per `docs/DESIGN.md`) |
| Realtime API | alternate `AiClient` implementation using a streaming transport instead of request/response | not implemented |
| RAG | a retrieval step composed before `AiClient.respond` is called, adding context to `AiRequest` | not implemented |
| Vision | `AiRequest.attachments` (empty for now); UI shows disabled camera per `docs/DESIGN.md` | not implemented |
| MCP | an `AiClient` variant or tool-registration layer that lets the model call registered MCP tools | not implemented |
| Multi-provider | any other `AiClient` implementation (e.g. `ai/anthropic/`) selected via the same provider seam | not implemented, architecture supports it |

Do not build any row in this table until a milestone explicitly requires it (`CLAUDE.md` §11).

## 4. Error contract

All repositories (Supabase- or AI-backed) map their underlying exceptions to `core/error/failures.dart` types before returning to `domain`/`presentation`. Presentation code never catches `DioException`, `PostgrestException`, or an OpenAI SDK exception directly — only domain `Failure` types. This keeps UI error-handling uniform regardless of which backend produced the error.

## 5. Versioning

Any Edge Function / custom endpoint is versioned in its path (`/v1/...`). Breaking changes get a new version rather than mutating `/v1` under existing clients, since mobile clients can't force-upgrade instantly.
