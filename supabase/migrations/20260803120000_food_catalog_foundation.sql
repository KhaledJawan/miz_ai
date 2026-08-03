begin;

create schema if not exists catalog;

create extension if not exists pgcrypto with schema extensions;
create extension if not exists pg_trgm with schema extensions;
create extension if not exists vector with schema extensions;

create type catalog.food_verification_status as enum (
  'draft',
  'pending_review',
  'verified',
  'disputed',
  'archived'
);

create type catalog.translation_status as enum (
  'unverified',
  'machine_generated',
  'reviewed',
  'verified',
  'rejected'
);

create type catalog.certainty_status as enum (
  'yes',
  'usually',
  'depends_on_recipe',
  'no',
  'unknown'
);

create type catalog.halal_status as enum (
  'halal',
  'usually_halal',
  'depends_on_recipe',
  'not_halal',
  'unknown'
);

create type catalog.serving_temperature as enum (
  'hot',
  'warm',
  'room_temperature',
  'cold',
  'frozen',
  'varies',
  'unknown'
);

create type catalog.ingredient_role as enum (
  'required',
  'typical',
  'optional',
  'garnish',
  'regional_variation'
);

create type catalog.allergen_presence as enum (
  'always',
  'typical',
  'possible',
  'depends_on_recipe',
  'unknown'
);

create type catalog.fact_status as enum (
  'unverified',
  'supported',
  'verified',
  'disputed',
  'rejected',
  'superseded'
);

create or replace function catalog.normalize_food_name(value text)
returns text
language sql
immutable
strict
set search_path = ''
as $$
  select trim(
    both ' '
    from regexp_replace(
      lower(translate(value, 'ـأإآٱةىي', ' ااااهي')),
      '[[:punct:][:space:]]+',
      ' ',
      'g'
    )
  )
$$;

create or replace function catalog.touch_updated_at()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  new.updated_at := statement_timestamp();
  return new;
end;
$$;

create table catalog.settings (
  key text primary key,
  value jsonb not null,
  description text not null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint settings_key_format check (key ~ '^[a-z][a-z0-9_.]{1,79}$')
);

create table catalog.food_types (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique check (slug ~ '^[a-z0-9]+(?:-[a-z0-9]+)*$'),
  name text not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table catalog.preparation_methods (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique check (slug ~ '^[a-z0-9]+(?:-[a-z0-9]+)*$'),
  name text not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table catalog.countries (
  id uuid primary key default gen_random_uuid(),
  iso2 text not null unique check (iso2 ~ '^[A-Z]{2}$'),
  iso3 text unique check (iso3 is null or iso3 ~ '^[A-Z]{3}$'),
  name text not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table catalog.regions (
  id uuid primary key default gen_random_uuid(),
  country_id uuid references catalog.countries(id) on delete restrict,
  code text,
  name text not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique nulls not distinct (country_id, code),
  unique nulls not distinct (country_id, name)
);

create table catalog.cuisines (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique check (slug ~ '^[a-z0-9]+(?:-[a-z0-9]+)*$'),
  name text not null,
  country_id uuid references catalog.countries(id) on delete set null,
  region_id uuid references catalog.regions(id) on delete set null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table catalog.food_categories (
  id uuid primary key default gen_random_uuid(),
  parent_id uuid references catalog.food_categories(id) on delete restrict,
  slug text not null unique check (slug ~ '^[a-z0-9]+(?:-[a-z0-9]+)*$'),
  name text not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint category_not_own_parent check (parent_id is null or parent_id <> id)
);

create table catalog.food_tags (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique check (slug ~ '^[a-z0-9]+(?:-[a-z0-9]+)*$'),
  name text not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table catalog.ingredients (
  id uuid primary key default gen_random_uuid(),
  parent_id uuid references catalog.ingredients(id) on delete restrict,
  canonical_name text not null,
  normalized_name text not null,
  slug text not null unique check (slug ~ '^[a-z0-9]+(?:-[a-z0-9]+)*$'),
  is_animal_product boolean,
  is_meat boolean,
  is_seafood boolean,
  is_alcohol_related boolean,
  verification_status catalog.food_verification_status not null default 'draft',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  archived_at timestamptz,
  constraint ingredient_not_own_parent check (parent_id is null or parent_id <> id),
  constraint ingredient_archive_consistency check (
    (verification_status = 'archived') = (archived_at is not null)
  )
);

create unique index ingredients_normalized_active_uq
  on catalog.ingredients (normalized_name)
  where archived_at is null;

create table catalog.ingredient_translations (
  id uuid primary key default gen_random_uuid(),
  ingredient_id uuid not null references catalog.ingredients(id) on delete cascade,
  language_code text not null check (language_code ~ '^[a-z]{2,3}(?:-[A-Z]{2})?$'),
  localized_name text not null,
  normalized_name text not null,
  status catalog.translation_status not null default 'unverified',
  confidence numeric(5,4) not null default 0 check (confidence between 0 and 1),
  source text,
  verified_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (ingredient_id, language_code)
);

create table catalog.allergens (
  id uuid primary key default gen_random_uuid(),
  code text not null unique check (code ~ '^[a-z][a-z0-9_]{1,63}$'),
  canonical_name text not null,
  description text,
  is_regulated boolean not null default false,
  jurisdiction text,
  verification_status catalog.food_verification_status not null default 'draft',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  archived_at timestamptz,
  constraint allergen_archive_consistency check (
    (verification_status = 'archived') = (archived_at is not null)
  )
);

create table catalog.allergen_translations (
  id uuid primary key default gen_random_uuid(),
  allergen_id uuid not null references catalog.allergens(id) on delete cascade,
  language_code text not null check (language_code ~ '^[a-z]{2,3}(?:-[A-Z]{2})?$'),
  localized_name text not null,
  status catalog.translation_status not null default 'unverified',
  confidence numeric(5,4) not null default 0 check (confidence between 0 and 1),
  source text,
  verified_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (allergen_id, language_code)
);

create table catalog.foods (
  id uuid primary key default gen_random_uuid(),
  canonical_name text not null,
  normalized_name text not null,
  slug text not null unique check (slug ~ '^[a-z0-9]+(?:-[a-z0-9]+)*$'),
  short_description text check (short_description is null or char_length(short_description) <= 500),
  full_description text check (full_description is null or char_length(full_description) <= 10000),
  food_type_id uuid references catalog.food_types(id) on delete restrict,
  primary_cuisine_id uuid references catalog.cuisines(id) on delete set null,
  origin_country_id uuid references catalog.countries(id) on delete set null,
  origin_region_id uuid references catalog.regions(id) on delete set null,
  primary_preparation_method_id uuid references catalog.preparation_methods(id) on delete set null,
  serving_temperature catalog.serving_temperature not null default 'unknown',
  spicy_level smallint check (spicy_level between 0 and 5),
  sweetness_level smallint check (sweetness_level between 0 and 5),
  vegetarian_status catalog.certainty_status not null default 'unknown',
  vegan_status catalog.certainty_status not null default 'unknown',
  halal_status catalog.halal_status not null default 'unknown',
  alcohol_status catalog.certainty_status not null default 'unknown',
  typical_calories_min integer check (typical_calories_min >= 0),
  typical_calories_max integer check (typical_calories_max >= 0),
  popularity_score numeric(12,4) not null default 0 check (popularity_score >= 0),
  verification_status catalog.food_verification_status not null default 'draft',
  completeness_score numeric(5,2) not null default 0 check (completeness_score between 0 and 100),
  confidence_score numeric(5,4) not null default 0 check (confidence_score between 0 and 1),
  primary_image_path text,
  image_source text,
  image_license text,
  search_text text not null default '',
  search_document tsvector not null default ''::tsvector,
  embedding extensions.vector(768),
  embedding_model text,
  embedding_updated_at timestamptz,
  merged_into_food_id uuid references catalog.foods(id) on delete restrict,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  archived_at timestamptz,
  version_number integer not null default 1 check (version_number > 0),
  constraint food_calorie_range check (
    typical_calories_min is null
    or typical_calories_max is null
    or typical_calories_min <= typical_calories_max
  ),
  constraint food_not_merged_into_self check (merged_into_food_id is null or merged_into_food_id <> id),
  constraint food_archive_consistency check (
    (verification_status = 'archived') = (archived_at is not null)
  )
);

create unique index foods_normalized_active_uq
  on catalog.foods (normalized_name)
  where archived_at is null;

create table catalog.food_translations (
  id uuid primary key default gen_random_uuid(),
  food_id uuid not null references catalog.foods(id) on delete cascade,
  language_code text not null check (language_code ~ '^[a-z]{2,3}(?:-[A-Z]{2})?$'),
  localized_name text not null,
  normalized_name text not null,
  short_description text check (short_description is null or char_length(short_description) <= 500),
  full_description text check (full_description is null or char_length(full_description) <= 10000),
  status catalog.translation_status not null default 'unverified',
  confidence numeric(5,4) not null default 0 check (confidence between 0 and 1),
  source text,
  verified_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (food_id, language_code)
);

create table catalog.food_aliases (
  id uuid primary key default gen_random_uuid(),
  food_id uuid not null references catalog.foods(id) on delete cascade,
  alias text not null,
  normalized_alias text not null,
  alias_type text not null check (
    alias_type in ('alternative_spelling', 'regional_name', 'transliteration', 'restaurant_name', 'common_name')
  ),
  transliteration text,
  normalized_transliteration text,
  language_code text check (language_code is null or language_code ~ '^[a-z]{2,3}(?:-[A-Z]{2})?$'),
  country_id uuid references catalog.countries(id) on delete set null,
  region_id uuid references catalog.regions(id) on delete set null,
  confidence numeric(5,4) not null default 0 check (confidence between 0 and 1),
  source_count integer not null default 1 check (source_count > 0),
  status catalog.translation_status not null default 'unverified',
  source text,
  verified_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique nulls not distinct (food_id, normalized_alias, language_code)
);

create table catalog.food_cuisine_links (
  food_id uuid not null references catalog.foods(id) on delete cascade,
  cuisine_id uuid not null references catalog.cuisines(id) on delete restrict,
  is_primary boolean not null default false,
  confidence numeric(5,4) not null default 0 check (confidence between 0 and 1),
  status catalog.fact_status not null default 'unverified',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (food_id, cuisine_id)
);

create table catalog.food_category_links (
  food_id uuid not null references catalog.foods(id) on delete cascade,
  category_id uuid not null references catalog.food_categories(id) on delete restrict,
  is_primary boolean not null default false,
  confidence numeric(5,4) not null default 0 check (confidence between 0 and 1),
  status catalog.fact_status not null default 'unverified',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (food_id, category_id)
);

create table catalog.food_tag_links (
  food_id uuid not null references catalog.foods(id) on delete cascade,
  tag_id uuid not null references catalog.food_tags(id) on delete restrict,
  confidence numeric(5,4) not null default 0 check (confidence between 0 and 1),
  status catalog.fact_status not null default 'unverified',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (food_id, tag_id)
);

create table catalog.food_ingredients (
  food_id uuid not null references catalog.foods(id) on delete cascade,
  ingredient_id uuid not null references catalog.ingredients(id) on delete restrict,
  role catalog.ingredient_role not null,
  confidence numeric(5,4) not null default 0 check (confidence between 0 and 1),
  source_count integer not null default 1 check (source_count > 0),
  independent_source_count integer not null default 1 check (
    independent_source_count > 0 and independent_source_count <= source_count
  ),
  status catalog.fact_status not null default 'unverified',
  review_notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (food_id, ingredient_id, role)
);

create table catalog.food_allergens (
  food_id uuid not null references catalog.foods(id) on delete cascade,
  allergen_id uuid not null references catalog.allergens(id) on delete restrict,
  presence catalog.allergen_presence not null default 'unknown',
  confidence numeric(5,4) not null default 0 check (confidence between 0 and 1),
  source_count integer not null default 1 check (source_count > 0),
  independent_source_count integer not null default 1 check (
    independent_source_count > 0 and independent_source_count <= source_count
  ),
  status catalog.fact_status not null default 'unverified',
  medically_reviewed boolean not null default false,
  reviewed_by uuid references auth.users(id) on delete set null,
  reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (food_id, allergen_id)
);

create table catalog.food_facts (
  id uuid primary key default gen_random_uuid(),
  food_id uuid not null references catalog.foods(id) on delete cascade,
  fact_type text not null check (fact_type ~ '^[a-z][a-z0-9_.]{1,79}$'),
  fact_value jsonb not null,
  source_type text not null,
  source_reference text,
  source_url text check (source_url is null or source_url ~ '^https://'),
  confidence numeric(5,4) not null check (confidence between 0 and 1),
  source_count integer not null default 1 check (source_count > 0),
  independent_source_count integer not null default 1 check (
    independent_source_count > 0 and independent_source_count <= source_count
  ),
  verified_source_count integer not null default 0 check (
    verified_source_count >= 0 and verified_source_count <= independent_source_count
  ),
  status catalog.fact_status not null default 'unverified',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table catalog.food_versions (
  id bigint generated always as identity primary key,
  food_id uuid not null references catalog.foods(id) on delete restrict,
  version_number integer not null check (version_number > 0),
  snapshot jsonb not null,
  reason text not null,
  source text not null,
  proposal_id uuid,
  changed_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  unique (food_id, version_number)
);

create table catalog.food_audit_log (
  id bigint generated always as identity primary key,
  food_id uuid not null references catalog.foods(id) on delete restrict,
  entity_type text not null,
  entity_id text,
  action text not null check (action in ('insert', 'update', 'archive', 'restore', 'merge', 'proposal_applied')),
  old_value jsonb,
  new_value jsonb,
  reason text not null,
  source text not null,
  proposal_id uuid,
  changed_by uuid references auth.users(id) on delete set null,
  version_number integer not null check (version_number > 0),
  created_at timestamptz not null default now()
);

create table catalog.food_redirects (
  source_food_id uuid primary key references catalog.foods(id) on delete restrict,
  target_food_id uuid not null references catalog.foods(id) on delete restrict,
  reason text not null,
  proposal_id uuid,
  created_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  constraint food_redirect_not_self check (source_food_id <> target_food_id)
);

create trigger settings_touch_updated_at
before update on catalog.settings
for each row execute function catalog.touch_updated_at();

create trigger food_types_touch_updated_at
before update on catalog.food_types
for each row execute function catalog.touch_updated_at();

create trigger preparation_methods_touch_updated_at
before update on catalog.preparation_methods
for each row execute function catalog.touch_updated_at();

create trigger countries_touch_updated_at
before update on catalog.countries
for each row execute function catalog.touch_updated_at();

create trigger regions_touch_updated_at
before update on catalog.regions
for each row execute function catalog.touch_updated_at();

create trigger cuisines_touch_updated_at
before update on catalog.cuisines
for each row execute function catalog.touch_updated_at();

create trigger categories_touch_updated_at
before update on catalog.food_categories
for each row execute function catalog.touch_updated_at();

create trigger tags_touch_updated_at
before update on catalog.food_tags
for each row execute function catalog.touch_updated_at();

create trigger ingredients_touch_updated_at
before update on catalog.ingredients
for each row execute function catalog.touch_updated_at();

create trigger ingredient_translations_touch_updated_at
before update on catalog.ingredient_translations
for each row execute function catalog.touch_updated_at();

create trigger allergens_touch_updated_at
before update on catalog.allergens
for each row execute function catalog.touch_updated_at();

create trigger allergen_translations_touch_updated_at
before update on catalog.allergen_translations
for each row execute function catalog.touch_updated_at();

create trigger foods_touch_updated_at
before update on catalog.foods
for each row execute function catalog.touch_updated_at();

create trigger food_translations_touch_updated_at
before update on catalog.food_translations
for each row execute function catalog.touch_updated_at();

create trigger food_aliases_touch_updated_at
before update on catalog.food_aliases
for each row execute function catalog.touch_updated_at();

create trigger food_cuisine_links_touch_updated_at
before update on catalog.food_cuisine_links
for each row execute function catalog.touch_updated_at();

create trigger food_category_links_touch_updated_at
before update on catalog.food_category_links
for each row execute function catalog.touch_updated_at();

create trigger food_tag_links_touch_updated_at
before update on catalog.food_tag_links
for each row execute function catalog.touch_updated_at();

create trigger food_ingredients_touch_updated_at
before update on catalog.food_ingredients
for each row execute function catalog.touch_updated_at();

create trigger food_allergens_touch_updated_at
before update on catalog.food_allergens
for each row execute function catalog.touch_updated_at();

create trigger food_facts_touch_updated_at
before update on catalog.food_facts
for each row execute function catalog.touch_updated_at();

comment on schema catalog is
  'Controlled central food catalog. Direct Data API exposure is intentionally disabled.';
comment on table catalog.foods is
  'Trusted food entities. Untrusted inputs must enter food_observations first.';
comment on column catalog.foods.confidence_score is
  'Overall confidence from 0 to 1; field-level reliability belongs in food_facts.';
comment on table catalog.food_allergens is
  'High-risk allergen assertions; AI output alone cannot set reviewed or verified status.';
comment on table catalog.food_versions is
  'Immutable snapshots created for every accepted trusted food change.';

commit;
