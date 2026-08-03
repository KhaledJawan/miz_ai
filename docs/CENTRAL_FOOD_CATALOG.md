# Shared Central Food Catalog — Miz AI Contract

Related: [`API.md`](API.md), [`ARCHITECTURE.md`](ARCHITECTURE.md), [`DATABASE.md`](DATABASE.md), and [`SECURITY.md`](SECURITY.md).

## Verified ownership decision

The read-only audit covered both accessible Supabase projects and both source repositories before SQL was created:

- The linked `miz_ai` project has no application tables or remote migration history. It owns the deployed `miz-ai`, `analyze-menu`, and `analyze-food` functions.
- The separate active `Mizzz Project` already owns the real restaurant/menu schema and an existing production `catalog` schema created by Mizzz phases 49–52.
- The Mizzz catalog already uses `catalog.items`, translations, aliases, categories, allergens, dietary tags, images, candidates, strict RLS, and public RPC wrappers. `public.menu_items.catalog_item_id` already points to the catalog.

Therefore the one trusted catalog remains in Mizzz. It is not duplicated in `miz_ai`, and the Miz AI Flutter client is not linked to Mizzz's database. The earlier alternative of creating a second `foods` schema in `miz_ai` was rejected after the cross-project audit because it would create two sources of truth and conflict with the existing Mizzz catalog.

## Miz AI integration boundary

Mizzz's additive catalog v2 SQL exposes two bounded read RPCs:

- `food_catalog_v1_search(p_query, p_language_code, p_item_type, p_limit)`
- `food_catalog_v1_detail(p_food_id, p_language_code)`

They are versioned PostgREST/HTTPS contracts, run as invoker, and return only verified, non-archived rows permitted by RLS. A future Miz AI backend adapter may call these endpoints with the lowest-privilege public credential; no Mizzz credential enters Flutter.

The database migrations also provide controlled observation, search-event, proposal, trust, review, merge, import, embedding, image, audit, and retention functions. Those mutation/admin functions are not Gemini tools and are not callable from the Miz AI client. OCR, menu scans, user queries, external data, and AI results can only enter staging; they never modify trusted foods directly.

## Current implementation status

- Mizzz source now contains phases 56–61 plus the phase-62 transactional SQL regression suite and structured JSON import example.
- The existing Phase-49 tables and RPC signature are preserved; `catalog.items` is extended rather than duplicated as `foods`.
- Existing Mizzz prices, availability, stock, names, descriptions, categories, variants, add-ons, images, and restaurant allergens remain tenant-owned.
- The migrations were validated in order against a disposable PostgreSQL cluster and the SQL suite passed. They were not pushed to production.
- Miz AI's HTTP repository/tool adapter is intentionally not activated until the Mizzz migrations are reviewed and deployed to staging/production.

The authoritative schema mapping, per-phase changes, rollback guidance, risks, retention policy, and deployment gates live in Mizzz's `docs/CENTRAL_FOOD_CATALOG.md` beside the migrations.

## Non-negotiable safety rules

- No direct user, restaurant, OCR, external API, or AI write to trusted catalog tables.
- No automatic allergen, halal, alcohol, vegan/vegetarian, calorie, origin, canonical-name, merge, or trusted-image decision.
- Repeated input from one source increases occurrences, not independent-source count.
- Verified foods are archived/versioned, not silently overwritten or automatically merged.
- Search stays database-first and returns a small shortlist; the full catalog is never sent to Gemini.
- Embeddings are queued on accepted content-version changes, never generated on each search, and the provider remains replaceable.
- Images are private until licensed, moderated, and verified.

