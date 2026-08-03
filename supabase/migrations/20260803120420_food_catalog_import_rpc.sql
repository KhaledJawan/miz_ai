begin;

create or replace function public.stage_food_catalog_import(
  p_source_name text,
  p_source_version text,
  p_source_url text,
  p_license text,
  p_content_hash text,
  p_records jsonb,
  p_dry_run boolean default true
)
returns table (
  batch_id uuid,
  status text,
  record_count integer,
  accepted_count integer,
  rejected_count integer
)
language plpgsql
volatile
security definer
set search_path = ''
as $$
declare
  new_batch_id uuid;
  entry jsonb;
  entry_index integer;
  canonical_name text;
  normalized_name text;
  slug_value text;
  language_code text;
  observation_id uuid;
  proposal_id uuid;
  food_type_id uuid;
  cuisine_id uuid;
  country_id uuid;
  accepted integer := 0;
  rejected integer := 0;
  seen_names text[] := array[]::text[];
begin
  perform catalog.require_catalog_admin();
  if p_source_name is null or char_length(trim(p_source_name)) not between 2 and 200 then
    raise exception using errcode = '22023', message = 'A source name is required';
  end if;
  if p_license is null or char_length(trim(p_license)) not between 2 and 200 then
    raise exception using errcode = '22023', message = 'A source license is required';
  end if;
  if p_content_hash !~ '^[a-f0-9]{64}$' then
    raise exception using errcode = '22023', message = 'Content hash must be lowercase SHA-256';
  end if;
  if jsonb_typeof(p_records) <> 'array' or jsonb_array_length(p_records) not between 1 and 500 then
    raise exception using errcode = '22023', message = 'Import batch must contain 1 to 500 records';
  end if;

  insert into catalog.food_import_batches (
    source_name, source_version, source_url, license, content_hash,
    dry_run, status, record_count, created_by
  ) values (
    trim(p_source_name), nullif(trim(coalesce(p_source_version, '')), ''),
    nullif(trim(coalesce(p_source_url, '')), ''), trim(p_license), p_content_hash,
    p_dry_run, 'validating', jsonb_array_length(p_records), auth.uid()
  ) returning id into new_batch_id;

  for entry, entry_index in
    select value, (ordinality - 1)::integer
    from jsonb_array_elements(p_records) with ordinality
  loop
    begin
      if jsonb_typeof(entry) <> 'object' then
        raise exception using errcode = '22023', message = 'Record must be an object';
      end if;
      canonical_name := nullif(trim(entry ->> 'canonicalName'), '');
      slug_value := nullif(trim(entry ->> 'slug'), '');
      language_code := coalesce(nullif(entry ->> 'language', ''), 'en');
      if canonical_name is null or char_length(canonical_name) > 240 then
        raise exception using errcode = '22023', message = 'Invalid canonicalName';
      end if;
      if slug_value is null or slug_value !~ '^[a-z0-9]+(?:-[a-z0-9]+)*$' then
        raise exception using errcode = '22023', message = 'Invalid slug';
      end if;
      if language_code !~ '^[a-z]{2,3}(?:-[A-Z]{2})?$' then
        raise exception using errcode = '22023', message = 'Invalid language';
      end if;
      if jsonb_typeof(coalesce(entry -> 'aliases', '[]'::jsonb)) <> 'array'
         or jsonb_array_length(coalesce(entry -> 'aliases', '[]'::jsonb)) > 30 then
        raise exception using errcode = '22023', message = 'aliases must be an array with at most 30 values';
      end if;
      if jsonb_typeof(coalesce(entry -> 'translations', '[]'::jsonb)) <> 'array'
         or jsonb_array_length(coalesce(entry -> 'translations', '[]'::jsonb)) > 30 then
        raise exception using errcode = '22023', message = 'translations must be an array with at most 30 values';
      end if;

      normalized_name := catalog.normalize_food_name(canonical_name);
      if catalog.is_junk_food_name(normalized_name) then
        raise exception using errcode = '22023', message = 'Junk or promotional name';
      end if;
      if normalized_name = any(seen_names) then
        raise exception using errcode = '23505', message = 'Duplicate normalized name in import batch';
      end if;
      seen_names := array_append(seen_names, normalized_name);
      if exists (
        select 1 from catalog.foods f
        where f.archived_at is null and (f.normalized_name = normalized_name or f.slug = slug_value)
      ) or exists (
        select 1 from catalog.food_aliases a where a.normalized_alias = normalized_name
      ) then
        raise exception using errcode = '23505', message = 'Food already exists as a canonical name or alias';
      end if;

      food_type_id := null;
      cuisine_id := null;
      country_id := null;
      if entry ? 'foodTypeSlug' then
        select id into food_type_id
        from catalog.food_types
        where slug = entry ->> 'foodTypeSlug' and is_active;
        if food_type_id is null then
          raise exception using errcode = '23503', message = 'Unknown foodTypeSlug';
        end if;
      end if;
      if entry ? 'cuisineSlug' then
        select id into cuisine_id
        from catalog.cuisines
        where slug = entry ->> 'cuisineSlug' and is_active;
        if cuisine_id is null then
          raise exception using errcode = '23503', message = 'Unknown cuisineSlug';
        end if;
      end if;
      if entry ? 'originCountryIso2' then
        select id into country_id
        from catalog.countries
        where iso2 = upper(entry ->> 'originCountryIso2') and is_active;
        if country_id is null then
          raise exception using errcode = '23503', message = 'Unknown originCountryIso2';
        end if;
      end if;

      if not p_dry_run then
        observation_id := public.submit_food_observation(
          p_raw_name => canonical_name,
          p_raw_description => entry ->> 'shortDescription',
          p_raw_ingredients => coalesce(entry -> 'ingredients', '[]'::jsonb),
          p_raw_category => entry ->> 'category',
          p_language_code => language_code,
          p_source_type => 'admin_import',
          p_source_id => new_batch_id::text || ':' || entry_index::text,
          p_evidence => jsonb_build_object(
            'batchId', new_batch_id,
            'source', p_source_name,
            'license', p_license,
            'sourceUrl', p_source_url
          )
        );
        update catalog.food_observations
        set import_batch_id = new_batch_id
        where id = observation_id and import_batch_id is null;

        proposal_id := public.create_food_change_proposal(
          p_food_id => null,
          p_observation_id => observation_id,
          p_proposal_type => 'create_food',
          p_proposed_changes => jsonb_strip_nulls(jsonb_build_object(
            'canonical_name', canonical_name,
            'slug', slug_value,
            'short_description', entry ->> 'shortDescription',
            'full_description', entry ->> 'fullDescription',
            'food_type_id', food_type_id,
            'primary_cuisine_id', cuisine_id,
            'origin_country_id', country_id,
            'serving_temperature', entry ->> 'servingTemperature',
            'aliases', coalesce(entry -> 'aliases', '[]'::jsonb),
            'translations', coalesce(entry -> 'translations', '[]'::jsonb),
            'source', p_source_name,
            'license', p_license
          )),
          p_evidence => jsonb_build_array(jsonb_build_object(
            'batchId', new_batch_id,
            'source', p_source_name,
            'license', p_license,
            'sourceUrl', p_source_url
          )),
          p_confidence => coalesce((entry ->> 'confidence')::numeric, 0.90)
        );
        update catalog.food_change_proposals
        set import_batch_id = new_batch_id
        where id = proposal_id;
      end if;
      accepted := accepted + 1;
    exception when others then
      rejected := rejected + 1;
      insert into catalog.food_import_errors (
        batch_id, record_index, record_key, error_code, error_message
      ) values (
        new_batch_id,
        entry_index,
        left(coalesce(entry ->> 'slug', entry ->> 'canonicalName'), 200),
        sqlstate,
        left(sqlerrm, 500)
      );
    end;
  end loop;

  update catalog.food_import_batches
  set status = case
        when p_dry_run then 'validated'
        when accepted > 0 then 'staged'
        else 'failed'
      end,
      accepted_count = accepted,
      rejected_count = rejected,
      completed_at = now()
  where id = new_batch_id;

  return query
  select b.id, b.status, b.record_count, b.accepted_count, b.rejected_count
  from catalog.food_import_batches b where b.id = new_batch_id;
end;
$$;

create or replace function public.rollback_food_catalog_import(
  p_batch_id uuid,
  p_reason text
)
returns boolean
language plpgsql
volatile
security definer
set search_path = ''
as $$
begin
  perform catalog.require_catalog_admin();
  if p_reason is null or char_length(trim(p_reason)) not between 3 and 1000 then
    raise exception using errcode = '22023', message = 'A rollback reason is required';
  end if;
  if exists (
    select 1 from catalog.food_change_proposals
    where import_batch_id = p_batch_id and status = 'applied'
  ) then
    raise exception using
      errcode = '55000',
      message = 'Applied proposals require individual archive/restore proposals; import rollback refused';
  end if;

  update catalog.food_change_proposals
  set status = 'rejected',
      rejection_reason = 'Import rollback: ' || trim(p_reason),
      reviewed_by = auth.uid(),
      reviewed_at = now()
  where import_batch_id = p_batch_id
    and status in ('pending', 'auto_approved', 'approved', 'needs_more_evidence', 'failed');

  update catalog.food_observations
  set status = 'archived',
      decision = 'reject',
      decision_explanation = 'Import rollback: ' || trim(p_reason),
      resolved_at = now()
  where import_batch_id = p_batch_id
    and independent_source_count = 1
    and status not in ('approved', 'matched');

  update catalog.food_import_batches
  set status = 'rolled_back', completed_at = now()
  where id = p_batch_id and status <> 'rolled_back';
  return found;
end;
$$;

revoke all on function public.stage_food_catalog_import(text, text, text, text, text, jsonb, boolean) from public;
revoke all on function public.rollback_food_catalog_import(uuid, text) from public;
grant execute on function public.stage_food_catalog_import(text, text, text, text, text, jsonb, boolean) to authenticated, service_role;
grant execute on function public.rollback_food_catalog_import(uuid, text) to authenticated, service_role;

comment on function public.stage_food_catalog_import(text, text, text, text, text, jsonb, boolean) is
  'Validates batches up to 500 records. Non-dry-run records become observations and pending create proposals.';

commit;
