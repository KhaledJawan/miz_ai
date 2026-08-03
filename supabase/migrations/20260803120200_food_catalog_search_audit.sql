begin;

create index foods_verification_popularity_idx
  on catalog.foods (verification_status, popularity_score desc, id)
  where archived_at is null;
create index foods_primary_cuisine_idx on catalog.foods (primary_cuisine_id);
create index foods_origin_country_idx on catalog.foods (origin_country_id);
create index foods_normalized_trgm_idx
  on catalog.foods using gin (normalized_name extensions.gin_trgm_ops);
create index foods_search_document_idx
  on catalog.foods using gin (search_document);
create index foods_embedding_hnsw_idx
  on catalog.foods using hnsw (embedding extensions.vector_cosine_ops)
  where embedding is not null and verification_status = 'verified' and archived_at is null;

create index food_translations_language_name_idx
  on catalog.food_translations (language_code, normalized_name);
create index food_translations_name_trgm_idx
  on catalog.food_translations using gin (normalized_name extensions.gin_trgm_ops);
create index food_aliases_language_name_idx
  on catalog.food_aliases (language_code, normalized_alias);
create index food_aliases_name_trgm_idx
  on catalog.food_aliases using gin (normalized_alias extensions.gin_trgm_ops);
create index food_aliases_transliteration_idx
  on catalog.food_aliases (normalized_transliteration)
  where normalized_transliteration is not null;
create index food_aliases_food_status_idx on catalog.food_aliases (food_id, status);

create index food_cuisine_links_cuisine_idx
  on catalog.food_cuisine_links (cuisine_id, food_id);
create index food_category_links_category_idx
  on catalog.food_category_links (category_id, food_id);
create index food_tag_links_tag_idx on catalog.food_tag_links (tag_id, food_id);
create index food_ingredients_ingredient_idx
  on catalog.food_ingredients (ingredient_id, food_id);
create index food_allergens_allergen_idx
  on catalog.food_allergens (allergen_id, food_id);
create index food_facts_food_type_status_idx
  on catalog.food_facts (food_id, fact_type, status, confidence desc);
create index food_versions_food_created_idx
  on catalog.food_versions (food_id, created_at desc);
create index food_audit_food_created_idx
  on catalog.food_audit_log (food_id, created_at desc);

create index source_registry_blocked_idx
  on catalog.source_registry (is_blocked, source_type);
create index restaurant_source_access_user_idx
  on catalog.restaurant_source_access (user_id, integration_key)
  where revoked_at is null;
create index food_observations_queue_idx
  on catalog.food_observations (status, trust_score desc, last_seen_at, id);
create index food_observations_match_idx
  on catalog.food_observations (possible_food_id, match_confidence desc)
  where possible_food_id is not null;
create index food_observations_normalized_trgm_idx
  on catalog.food_observations using gin (normalized_name extensions.gin_trgm_ops);
create index food_observation_sources_source_idx
  on catalog.food_observation_sources (source_registry_id, last_seen_at desc);
create index food_search_events_retention_idx
  on catalog.food_search_events (retention_until, id);
create index food_search_events_query_time_idx
  on catalog.food_search_events (normalized_query, created_at desc);
create index food_change_proposals_queue_idx
  on catalog.food_change_proposals (status, risk_level, created_at, id);
create index food_change_proposals_food_idx
  on catalog.food_change_proposals (food_id, created_at desc)
  where food_id is not null;
create index food_decisions_food_idx
  on catalog.food_decisions (food_id, decided_at desc)
  where food_id is not null;
create index food_merge_candidates_queue_idx
  on catalog.food_merge_candidates (status, similarity_score desc, created_at, id);
create index food_embedding_jobs_queue_idx
  on catalog.food_embedding_jobs (status, available_at, created_at, id);
create index food_images_review_idx
  on catalog.food_images (moderation_status, verification_status, created_at, id);
create index food_images_hash_idx
  on catalog.food_images (image_hash)
  where image_hash is not null;
create index catalog_menu_item_links_food_idx
  on catalog.catalog_menu_item_links (food_id, match_status);
create index food_import_errors_batch_idx
  on catalog.food_import_errors (batch_id, record_index);
create index food_observations_import_batch_idx
  on catalog.food_observations (import_batch_id)
  where import_batch_id is not null;
create index food_proposals_import_batch_idx
  on catalog.food_change_proposals (import_batch_id)
  where import_batch_id is not null;

create or replace function catalog.normalize_catalog_fields()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  if tg_table_name = 'foods' then
    new.normalized_name := catalog.normalize_food_name(new.canonical_name);
  elsif tg_table_name = 'food_aliases' then
    new.normalized_alias := catalog.normalize_food_name(new.alias);
    new.normalized_transliteration := case
      when new.transliteration is null then null
      else catalog.normalize_food_name(new.transliteration)
    end;
  elsif tg_table_name in ('food_translations', 'ingredient_translations') then
    new.normalized_name := catalog.normalize_food_name(new.localized_name);
  elsif tg_table_name = 'ingredients' then
    new.normalized_name := catalog.normalize_food_name(new.canonical_name);
  end if;
  return new;
end;
$$;

create trigger foods_normalize_fields
before insert or update of canonical_name on catalog.foods
for each row execute function catalog.normalize_catalog_fields();
create trigger food_aliases_normalize_fields
before insert or update of alias, transliteration on catalog.food_aliases
for each row execute function catalog.normalize_catalog_fields();
create trigger food_translations_normalize_fields
before insert or update of localized_name on catalog.food_translations
for each row execute function catalog.normalize_catalog_fields();
create trigger ingredients_normalize_fields
before insert or update of canonical_name on catalog.ingredients
for each row execute function catalog.normalize_catalog_fields();
create trigger ingredient_translations_normalize_fields
before insert or update of localized_name on catalog.ingredient_translations
for each row execute function catalog.normalize_catalog_fields();

create or replace function catalog.food_semantic_snapshot(food catalog.foods)
returns jsonb
language sql
stable
set search_path = ''
as $$
  select to_jsonb(food)
    - 'search_text'
    - 'search_document'
    - 'embedding'
    - 'embedding_model'
    - 'embedding_updated_at'
    - 'updated_at'
$$;

create or replace function catalog.prepare_food_version()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  if catalog.food_semantic_snapshot(new) is distinct from catalog.food_semantic_snapshot(old) then
    new.version_number := old.version_number + 1;
  end if;
  return new;
end;
$$;

create trigger foods_prepare_version
before update on catalog.foods
for each row execute function catalog.prepare_food_version();

create or replace function catalog.capture_food_version()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  old_snapshot jsonb;
  new_snapshot jsonb;
  change_reason text := coalesce(nullif(current_setting('catalog.change_reason', true), ''), 'trusted catalog change');
  change_source text := coalesce(nullif(current_setting('catalog.change_source', true), ''), 'database');
  proposal uuid := nullif(current_setting('catalog.proposal_id', true), '')::uuid;
  actor uuid := auth.uid();
begin
  if tg_op = 'INSERT' then
    old_snapshot := null;
    new_snapshot := catalog.food_semantic_snapshot(new);
  else
    old_snapshot := catalog.food_semantic_snapshot(old);
    new_snapshot := catalog.food_semantic_snapshot(new);
    if old_snapshot is not distinct from new_snapshot then
      return new;
    end if;
  end if;

  insert into catalog.food_versions (
    food_id,
    version_number,
    snapshot,
    reason,
    source,
    proposal_id,
    changed_by
  ) values (
    new.id,
    new.version_number,
    new_snapshot,
    change_reason,
    change_source,
    proposal,
    actor
  );

  insert into catalog.food_audit_log (
    food_id,
    entity_type,
    entity_id,
    action,
    old_value,
    new_value,
    reason,
    source,
    proposal_id,
    changed_by,
    version_number
  ) values (
    new.id,
    'food',
    new.id::text,
    case
      when tg_op = 'INSERT' then 'insert'
      when new.verification_status = 'archived' and old.verification_status <> 'archived' then 'archive'
      when old.verification_status = 'archived' and new.verification_status <> 'archived' then 'restore'
      else 'update'
    end,
    old_snapshot,
    new_snapshot,
    change_reason,
    change_source,
    proposal,
    actor,
    new.version_number
  );
  return new;
end;
$$;

create trigger foods_capture_version
after insert or update on catalog.foods
for each row execute function catalog.capture_food_version();

create or replace function catalog.protect_trusted_fact_update()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  if old.status in ('supported', 'verified')
     and new.fact_value is distinct from old.fact_value then
    raise exception using
      errcode = 'check_violation',
      message = 'Trusted fact values are append-only; supersede through a reviewed proposal.';
  end if;
  if old.status = 'verified' and new.confidence < old.confidence then
    raise exception using
      errcode = 'check_violation',
      message = 'A verified fact cannot be replaced with lower confidence.';
  end if;
  return new;
end;
$$;

create trigger food_facts_protect_trusted_update
before update on catalog.food_facts
for each row execute function catalog.protect_trusted_fact_update();

create or replace function catalog.build_food_embedding_text(food_uuid uuid)
returns text
language sql
stable
set search_path = ''
as $$
  select left(
    concat_ws(
      ' | ',
      f.canonical_name,
      nullif(string_agg(distinct a.alias, ', '), ''),
      nullif(string_agg(distinct t.localized_name, ', '), ''),
      c.name,
      nullif(string_agg(distinct fc.name, ', '), ''),
      nullif(string_agg(distinct i.canonical_name, ', '), ''),
      f.short_description
    ),
    4000
  )
  from catalog.foods f
  left join catalog.food_aliases a
    on a.food_id = f.id and a.status in ('reviewed', 'verified')
  left join catalog.food_translations t
    on t.food_id = f.id and t.status in ('reviewed', 'verified')
  left join catalog.cuisines c on c.id = f.primary_cuisine_id
  left join catalog.food_category_links fcl
    on fcl.food_id = f.id and fcl.status in ('supported', 'verified')
  left join catalog.food_categories fc on fc.id = fcl.category_id
  left join catalog.food_ingredients fi
    on fi.food_id = f.id and fi.status in ('supported', 'verified')
  left join catalog.ingredients i on i.id = fi.ingredient_id
  where f.id = food_uuid
  group by f.id, c.name
$$;

create or replace function catalog.queue_food_embedding_internal(
  food_uuid uuid,
  queue_reason text
)
returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  embedding_text text;
  content_digest text;
  job_id uuid;
begin
  select catalog.build_food_embedding_text(food_uuid) into embedding_text;
  if embedding_text is null or embedding_text = '' then
    return null;
  end if;
  content_digest := encode(extensions.digest(convert_to(embedding_text, 'utf8'), 'sha256'), 'hex');
  insert into catalog.food_embedding_jobs (food_id, reason, content_hash)
  values (food_uuid, left(queue_reason, 240), content_digest)
  on conflict (food_id, content_hash)
    where status in ('pending', 'processing')
  do update set reason = excluded.reason, available_at = least(catalog.food_embedding_jobs.available_at, now())
  returning id into job_id;
  return job_id;
end;
$$;

create or replace function catalog.rebuild_food_search_document_internal(food_uuid uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  combined_text text;
begin
  select concat_ws(
    ' ',
    f.canonical_name,
    f.short_description,
    f.full_description,
    string_agg(distinct a.alias, ' '),
    string_agg(distinct a.transliteration, ' '),
    string_agg(distinct t.localized_name, ' '),
    c.name,
    string_agg(distinct fc.name, ' '),
    string_agg(distinct i.canonical_name, ' ')
  )
  into combined_text
  from catalog.foods f
  left join catalog.food_aliases a
    on a.food_id = f.id and a.status in ('reviewed', 'verified')
  left join catalog.food_translations t
    on t.food_id = f.id and t.status in ('reviewed', 'verified')
  left join catalog.cuisines c on c.id = f.primary_cuisine_id
  left join catalog.food_category_links fcl
    on fcl.food_id = f.id and fcl.status in ('supported', 'verified')
  left join catalog.food_categories fc on fc.id = fcl.category_id
  left join catalog.food_ingredients fi
    on fi.food_id = f.id and fi.status in ('supported', 'verified')
  left join catalog.ingredients i on i.id = fi.ingredient_id
  where f.id = food_uuid
  group by f.id, c.name;

  update catalog.foods
  set search_text = coalesce(combined_text, canonical_name),
      search_document = to_tsvector('simple', coalesce(combined_text, canonical_name))
  where id = food_uuid;

  perform catalog.queue_food_embedding_internal(food_uuid, 'searchable catalog content changed');
end;
$$;

create or replace function catalog.refresh_parent_food_search()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  parent_food_id uuid;
begin
  if tg_op = 'DELETE' then
    parent_food_id := old.food_id;
  else
    parent_food_id := new.food_id;
  end if;
  perform catalog.rebuild_food_search_document_internal(parent_food_id);
  return coalesce(new, old);
end;
$$;

create or replace function catalog.refresh_food_search_on_food_change()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  perform catalog.rebuild_food_search_document_internal(new.id);
  return new;
end;
$$;

create trigger foods_refresh_search
after insert or update of canonical_name, short_description, full_description, primary_cuisine_id
on catalog.foods
for each row execute function catalog.refresh_food_search_on_food_change();

create trigger food_aliases_refresh_search
after insert or update or delete on catalog.food_aliases
for each row execute function catalog.refresh_parent_food_search();
create trigger food_translations_refresh_search
after insert or update or delete on catalog.food_translations
for each row execute function catalog.refresh_parent_food_search();
create trigger food_categories_refresh_search
after insert or update or delete on catalog.food_category_links
for each row execute function catalog.refresh_parent_food_search();
create trigger food_ingredients_refresh_search
after insert or update or delete on catalog.food_ingredients
for each row execute function catalog.refresh_parent_food_search();

comment on function catalog.queue_food_embedding_internal(uuid, text) is
  'Queues only when the bounded searchable-content hash changes; never calls an AI provider.';

commit;
