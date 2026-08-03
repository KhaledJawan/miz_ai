# Database — Miz (Supabase / Postgres)

Related: [`docs/ARCHITECTURE.md`](ARCHITECTURE.md) §6–7, [`docs/SECURITY.md`](SECURITY.md), [`AGENTS.md`](../AGENTS.md) (Supabase Agent, Database Agent). For the local Food Preference Profile database, see "Local database (Drift)" below.

This is the target schema for when features move off mock data (Milestone 6 onward). A live Supabase project is now configured at build time and the Flutter client initializes it, but the schema below has not been claimed as provisioned or production-ready. No feature may query a table until its migration and explicit RLS policies are reviewed. Table shapes are derived directly from the entities the approved prototype already uses, so the mock repositories in early milestones map cleanly onto these tables later.

The shared Central Food Catalog is intentionally not duplicated in this Miz database. Mizzz owns the existing canonical `catalog.items` schema and its controlled observation/proposal/audit pipeline. Miz AI accesses only verified, non-archived records through the versioned server-side HTTP/RPC contract documented in `docs/API.md` §2.1; neither this Flutter client nor local Drift writes the trusted catalog.

## Conventions

- Every table has `id uuid primary key default gen_random_uuid()`, `created_at timestamptz default now()`, `updated_at timestamptz default now()`.
- Every table enables Row Level Security. No table ships without a policy.
- Money stored as integer cents (`price_cents`), never floats.
- Foreign keys `on delete cascade` where the child has no meaning without the parent (e.g. `order_items` without `orders`); `on delete set null` where it does (e.g. a review surviving a deleted menu item reference).

## Core tables

### `profiles`
Extends Supabase `auth.users` 1:1.
| column | type | notes |
|---|---|---|
| `id` | uuid, PK, FK → `auth.users.id` | |
| `display_name` | text | |
| `avatar_url` | text | nullable |
| `language` | text | default `'en'`; supported initially: `en`, `fa`, `de` |
| `dark_mode` | boolean | default `false`; UI also allows system-follow, see Settings |
| `notifications_enabled` | boolean | default `true` |
| `location_permission_granted` | boolean | default `false` |
| `remember_preferences` | boolean | default `true` |

RLS: user can select/update only their own row.

### `preferences`
Learned/opted-in taste profile (cuisine, budget tier, dietary), separate from `profiles` so it can be cleared independently by "Delete Data" without deleting the account.
| column | type |
|---|---|
| `user_id` | uuid, FK → `profiles.id`, PK |
| `preferred_cuisines` | text[] |
| `budget_tier` | smallint | -- 0=no limit,1..3
| `dietary` | text | 'none'/'veg'/'vegan'/'gf' |

RLS: owner only.

### `restaurants`
| column | type | notes |
|---|---|---|
| `id` | uuid, PK | |
| `name` | text | |
| `cuisine` | text | matches conversation-flow cuisine values |
| `tag` | text | display label, e.g. "Italian" |
| `price_tier` | smallint | 1–3, or 0 = no data |
| `rating` | numeric(2,1) | |
| `lat`, `lng` | double precision | for distance/map queries |
| `hero_image_url` | text | |
| `open_now` | boolean | derived/cached; source of truth is `restaurant_hours` (future) |

RLS: public read (`select` to `anon`/`authenticated`); writes restricted to a service role used only by backend ingestion, never the client.

### `restaurant_photos`
`id`, `restaurant_id` FK, `image_url`, `position`. RLS: public read.

### `menu_items`
| column | type |
|---|---|
| `id` | uuid, PK |
| `restaurant_id` | FK → `restaurants.id` |
| `category` | text | starters/mains/pizza/desserts/drinks |
| `name` | text |
| `price_cents` | integer |
| `image_url` | text, nullable |

RLS: public read.

### `reviews`
`id`, `restaurant_id` FK, `author_name`, `quote`, `rating`, `created_at`. RLS: public read; insert restricted to authenticated users, one review per user per restaurant (unique constraint), update/delete own only.

### `bookmarks`
`user_id` FK, `restaurant_id` FK, composite PK. RLS: owner only (all operations).

### `recent_searches`
`id`, `user_id` FK, `query_summary` (text — the collapsed chip summary, e.g. "Italian · €€ · Nearby"), `filters_json` jsonb, `created_at`. RLS: owner only. Also mirrored into the offline Drift cache (see `docs/ARCHITECTURE.md` §6).

### `conversation_summaries`
Persisted Summary Chip sessions, so a completed flow can be revisited/offline-cached.
`id`, `user_id` FK, `chips_json` jsonb (ordered chip key/label pairs), `result_mode` text, `created_at`. RLS: owner only.

### `reservations`
| column | type |
|---|---|
| `id` | uuid, PK |
| `user_id` | FK → `profiles.id` |
| `restaurant_id` | FK → `restaurants.id` |
| `reservation_date` | date |
| `reservation_time` | time |
| `guest_count` | smallint |
| `status` | text | 'confirmed'/'cancelled' |

RLS: owner only for select/update/delete; insert requires `auth.uid() = user_id`.

### `orders`
| column | type |
|---|---|
| `id` | uuid, PK |
| `user_id` | FK → `profiles.id` |
| `restaurant_id` | FK → `restaurants.id` |
| `fulfilment_mode` | text | 'delivery'/'pickup' |
| `status` | text | 'placed'/'preparing'/'on_the_way'/'delivered' |
| `total_cents` | integer |
| `delivery_address` | text, nullable |

RLS: owner only.

### `order_items`
`id`, `order_id` FK (cascade), `menu_item_id` FK, `name_snapshot` text, `price_cents_snapshot` integer, `quantity` smallint. Snapshots protect order history from later menu price changes. RLS: readable/writable only via parent order ownership (policy joins `orders.user_id = auth.uid()`).

## Data deletion (Settings → Delete Data / Delete Account)

- **Delete Data**: clears `preferences`, `recent_searches`, `conversation_summaries`, `bookmarks` for the user; keeps `profiles` and order/reservation history (financial/legal record). Confirm this split with legal before shipping — noted in `docs/DECISIONS.md` as an open item.
- **Delete Account**: cascades through every table with `user_id`/`author` FK to the user, then deletes the `auth.users` row (Supabase handles the `profiles` cascade via the `auth.users` FK). Must be a real cascade, not a soft flag — see `CLAUDE.md` §10.

## Indexing notes (for scale)

- `restaurants (cuisine)`, `restaurants (lat, lng)` (or PostGIS `geography` column + GiST index once location-radius queries are real, not mock).
- `menu_items (restaurant_id, category)`.
- `orders (user_id, created_at desc)`, `reservations (user_id, reservation_date)`.

## Local database (Drift)

Unlike everything above, this is **live today** — `lib/core/database/`, SQLite via `drift`/`sqlite3_flutter_libs`, opened once in `bootstrap.dart` before `runApp` (see `docs/ARCHITECTURE.md` §6). One database backs the Food Preference Profile, local interaction tracking, and unified saved items; there is no second bookmark store. No account/auth exists yet, so every user-owned table carries `local_user_id` (always `kLocalUserId = 1` today — see ADR-013) rather than a Supabase `user_id`, keeping a future multi-account migration additive instead of a rewrite. All enum-shaped columns store the Dart enum's stable `.name` string, never an integer index, so reordering an enum's declaration order can never corrupt stored data.

### Profile & rules
- **`food_profiles`** — one row per local user. `diet_type`, `onboarding_status` (`notStarted`/`inProgress`/`completed`/`skipped`), `onboarding_step`, `onboarding_version`, `personalization_enabled`, `profile_completeness` (0.0–1.0, see `ProfileCompletenessService`), `adventurousness_level`, `preferred_meal_weight`, `budget_level`, `top_priorities` (JSON-encoded list), `completed_at`/`skipped_at`.
- **`food_rules`** (catalog: halal, kosher, no-pork, no-alcohol, no-animal-gelatin, no-beef, no-seafood, no-raw-food, …) + **`user_food_rules`** (`requirement_level`: `required`/`preferred`/`avoid`).
- **`allergens`** (14 EU-common allergens, catalog) + **`user_allergies`** (`allergen_id` nullable — a custom free-text allergy sets `custom_name` instead; `severity`: `mild`/`moderate`/`severe`/`unspecified`; `notes`; `is_active`; `source`: `explicit`/`behavioralInference`).
- **`intolerances`** (catalog: lactose, gluten, fructose, histamine, spicy-sensitivity) + **`user_intolerances`** — structurally identical to allergies but a fully separate concept end-to-end: never merged into `user_allergies`, never read by the same "is this an allergy" check (see "Strict restrictions vs. preferences" in the implementation report).

### Catalogs & preferences
- **`ingredients`** — hierarchical (self-referencing `parent_id`, e.g. `beef` → `meat` → `protein`), with `is_animal_product`/`is_meat`/`is_seafood`/`is_alcohol_related` flags the eligibility engine and diet-adaptive onboarding (`OnboardingDraftState.visibleProteinIngredients`) both read. + **`user_ingredient_preferences`** (`preference_state` + a fully independent `restriction_type` — see below).
- **`cuisines`** (18 seeded) + **`user_cuisine_preferences`** (`preference_state`: `love`/`like`/`neutral`/`dislike`/`curious`/`neverTried`).
- **`flavor_attributes`** (12: sweet, salty, sour, bitter, umami, spicy, smoky, creamy, rich, fresh, crispy, soft) + **`user_flavor_preferences`** (`preference_level` 0–4; `spicy` is presented with dedicated "Not spicy…Very hot" labels, everything else with a generic low→high scale).

### Sample foods & interactions
- **`food_items`** (~24 seeded sample dishes for onboarding's visual selection step, each with a bundled `local_image_asset` — no network fetch) + **`food_item_ingredients`** / **`food_item_allergens`** (join tables with `is_primary`/`may_contain` boolean flags) + **`user_food_item_preferences`**.
- **`user_food_interactions`** — append-only local event log (`event_type`, `entity_type`, `entity_id`, `session_id`, `position_index`, `source_section`, `screen_name`, `search_query`, `dwell_time_ms`, `metadata_json`, `occurred_at`, nullable `synced_at` for future backend sync) written by `InteractionTrackerImpl` (batched, debounced, deduped per session — never a raw insert per widget rebuild).
- **`user_hidden_entities`** — foods/restaurants the user explicitly hid, surfaced back in Settings → Food Profile → Hidden foods.
- **`profile_change_history`** — append-only audit trail of explicit profile edits (`section`, `source`, `changed_at`), not of every keystroke.

### Unified saved items
- **`saved_items`** — schema-v2 local-first bookmarks keyed by (`local_user_id`, `item_type`, `item_id`) with `title`, optional `subtitle`/`image_asset`/`metadata_json`, and `saved_at`. `item_type` supports `restaurant`, `cafe`, `food`, `menuItem`, `discovery`, and `scannedDish`. The unified Bookmarks page and the legacy restaurant favorites controller both use `BookmarkRepository`; no parallel preference/set store exists.
- Conflict rule when remote sync arrives: a local save/remove is applied immediately; queued mutations replay to the authenticated user's server rows. Server state wins on a later full read-sync unless a newer queued local mutation for the same composite key still exists.

### Local conversation archive
- **`conversation_archives`** — schema-v3 offline snapshots keyed by (`local_user_id`, `id`) with a first-user-message `title`, typed `messages_json`, optional backend `remote_conversation_id`, and `created_at`/`updated_at`. A non-empty thread is upserted when the user opens History, starts a new chat, or leaves through system navigation; empty canvases are never stored.
- The JSON payload is owned by `DriftConversationHistoryRepository` and round-trips only typed `ConversationMessage`/`AiPlace` models. Precise device coordinates, food-profile context, provider tool traces, debug errors, and API keys are never persisted in an archive.
- Archives are local-only today. When authenticated sync is introduced, server state wins on a completed read-sync unless a newer local snapshot for the same id is queued; deletion must sync as a tombstone before removing the queue entry.

### The safety-critical separation (`restriction_type` vs. `preference_state`)
Every ingredient/food-rule row carries **two independent axes**, never conflated:
- `preference_state` (`love`/`like`/`neutral`/`dislike`/`curious`/`neverTried`/`unknown`) — taste only, ranking-only, never blocks a food.
- `restriction_type` (`none`/`strictExclude`/`dietaryExclude`/`ethicalExclude`/`religiousExclude`/`intolerance`/`allergy`) — safety/eligibility only. `FoodEligibilityService` (`lib/features/food_profile/domain/food_eligibility_service.dart`) reads *only* this axis (plus the dedicated `user_allergies`/`food_rules` tables) to decide `eligible`/`excluded`/`warning`/`unknown` — a "dislike" can never exclude a food, and an allergy can never be stored as a mere dislike.

### Seeding & migrations
`lib/core/database/seed/seed_runner.dart` runs inside `AppDatabase`'s `onCreate` migration step, wrapped in one transaction and idempotent. Schema v2 creates only `saved_items` and its time index; schema v3 creates only `conversation_archives` and its user/time index, preserving every prior Food Profile and saved-item row. Future bumps follow Drift's stepped `onUpgrade` and must never drop user rows. Existing indexes cover interaction history/entity lookup, ingredient hierarchy, saved-item sorting, and conversation-history sorting.

### Local user model
No login is required to use the app. `kLocalUserId` (`lib/core/database/local_user.dart`) is a fixed constant today; every table's `local_user_id` column exists so that adding real accounts later is a migration (populate real user ids, add a `remote_user_id`/`sync_status` column) rather than a schema rewrite — see ADR-013.
