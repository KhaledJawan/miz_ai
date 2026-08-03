begin;

create type catalog.observation_source_type as enum (
  'restaurant_menu',
  'menu_scan',
  'ocr',
  'user_search',
  'user_submission',
  'ai_detection',
  'admin_import',
  'external_api',
  'restaurant_owner',
  'staff_entry'
);

create type catalog.observation_status as enum (
  'pending',
  'grouped',
  'matched',
  'enrichment_candidate',
  'new_food_candidate',
  'rejected',
  'approved',
  'archived'
);

create type catalog.proposal_type as enum (
  'add_alias',
  'add_translation',
  'update_description',
  'add_ingredient',
  'update_ingredient',
  'add_allergen',
  'update_allergen',
  'update_cuisine',
  'update_country',
  'update_category',
  'add_image',
  'replace_image',
  'merge_foods',
  'create_food',
  'archive_food',
  'increase_popularity',
  'attach_evidence'
);

create type catalog.proposal_status as enum (
  'pending',
  'auto_approved',
  'approved',
  'rejected',
  'needs_more_evidence',
  'applied',
  'failed'
);

create type catalog.risk_level as enum ('low', 'medium', 'high', 'critical');

create type catalog.candidate_decision as enum ('match', 'enrich', 'create', 'reject');

create type catalog.merge_candidate_status as enum (
  'pending',
  'approved',
  'rejected',
  'merged',
  'archived'
);

create type catalog.embedding_job_status as enum (
  'pending',
  'processing',
  'completed',
  'failed',
  'cancelled'
);

create type catalog.image_moderation_status as enum (
  'pending',
  'approved',
  'rejected',
  'needs_review'
);

create type catalog.image_verification_status as enum (
  'unverified',
  'verified',
  'disputed',
  'archived'
);

create table catalog.source_registry (
  id uuid primary key default gen_random_uuid(),
  source_type catalog.observation_source_type not null,
  source_key_hash text not null,
  display_label text,
  reliability_score numeric(5,4) not null default 0.5 check (reliability_score between 0 and 1),
  is_blocked boolean not null default false,
  blocked_reason text,
  blocked_by uuid references auth.users(id) on delete set null,
  blocked_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (source_type, source_key_hash),
  constraint source_hash_format check (source_key_hash ~ '^[a-f0-9]{64}$'),
  constraint source_block_consistency check (
    (not is_blocked and blocked_at is null)
    or (is_blocked and blocked_at is not null and blocked_reason is not null)
  )
);

create table catalog.restaurant_source_access (
  id uuid primary key default gen_random_uuid(),
  integration_key text not null check (integration_key ~ '^[a-z][a-z0-9_-]{1,63}$'),
  external_restaurant_id text not null check (char_length(external_restaurant_id) between 1 and 160),
  user_id uuid not null references auth.users(id) on delete cascade,
  can_submit_observations boolean not null default true,
  verified_at timestamptz not null,
  verified_by uuid references auth.users(id) on delete set null,
  revoked_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (integration_key, external_restaurant_id, user_id)
);

create table catalog.food_observations (
  id uuid primary key default gen_random_uuid(),
  dedup_key text not null unique check (dedup_key ~ '^[a-f0-9]{64}$'),
  raw_name text not null check (char_length(raw_name) between 1 and 240),
  raw_description text check (raw_description is null or char_length(raw_description) <= 4000),
  raw_ingredients jsonb not null default '[]'::jsonb check (jsonb_typeof(raw_ingredients) = 'array'),
  raw_category text check (raw_category is null or char_length(raw_category) <= 160),
  raw_language text check (raw_language is null or raw_language ~ '^[a-z]{2,3}(?:-[A-Z]{2})?$'),
  raw_image_path text,
  primary_source_type catalog.observation_source_type not null,
  primary_source_id text,
  integration_key text,
  external_restaurant_id text,
  external_menu_item_id text,
  submitted_by uuid references auth.users(id) on delete set null,
  normalized_name text not null,
  detected_language text check (detected_language is null or detected_language ~ '^[a-z]{2,3}(?:-[A-Z]{2})?$'),
  detected_cuisine_id uuid references catalog.cuisines(id) on delete set null,
  possible_food_id uuid references catalog.foods(id) on delete set null,
  match_confidence numeric(5,4) check (match_confidence between 0 and 1),
  occurrence_count bigint not null default 1 check (occurrence_count > 0),
  independent_source_count integer not null default 1 check (
    independent_source_count > 0 and independent_source_count <= occurrence_count
  ),
  first_seen_at timestamptz not null default now(),
  last_seen_at timestamptz not null default now(),
  status catalog.observation_status not null default 'pending',
  spam_score numeric(5,4) not null default 0 check (spam_score between 0 and 1),
  junk_score numeric(5,4) not null default 0 check (junk_score between 0 and 1),
  trust_score numeric(5,2) not null default 0 check (trust_score between 0 and 100),
  review_notes text,
  decision catalog.candidate_decision,
  decision_explanation text,
  resolved_at timestamptz,
  retention_until timestamptz not null default (now() + interval '730 days'),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table catalog.food_observation_sources (
  id uuid primary key default gen_random_uuid(),
  observation_id uuid not null references catalog.food_observations(id) on delete cascade,
  source_registry_id uuid not null references catalog.source_registry(id) on delete restrict,
  occurrence_count bigint not null default 1 check (occurrence_count > 0),
  first_seen_at timestamptz not null default now(),
  last_seen_at timestamptz not null default now(),
  evidence jsonb not null default '{}'::jsonb check (jsonb_typeof(evidence) = 'object'),
  unique (observation_id, source_registry_id)
);

create table catalog.food_search_events (
  id bigint generated always as identity primary key,
  normalized_query text not null check (char_length(normalized_query) between 1 and 240),
  original_query text not null check (char_length(original_query) between 1 and 500),
  language_code text check (language_code is null or language_code ~ '^[a-z]{2,3}(?:-[A-Z]{2})?$'),
  result_count integer not null default 0 check (result_count >= 0),
  selected_food_id uuid references catalog.foods(id) on delete set null,
  selected_integration_key text,
  selected_external_menu_item_id text,
  looks_like_food_name boolean not null default false,
  classification_confidence numeric(5,4) not null default 0 check (classification_confidence between 0 and 1),
  user_id uuid references auth.users(id) on delete set null,
  anonymous_session_hash text check (
    anonymous_session_hash is null or anonymous_session_hash ~ '^[a-f0-9]{64}$'
  ),
  promoted_observation_id uuid references catalog.food_observations(id) on delete set null,
  created_at timestamptz not null default now(),
  retention_until timestamptz not null default (now() + interval '90 days')
);

create table catalog.food_change_proposals (
  id uuid primary key default gen_random_uuid(),
  food_id uuid references catalog.foods(id) on delete restrict,
  observation_id uuid references catalog.food_observations(id) on delete set null,
  proposal_type catalog.proposal_type not null,
  proposed_changes jsonb not null check (jsonb_typeof(proposed_changes) = 'object'),
  previous_values jsonb not null default '{}'::jsonb check (jsonb_typeof(previous_values) = 'object'),
  evidence jsonb not null default '[]'::jsonb check (jsonb_typeof(evidence) = 'array'),
  confidence numeric(5,4) not null check (confidence between 0 and 1),
  risk_level catalog.risk_level not null,
  status catalog.proposal_status not null default 'pending',
  auto_approval_rule text,
  created_by uuid references auth.users(id) on delete set null,
  reviewed_by uuid references auth.users(id) on delete set null,
  reviewed_at timestamptz,
  rejection_reason text,
  failure_reason text,
  applied_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint proposal_food_presence check (
    (proposal_type = 'create_food' and food_id is null)
    or (proposal_type <> 'create_food' and food_id is not null)
  )
);

alter table catalog.food_versions
  add constraint food_versions_proposal_id_fkey
  foreign key (proposal_id) references catalog.food_change_proposals(id) on delete set null;

alter table catalog.food_audit_log
  add constraint food_audit_log_proposal_id_fkey
  foreign key (proposal_id) references catalog.food_change_proposals(id) on delete set null;

alter table catalog.food_redirects
  add constraint food_redirects_proposal_id_fkey
  foreign key (proposal_id) references catalog.food_change_proposals(id) on delete set null;

create table catalog.food_decisions (
  id uuid primary key default gen_random_uuid(),
  observation_id uuid not null references catalog.food_observations(id) on delete restrict,
  decision catalog.candidate_decision not null,
  food_id uuid references catalog.foods(id) on delete set null,
  proposal_id uuid references catalog.food_change_proposals(id) on delete set null,
  trust_score numeric(5,2) not null check (trust_score between 0 and 100),
  explanation text not null,
  decided_by uuid references auth.users(id) on delete set null,
  decided_at timestamptz not null default now(),
  unique (observation_id)
);

create table catalog.food_merge_candidates (
  id uuid primary key default gen_random_uuid(),
  food_id_a uuid not null references catalog.foods(id) on delete cascade,
  food_id_b uuid not null references catalog.foods(id) on delete cascade,
  similarity_score numeric(5,4) not null check (similarity_score between 0 and 1),
  similarity_components jsonb not null check (jsonb_typeof(similarity_components) = 'object'),
  explanation text not null,
  status catalog.merge_candidate_status not null default 'pending',
  reviewed_by uuid references auth.users(id) on delete set null,
  reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint merge_candidate_order check (food_id_a < food_id_b),
  unique (food_id_a, food_id_b)
);

create table catalog.food_embedding_jobs (
  id uuid primary key default gen_random_uuid(),
  food_id uuid not null references catalog.foods(id) on delete cascade,
  reason text not null,
  content_hash text not null check (content_hash ~ '^[a-f0-9]{64}$'),
  provider text,
  model text,
  status catalog.embedding_job_status not null default 'pending',
  attempt_count smallint not null default 0 check (attempt_count between 0 and 10),
  available_at timestamptz not null default now(),
  locked_at timestamptz,
  locked_by text,
  completed_at timestamptz,
  last_error_code text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create unique index food_embedding_jobs_open_uq
  on catalog.food_embedding_jobs (food_id, content_hash)
  where status in ('pending', 'processing');

create table catalog.food_images (
  id uuid primary key default gen_random_uuid(),
  food_id uuid not null references catalog.foods(id) on delete cascade,
  storage_path text not null unique check (storage_path ~ '^foods/[0-9a-f-]{36}/[^/]+$'),
  variant text not null check (variant in ('original', 'medium', 'thumbnail')),
  source text not null,
  license text not null,
  attribution text,
  uploaded_by uuid references auth.users(id) on delete set null,
  moderation_status catalog.image_moderation_status not null default 'pending',
  verification_status catalog.image_verification_status not null default 'unverified',
  image_hash text check (image_hash is null or image_hash ~ '^[a-f0-9]{64}$'),
  width integer check (width is null or width > 0),
  height integer check (height is null or height > 0),
  file_size_bytes bigint check (file_size_bytes is null or file_size_bytes > 0),
  mime_type text check (mime_type is null or mime_type in ('image/webp', 'image/jpeg', 'image/png')),
  reviewed_by uuid references auth.users(id) on delete set null,
  reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  archived_at timestamptz,
  unique (food_id, variant, image_hash)
);

create table catalog.catalog_menu_item_links (
  id uuid primary key default gen_random_uuid(),
  integration_key text not null check (integration_key ~ '^[a-z][a-z0-9_-]{1,63}$'),
  external_restaurant_id text not null check (char_length(external_restaurant_id) between 1 and 160),
  external_menu_item_id text not null check (char_length(external_menu_item_id) between 1 and 160),
  food_id uuid not null references catalog.foods(id) on delete restrict,
  match_confidence numeric(5,4) not null check (match_confidence between 0 and 1),
  match_source text not null,
  match_status text not null check (match_status in ('suggested', 'confirmed', 'rejected', 'stale')),
  matched_at timestamptz not null default now(),
  matched_by uuid references auth.users(id) on delete set null,
  source_name_snapshot text not null check (char_length(source_name_snapshot) between 1 and 240),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (integration_key, external_menu_item_id)
);

create table catalog.food_import_batches (
  id uuid primary key default gen_random_uuid(),
  source_name text not null,
  source_version text,
  source_url text check (source_url is null or source_url ~ '^https://'),
  license text not null,
  content_hash text not null unique check (content_hash ~ '^[a-f0-9]{64}$'),
  dry_run boolean not null default true,
  status text not null check (status in ('validating', 'validated', 'staging', 'staged', 'failed', 'rolled_back')),
  record_count integer not null default 0 check (record_count >= 0),
  accepted_count integer not null default 0 check (accepted_count >= 0),
  rejected_count integer not null default 0 check (rejected_count >= 0),
  created_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  completed_at timestamptz
);

create table catalog.food_import_errors (
  id bigint generated always as identity primary key,
  batch_id uuid not null references catalog.food_import_batches(id) on delete cascade,
  record_index integer not null check (record_index >= 0),
  record_key text,
  error_code text not null,
  error_message text not null,
  created_at timestamptz not null default now()
);

alter table catalog.food_observations
  add column import_batch_id uuid references catalog.food_import_batches(id) on delete set null;
alter table catalog.food_change_proposals
  add column import_batch_id uuid references catalog.food_import_batches(id) on delete set null;

create trigger source_registry_touch_updated_at
before update on catalog.source_registry
for each row execute function catalog.touch_updated_at();

create trigger restaurant_source_access_touch_updated_at
before update on catalog.restaurant_source_access
for each row execute function catalog.touch_updated_at();

create trigger food_observations_touch_updated_at
before update on catalog.food_observations
for each row execute function catalog.touch_updated_at();

create trigger food_change_proposals_touch_updated_at
before update on catalog.food_change_proposals
for each row execute function catalog.touch_updated_at();

create trigger food_merge_candidates_touch_updated_at
before update on catalog.food_merge_candidates
for each row execute function catalog.touch_updated_at();

create trigger food_embedding_jobs_touch_updated_at
before update on catalog.food_embedding_jobs
for each row execute function catalog.touch_updated_at();

create trigger food_images_touch_updated_at
before update on catalog.food_images
for each row execute function catalog.touch_updated_at();

create trigger catalog_menu_item_links_touch_updated_at
before update on catalog.catalog_menu_item_links
for each row execute function catalog.touch_updated_at();

comment on table catalog.food_observations is
  'Deduplicated untrusted candidate groups; never treated as trusted catalog rows.';
comment on table catalog.food_observation_sources is
  'Independent-source evidence. Repetition from one source does not increase independence.';
comment on table catalog.food_search_events is
  'Privacy-minimized search telemetry, separate from candidate observations.';
comment on table catalog.catalog_menu_item_links is
  'Opaque API linkage to external Mizzz menu items; no cross-database foreign key.';

commit;
