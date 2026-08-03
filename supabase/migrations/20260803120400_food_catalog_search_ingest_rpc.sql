begin;

create or replace function catalog.require_catalog_reviewer()
returns void
language plpgsql
stable
security invoker
set search_path = ''
as $$
begin
  if not catalog.is_catalog_reviewer() then
    raise exception using errcode = '42501', message = 'Catalog reviewer permission required';
  end if;
end;
$$;

create or replace function catalog.require_catalog_admin()
returns void
language plpgsql
stable
security invoker
set search_path = ''
as $$
begin
  if not catalog.is_catalog_admin() then
    raise exception using errcode = '42501', message = 'Catalog admin permission required';
  end if;
end;
$$;

create or replace function catalog.setting_numeric(setting_key text, fallback numeric)
returns numeric
language sql
stable
security definer
set search_path = ''
as $$
  select coalesce(
    (
      select case
        when jsonb_typeof(s.value) = 'number' then (s.value #>> '{}')::numeric
        else null
      end
      from catalog.settings s
      where s.key = setting_key
    ),
    fallback
  )
$$;

create or replace function catalog.is_junk_food_name(normalized_value text)
returns boolean
language sql
immutable
set search_path = ''
as $$
  select normalized_value = any (array[
      'best food',
      'food near me',
      'cheap dinner',
      'chef recommendation',
      'special offer',
      'number 12',
      'test',
      'asdfgh'
    ])
    or normalized_value ~ '(^| )(offer|discount|promo|coupon)( |$)'
    or normalized_value ~ '[0-9]+[ ]*%[ ]*off'
    or normalized_value ~ '^[0-9 ]+$'
    or char_length(normalized_value) < 2
$$;

create or replace function public.normalize_food_name(value text)
returns text
language sql
immutable
strict
set search_path = ''
as $$
  select catalog.normalize_food_name(value)
$$;

create or replace function public.search_food_catalog(
  p_query text,
  p_language_code text default 'en',
  p_cuisine_id uuid default null,
  p_category_id uuid default null,
  p_limit integer default 10,
  p_query_embedding extensions.vector(768) default null
)
returns table (
  food_id uuid,
  slug text,
  canonical_name text,
  localized_name text,
  short_description text,
  cuisine_name text,
  match_type text,
  relevance_score numeric,
  popularity_score numeric,
  primary_image_path text
)
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  normalized_query text;
  bounded_limit integer := least(greatest(coalesce(p_limit, 10), 1), 20);
begin
  if p_query is null or char_length(trim(p_query)) not between 1 and 240 then
    raise exception using errcode = '22023', message = 'Search query must contain 1 to 240 characters';
  end if;
  if p_language_code is not null
     and p_language_code !~ '^[a-z]{2,3}(?:-[A-Z]{2})?$' then
    raise exception using errcode = '22023', message = 'Invalid language code';
  end if;

  normalized_query := catalog.normalize_food_name(p_query);

  return query
  with candidate_scores as (
    select f.id, 'exact_name'::text as kind, 1.0000::numeric as score
    from catalog.foods f
    where f.normalized_name = normalized_query

    union all
    select t.food_id, 'translation'::text, 0.9950::numeric
    from catalog.food_translations t
    where t.normalized_name = normalized_query
      and t.status in ('reviewed', 'verified')

    union all
    select a.food_id, 'alias'::text, 0.9900::numeric
    from catalog.food_aliases a
    where a.normalized_alias = normalized_query
      and a.status in ('reviewed', 'verified')

    union all
    select a.food_id, 'transliteration'::text, 0.9850::numeric
    from catalog.food_aliases a
    where a.normalized_transliteration = normalized_query
      and a.status in ('reviewed', 'verified')

    union all
    select f.id,
           'full_text'::text,
           (0.70 + least(0.20, ts_rank_cd(f.search_document, plainto_tsquery('simple', normalized_query))))::numeric
    from catalog.foods f
    where f.search_document @@ plainto_tsquery('simple', normalized_query)

    union all
    select f.id,
           'trigram'::text,
           (0.50 + 0.35 * extensions.similarity(f.normalized_name, normalized_query))::numeric
    from catalog.foods f
    where extensions.similarity(f.normalized_name, normalized_query) >= 0.30

    union all
    select f.id,
           'vector'::text,
           (0.40 + 0.40 * greatest(0, 1 - (f.embedding <=> p_query_embedding)))::numeric
    from catalog.foods f
    where p_query_embedding is not null and f.embedding is not null
    order by score desc
    limit 40
  ), ranked as (
    select distinct on (cs.id)
      cs.id,
      cs.kind,
      cs.score
    from candidate_scores cs
    order by cs.id, cs.score desc
  )
  select
    f.id,
    f.slug,
    f.canonical_name,
    coalesce(
      (
        select t.localized_name
        from catalog.food_translations t
        where t.food_id = f.id
          and t.language_code = p_language_code
          and t.status in ('reviewed', 'verified')
        order by t.status desc, t.confidence desc
        limit 1
      ),
      f.canonical_name
    ),
    coalesce(
      (
        select t.short_description
        from catalog.food_translations t
        where t.food_id = f.id
          and t.language_code = p_language_code
          and t.status in ('reviewed', 'verified')
        order by t.status desc, t.confidence desc
        limit 1
      ),
      f.short_description
    ),
    c.name,
    r.kind,
    round((r.score + least(f.popularity_score / 100000, 0.05))::numeric, 4),
    f.popularity_score,
    f.primary_image_path
  from ranked r
  join catalog.foods f on f.id = r.id
  left join catalog.cuisines c on c.id = f.primary_cuisine_id
  where f.verification_status = 'verified'
    and f.archived_at is null
    and f.merged_into_food_id is null
    and (p_cuisine_id is null or f.primary_cuisine_id = p_cuisine_id or exists (
      select 1 from catalog.food_cuisine_links fcl
      where fcl.food_id = f.id and fcl.cuisine_id = p_cuisine_id
        and fcl.status in ('supported', 'verified')
    ))
    and (p_category_id is null or exists (
      select 1 from catalog.food_category_links fcl
      where fcl.food_id = f.id and fcl.category_id = p_category_id
        and fcl.status in ('supported', 'verified')
    ))
  order by relevance_score desc, f.popularity_score desc, f.id
  limit bounded_limit;
end;
$$;

create or replace function public.match_menu_item_to_food(
  p_name text,
  p_description text default null,
  p_language_code text default 'en',
  p_cuisine_id uuid default null,
  p_category_id uuid default null,
  p_limit integer default 5
)
returns table (
  food_id uuid,
  canonical_name text,
  match_type text,
  match_confidence numeric,
  recommended_status text
)
language sql
stable
security definer
set search_path = ''
as $$
  select
    s.food_id,
    s.canonical_name,
    s.match_type,
    least(1, s.relevance_score)::numeric,
    case
      when s.relevance_score >= 0.98 then 'exact_match'
      when s.relevance_score >= 0.82 then 'review_match'
      else 'possible_match'
    end
  from public.search_food_catalog(
    concat_ws(' ', p_name, left(coalesce(p_description, ''), 500)),
    p_language_code,
    p_cuisine_id,
    p_category_id,
    least(greatest(coalesce(p_limit, 5), 1), 10),
    null
  ) s
$$;

create or replace function catalog.calculate_food_trust_score_internal(observation_uuid uuid)
returns numeric
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  observation catalog.food_observations;
  average_reliability numeric := 0;
  restaurant_sources integer := 0;
  admin_sources integer := 0;
  score numeric := 0;
begin
  select * into observation from catalog.food_observations where id = observation_uuid;
  if not found then
    raise exception using errcode = 'P0002', message = 'Food observation not found';
  end if;

  select
    coalesce(avg(sr.reliability_score), 0),
    count(*) filter (where sr.source_type in ('restaurant_menu', 'restaurant_owner')),
    count(*) filter (where sr.source_type in ('admin_import', 'staff_entry'))
  into average_reliability, restaurant_sources, admin_sources
  from catalog.food_observation_sources fos
  join catalog.source_registry sr on sr.id = fos.source_registry_id
  where fos.observation_id = observation_uuid and not sr.is_blocked;

  score := score
    + least(
        catalog.setting_numeric('trust.max_independent_source_points', 35),
        observation.independent_source_count
          * catalog.setting_numeric('trust.points_per_independent_source', 10)
      )
    + average_reliability * catalog.setting_numeric('trust.source_reliability_points', 20)
    + least(restaurant_sources, 5) * catalog.setting_numeric('trust.points_per_restaurant_source', 3)
    + least(admin_sources, 1) * catalog.setting_numeric('trust.trusted_import_points', 15)
    + case
        when char_length(coalesce(observation.raw_description, '')) >= 80
          then catalog.setting_numeric('trust.description_quality_points', 5)
        else 0
      end
    + case
        when jsonb_array_length(observation.raw_ingredients) >= 3
          then catalog.setting_numeric('trust.ingredient_quality_points', 5)
        else 0
      end
    + case
        when observation.detected_language is not null
          then catalog.setting_numeric('trust.language_consistency_points', 3)
        else 0
      end
    + coalesce(observation.match_confidence, 0)
      * catalog.setting_numeric('trust.match_consistency_points', 7)
    - observation.spam_score * catalog.setting_numeric('trust.spam_penalty_points', 50)
    - observation.junk_score * catalog.setting_numeric('trust.junk_penalty_points', 60);

  return round(least(100, greatest(0, score)), 2);
end;
$$;

create or replace function public.calculate_food_trust_score(p_observation_id uuid)
returns numeric
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  perform catalog.require_catalog_reviewer();
  return catalog.calculate_food_trust_score_internal(p_observation_id);
end;
$$;

create or replace function public.submit_food_observation(
  p_raw_name text,
  p_raw_description text default null,
  p_raw_ingredients jsonb default '[]'::jsonb,
  p_raw_category text default null,
  p_language_code text default null,
  p_source_type catalog.observation_source_type default 'user_submission',
  p_source_id text default null,
  p_integration_key text default null,
  p_external_restaurant_id text default null,
  p_external_menu_item_id text default null,
  p_raw_image_path text default null,
  p_evidence jsonb default '{}'::jsonb
)
returns uuid
language plpgsql
volatile
security definer
set search_path = ''
as $$
declare
  caller_id uuid := auth.uid();
  normalized_value text;
  candidate_key text;
  source_hash text;
  registry_id uuid;
  observation_id uuid;
  blocked boolean;
  rejected_as_junk boolean;
  calculated_trust numeric;
begin
  if caller_id is null and not catalog.is_catalog_admin() then
    raise exception using errcode = '42501', message = 'Authentication required';
  end if;
  if p_raw_name is null or char_length(trim(p_raw_name)) not between 1 and 240 then
    raise exception using errcode = '22023', message = 'Food name must contain 1 to 240 characters';
  end if;
  if p_raw_description is not null and char_length(p_raw_description) > 4000 then
    raise exception using errcode = '22023', message = 'Description is too long';
  end if;
  if jsonb_typeof(coalesce(p_raw_ingredients, '[]'::jsonb)) <> 'array'
     or jsonb_array_length(coalesce(p_raw_ingredients, '[]'::jsonb)) > 100 then
    raise exception using errcode = '22023', message = 'Ingredients must be an array with at most 100 values';
  end if;
  if jsonb_typeof(coalesce(p_evidence, '{}'::jsonb)) <> 'object' then
    raise exception using errcode = '22023', message = 'Evidence must be an object';
  end if;

  if p_source_type = 'user_submission' then
    null;
  elsif p_source_type in ('restaurant_menu', 'restaurant_owner') then
    if p_integration_key is null or p_external_restaurant_id is null or not exists (
      select 1
      from catalog.restaurant_source_access rsa
      where rsa.user_id = caller_id
        and rsa.integration_key = p_integration_key
        and rsa.external_restaurant_id = p_external_restaurant_id
        and rsa.can_submit_observations
        and rsa.revoked_at is null
    ) then
      raise exception using errcode = '42501', message = 'Verified restaurant ownership required';
    end if;
  elsif not catalog.is_catalog_reviewer() then
    raise exception using errcode = '42501', message = 'This source type requires a trusted backend';
  end if;

  normalized_value := catalog.normalize_food_name(p_raw_name);
  rejected_as_junk := catalog.is_junk_food_name(normalized_value);
  candidate_key := encode(
    extensions.digest(
      convert_to(normalized_value || '|' || coalesce(p_language_code, ''), 'utf8'),
      'sha256'
    ),
    'hex'
  );
  source_hash := encode(
    extensions.digest(
      convert_to(
        p_source_type::text || '|' || coalesce(
          nullif(p_source_id, ''),
          nullif(p_integration_key || ':' || p_external_restaurant_id, ':'),
          caller_id::text
        ),
        'utf8'
      ),
      'sha256'
    ),
    'hex'
  );

  insert into catalog.source_registry (source_type, source_key_hash)
  values (p_source_type, source_hash)
  on conflict (source_type, source_key_hash)
  do update set updated_at = now()
  returning id, is_blocked into registry_id, blocked;

  if blocked then
    raise exception using errcode = '42501', message = 'Submission source is blocked';
  end if;

  insert into catalog.food_observations (
    dedup_key,
    raw_name,
    raw_description,
    raw_ingredients,
    raw_category,
    raw_language,
    raw_image_path,
    primary_source_type,
    primary_source_id,
    integration_key,
    external_restaurant_id,
    external_menu_item_id,
    submitted_by,
    normalized_name,
    detected_language,
    status,
    spam_score,
    junk_score,
    decision,
    decision_explanation,
    resolved_at
  ) values (
    candidate_key,
    trim(p_raw_name),
    nullif(trim(coalesce(p_raw_description, '')), ''),
    coalesce(p_raw_ingredients, '[]'::jsonb),
    nullif(trim(coalesce(p_raw_category, '')), ''),
    p_language_code,
    p_raw_image_path,
    p_source_type,
    nullif(left(coalesce(p_source_id, ''), 200), ''),
    p_integration_key,
    p_external_restaurant_id,
    p_external_menu_item_id,
    caller_id,
    normalized_value,
    p_language_code,
    case when rejected_as_junk then 'rejected' else 'pending' end,
    case when rejected_as_junk then 0.80 else 0 end,
    case when rejected_as_junk then 1.00 else 0 end,
    case when rejected_as_junk then 'reject' else null end,
    case when rejected_as_junk then 'Known junk, promotional, conversational, or invalid query pattern.' else null end,
    case when rejected_as_junk then now() else null end
  )
  on conflict (dedup_key) do update set
    occurrence_count = catalog.food_observations.occurrence_count + 1,
    last_seen_at = now(),
    raw_description = coalesce(catalog.food_observations.raw_description, excluded.raw_description),
    raw_ingredients = case
      when jsonb_array_length(catalog.food_observations.raw_ingredients) = 0 then excluded.raw_ingredients
      else catalog.food_observations.raw_ingredients
    end
  returning id into observation_id;

  insert into catalog.food_observation_sources (
    observation_id,
    source_registry_id,
    evidence
  ) values (
    observation_id,
    registry_id,
    p_evidence
  )
  on conflict (observation_id, source_registry_id) do update set
    occurrence_count = catalog.food_observation_sources.occurrence_count + 1,
    last_seen_at = now(),
    evidence = catalog.food_observation_sources.evidence || excluded.evidence;

  update catalog.food_observations o
  set occurrence_count = totals.occurrences,
      independent_source_count = totals.independent_sources
  from (
    select
      sum(fos.occurrence_count)::bigint as occurrences,
      count(*)::integer as independent_sources
    from catalog.food_observation_sources fos
    where fos.observation_id = observation_id
  ) totals
  where o.id = observation_id;

  calculated_trust := catalog.calculate_food_trust_score_internal(observation_id);
  update catalog.food_observations set trust_score = calculated_trust where id = observation_id;
  return observation_id;
end;
$$;

create or replace function public.record_food_search(
  p_original_query text,
  p_language_code text default null,
  p_result_count integer default 0,
  p_selected_food_id uuid default null,
  p_selected_integration_key text default null,
  p_selected_external_menu_item_id text default null,
  p_looks_like_food_name boolean default false,
  p_classification_confidence numeric default 0,
  p_anonymous_session_token text default null
)
returns bigint
language plpgsql
volatile
security definer
set search_path = ''
as $$
declare
  caller_id uuid := auth.uid();
  session_hash text;
  event_id bigint;
  normalized_value text;
begin
  if p_original_query is null or char_length(trim(p_original_query)) not between 1 and 500 then
    raise exception using errcode = '22023', message = 'Search query must contain 1 to 500 characters';
  end if;
  if p_result_count < 0 or p_result_count > 10000 then
    raise exception using errcode = '22023', message = 'Invalid result count';
  end if;
  if p_classification_confidence not between 0 and 1 then
    raise exception using errcode = '22023', message = 'Confidence must be between 0 and 1';
  end if;
  if caller_id is null then
    if p_anonymous_session_token is null
       or char_length(p_anonymous_session_token) not between 16 and 200 then
      raise exception using errcode = '22023', message = 'A bounded anonymous session token is required';
    end if;
    session_hash := encode(
      extensions.digest(convert_to(p_anonymous_session_token, 'utf8'), 'sha256'),
      'hex'
    );
  end if;

  normalized_value := catalog.normalize_food_name(p_original_query);
  insert into catalog.food_search_events (
    normalized_query,
    original_query,
    language_code,
    result_count,
    selected_food_id,
    selected_integration_key,
    selected_external_menu_item_id,
    looks_like_food_name,
    classification_confidence,
    user_id,
    anonymous_session_hash
  ) values (
    normalized_value,
    trim(p_original_query),
    p_language_code,
    p_result_count,
    p_selected_food_id,
    p_selected_integration_key,
    p_selected_external_menu_item_id,
    p_looks_like_food_name and not catalog.is_junk_food_name(normalized_value),
    p_classification_confidence,
    caller_id,
    session_hash
  ) returning id into event_id;
  return event_id;
end;
$$;

create or replace function public.queue_food_embedding(p_food_id uuid, p_reason text default 'manual rebuild')
returns uuid
language plpgsql
volatile
security definer
set search_path = ''
as $$
begin
  perform catalog.require_catalog_reviewer();
  if p_reason is null or char_length(trim(p_reason)) not between 1 and 240 then
    raise exception using errcode = '22023', message = 'Embedding reason must contain 1 to 240 characters';
  end if;
  return catalog.queue_food_embedding_internal(p_food_id, p_reason);
end;
$$;

create or replace function public.rebuild_food_search_document(p_food_id uuid)
returns void
language plpgsql
volatile
security definer
set search_path = ''
as $$
begin
  perform catalog.require_catalog_reviewer();
  perform catalog.rebuild_food_search_document_internal(p_food_id);
end;
$$;

revoke all on function public.normalize_food_name(text) from public;
revoke all on function public.search_food_catalog(text, text, uuid, uuid, integer, extensions.vector) from public;
revoke all on function public.match_menu_item_to_food(text, text, text, uuid, uuid, integer) from public;
revoke all on function public.calculate_food_trust_score(uuid) from public;
revoke all on function public.submit_food_observation(text, text, jsonb, text, text, catalog.observation_source_type, text, text, text, text, text, jsonb) from public;
revoke all on function public.record_food_search(text, text, integer, uuid, text, text, boolean, numeric, text) from public;
revoke all on function public.queue_food_embedding(uuid, text) from public;
revoke all on function public.rebuild_food_search_document(uuid) from public;

grant execute on function public.normalize_food_name(text) to anon, authenticated, service_role;
grant execute on function public.search_food_catalog(text, text, uuid, uuid, integer, extensions.vector) to anon, authenticated, service_role;
grant execute on function public.match_menu_item_to_food(text, text, text, uuid, uuid, integer) to anon, authenticated, service_role;
grant execute on function public.calculate_food_trust_score(uuid) to authenticated, service_role;
grant execute on function public.submit_food_observation(text, text, jsonb, text, text, catalog.observation_source_type, text, text, text, text, text, jsonb) to authenticated, service_role;
grant execute on function public.record_food_search(text, text, integer, uuid, text, text, boolean, numeric, text) to anon, authenticated, service_role;
grant execute on function public.queue_food_embedding(uuid, text) to authenticated, service_role;
grant execute on function public.rebuild_food_search_document(uuid) to authenticated, service_role;

comment on function public.search_food_catalog(text, text, uuid, uuid, integer, extensions.vector) is
  'Verified-only hybrid search: exact/translation/alias/transliteration, FTS, trigram, then optional vector.';
comment on function public.submit_food_observation(text, text, jsonb, text, text, catalog.observation_source_type, text, text, text, text, text, jsonb) is
  'Stages and deduplicates untrusted evidence. It never writes catalog.foods.';

commit;
