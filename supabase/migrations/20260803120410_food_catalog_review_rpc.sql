begin;

create or replace function catalog.proposal_risk(
  p_type catalog.proposal_type,
  p_changes jsonb
)
returns catalog.risk_level
language sql
immutable
set search_path = ''
as $$
  select case
    when p_type in ('add_allergen', 'update_allergen', 'merge_foods')
      or p_changes ?| array[
        'halal_status', 'alcohol_status', 'vegetarian_status', 'vegan_status',
        'typical_calories_min', 'typical_calories_max', 'allergens'
      ] then 'critical'::catalog.risk_level
    when p_type in ('replace_image', 'archive_food', 'update_country', 'create_food')
      or p_changes ?| array['canonical_name', 'origin_country_id', 'origin_region_id', 'delete']
      then 'high'::catalog.risk_level
    when p_type in (
      'update_description', 'add_ingredient', 'update_ingredient',
      'update_cuisine', 'update_category', 'add_image'
    ) then 'medium'::catalog.risk_level
    else 'low'::catalog.risk_level
  end
$$;

create or replace function catalog.is_safe_auto_approval(
  p_type catalog.proposal_type,
  p_changes jsonb,
  p_confidence numeric,
  p_evidence jsonb
)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select catalog.proposal_risk(p_type, p_changes) = 'low'
    and (
      p_type in ('increase_popularity', 'attach_evidence')
      or (
        p_type = 'add_alias'
        and coalesce(p_changes ->> 'alias_type', '') = 'transliteration'
        and p_confidence >= catalog.setting_numeric('auto_approval.alias_confidence', 0.95)
        and jsonb_array_length(p_evidence) >= catalog.setting_numeric('auto_approval.minimum_evidence', 3)
      )
    )
$$;

create or replace function catalog.log_related_food_change(
  p_food_id uuid,
  p_entity_type text,
  p_entity_id text,
  p_old_value jsonb,
  p_new_value jsonb,
  p_proposal_id uuid,
  p_reason text
)
returns void
language plpgsql
volatile
security definer
set search_path = ''
as $$
declare
  current_version integer;
begin
  update catalog.foods
  set version_number = version_number + 1
  where id = p_food_id
  returning version_number into current_version;

  if current_version is null then
    raise exception using errcode = 'P0002', message = 'Food not found';
  end if;

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
    p_food_id,
    left(p_entity_type, 80),
    left(p_entity_id, 240),
    'proposal_applied',
    p_old_value,
    p_new_value,
    p_reason,
    'food_change_proposal',
    p_proposal_id,
    auth.uid(),
    current_version
  );
end;
$$;

create or replace function catalog.merge_food_records_internal(
  p_source_food_id uuid,
  p_target_food_id uuid,
  p_reason text,
  p_proposal_id uuid default null
)
returns uuid
language plpgsql
volatile
security definer
set search_path = ''
as $$
declare
  source_food catalog.foods;
  target_food catalog.foods;
  alias_id uuid;
begin
  if p_source_food_id = p_target_food_id then
    raise exception using errcode = '22023', message = 'A food cannot be merged into itself';
  end if;
  if p_reason is null or char_length(trim(p_reason)) not between 3 and 1000 then
    raise exception using errcode = '22023', message = 'A merge reason is required';
  end if;

  select * into source_food from catalog.foods where id = p_source_food_id for update;
  select * into target_food from catalog.foods where id = p_target_food_id for update;
  if source_food.id is null or target_food.id is null then
    raise exception using errcode = 'P0002', message = 'Source or target food not found';
  end if;
  if source_food.archived_at is not null or target_food.archived_at is not null then
    raise exception using errcode = '22023', message = 'Archived foods cannot be merged';
  end if;

  perform set_config('catalog.change_reason', p_reason, true);
  perform set_config('catalog.change_source', 'reviewed merge', true);
  perform set_config('catalog.proposal_id', coalesce(p_proposal_id::text, ''), true);

  insert into catalog.food_aliases (
    food_id,
    alias,
    normalized_alias,
    alias_type,
    confidence,
    source_count,
    status,
    source,
    verified_at
  ) values (
    p_target_food_id,
    source_food.canonical_name,
    source_food.normalized_name,
    'common_name',
    1,
    1,
    'verified',
    'reviewed merge',
    now()
  )
  on conflict (food_id, normalized_alias, language_code) do update set
    confidence = greatest(catalog.food_aliases.confidence, excluded.confidence),
    status = 'verified',
    verified_at = now()
  returning id into alias_id;

  update catalog.catalog_menu_item_links
  set food_id = p_target_food_id,
      match_source = 'catalog_merge',
      matched_at = now()
  where food_id = p_source_food_id;

  update catalog.foods
  set verification_status = 'archived',
      archived_at = now(),
      merged_into_food_id = p_target_food_id
  where id = p_source_food_id;

  insert into catalog.food_redirects (
    source_food_id,
    target_food_id,
    reason,
    proposal_id,
    created_by
  ) values (
    p_source_food_id,
    p_target_food_id,
    p_reason,
    p_proposal_id,
    auth.uid()
  ) on conflict (source_food_id) do update set
    target_food_id = excluded.target_food_id,
    reason = excluded.reason,
    proposal_id = excluded.proposal_id;

  update catalog.food_merge_candidates
  set status = 'merged', reviewed_by = auth.uid(), reviewed_at = now()
  where (food_id_a = least(p_source_food_id, p_target_food_id)
    and food_id_b = greatest(p_source_food_id, p_target_food_id));

  perform catalog.log_related_food_change(
    p_target_food_id,
    'food_alias',
    alias_id::text,
    null,
    jsonb_build_object('alias', source_food.canonical_name, 'merged_from', p_source_food_id),
    p_proposal_id,
    p_reason
  );
  perform catalog.rebuild_food_search_document_internal(p_target_food_id);
  return p_target_food_id;
end;
$$;

create or replace function catalog.apply_food_proposal_internal(p_proposal_id uuid)
returns uuid
language plpgsql
volatile
security definer
set search_path = ''
as $$
declare
  proposal catalog.food_change_proposals;
  resulting_food_id uuid;
  related_id uuid;
  previous jsonb;
  alias_entry jsonb;
  translation_entry jsonb;
begin
  select * into proposal
  from catalog.food_change_proposals
  where id = p_proposal_id
  for update;
  if proposal.id is null then
    raise exception using errcode = 'P0002', message = 'Proposal not found';
  end if;
  if proposal.status not in ('pending', 'auto_approved', 'approved') then
    raise exception using errcode = '22023', message = 'Proposal cannot be applied from its current status';
  end if;

  perform set_config('catalog.change_reason', 'Approved proposal ' || proposal.id::text, true);
  perform set_config('catalog.change_source', 'food_change_proposal', true);
  perform set_config('catalog.proposal_id', proposal.id::text, true);
  resulting_food_id := proposal.food_id;

  case proposal.proposal_type
    when 'create_food' then
      insert into catalog.foods (
        canonical_name,
        normalized_name,
        slug,
        short_description,
        full_description,
        food_type_id,
        primary_cuisine_id,
        origin_country_id,
        origin_region_id,
        serving_temperature,
        vegetarian_status,
        vegan_status,
        halal_status,
        alcohol_status,
        verification_status,
        completeness_score,
        confidence_score
      ) values (
        proposal.proposed_changes ->> 'canonical_name',
        catalog.normalize_food_name(proposal.proposed_changes ->> 'canonical_name'),
        proposal.proposed_changes ->> 'slug',
        proposal.proposed_changes ->> 'short_description',
        proposal.proposed_changes ->> 'full_description',
        nullif(proposal.proposed_changes ->> 'food_type_id', '')::uuid,
        nullif(proposal.proposed_changes ->> 'primary_cuisine_id', '')::uuid,
        nullif(proposal.proposed_changes ->> 'origin_country_id', '')::uuid,
        nullif(proposal.proposed_changes ->> 'origin_region_id', '')::uuid,
        coalesce(nullif(proposal.proposed_changes ->> 'serving_temperature', '')::catalog.serving_temperature, 'unknown'),
        coalesce(nullif(proposal.proposed_changes ->> 'vegetarian_status', '')::catalog.certainty_status, 'unknown'),
        coalesce(nullif(proposal.proposed_changes ->> 'vegan_status', '')::catalog.certainty_status, 'unknown'),
        coalesce(nullif(proposal.proposed_changes ->> 'halal_status', '')::catalog.halal_status, 'unknown'),
        coalesce(nullif(proposal.proposed_changes ->> 'alcohol_status', '')::catalog.certainty_status, 'unknown'),
        'verified',
        coalesce((proposal.proposed_changes ->> 'completeness_score')::numeric, 0),
        proposal.confidence
      ) returning id into resulting_food_id;
      update catalog.food_change_proposals set food_id = resulting_food_id where id = proposal.id;
      for alias_entry in
        select value
        from jsonb_array_elements(coalesce(proposal.proposed_changes -> 'aliases', '[]'::jsonb))
      loop
        insert into catalog.food_aliases (
          food_id, alias, normalized_alias, alias_type, transliteration,
          normalized_transliteration, language_code, confidence, source_count,
          status, source, verified_at
        ) values (
          resulting_food_id,
          alias_entry ->> 'name',
          catalog.normalize_food_name(alias_entry ->> 'name'),
          coalesce(alias_entry ->> 'type', 'alternative_spelling'),
          alias_entry ->> 'transliteration',
          case when alias_entry ? 'transliteration'
            then catalog.normalize_food_name(alias_entry ->> 'transliteration') end,
          alias_entry ->> 'language',
          proposal.confidence,
          1,
          'verified',
          'approved import proposal',
          now()
        );
      end loop;
      for translation_entry in
        select value
        from jsonb_array_elements(coalesce(proposal.proposed_changes -> 'translations', '[]'::jsonb))
      loop
        insert into catalog.food_translations (
          food_id, language_code, localized_name, normalized_name,
          short_description, full_description, status, confidence, source, verified_at
        ) values (
          resulting_food_id,
          translation_entry ->> 'language',
          translation_entry ->> 'name',
          catalog.normalize_food_name(translation_entry ->> 'name'),
          translation_entry ->> 'shortDescription',
          translation_entry ->> 'fullDescription',
          'verified',
          proposal.confidence,
          'approved import proposal',
          now()
        );
      end loop;

    when 'update_description' then
      update catalog.foods
      set short_description = coalesce(proposal.proposed_changes ->> 'short_description', short_description),
          full_description = coalesce(proposal.proposed_changes ->> 'full_description', full_description)
      where id = proposal.food_id;

    when 'update_cuisine' then
      update catalog.foods
      set primary_cuisine_id = (proposal.proposed_changes ->> 'cuisine_id')::uuid
      where id = proposal.food_id;

    when 'update_country' then
      update catalog.foods
      set origin_country_id = nullif(proposal.proposed_changes ->> 'country_id', '')::uuid,
          origin_region_id = nullif(proposal.proposed_changes ->> 'region_id', '')::uuid
      where id = proposal.food_id;

    when 'archive_food' then
      update catalog.foods
      set verification_status = 'archived', archived_at = now()
      where id = proposal.food_id;

    when 'increase_popularity' then
      update catalog.foods
      set popularity_score = popularity_score
        + least(greatest(coalesce((proposal.proposed_changes ->> 'increment')::numeric, 0), 0), 1000)
      where id = proposal.food_id;

    when 'add_alias' then
      insert into catalog.food_aliases (
        food_id, alias, normalized_alias, alias_type, transliteration,
        normalized_transliteration, language_code, confidence, source_count,
        status, source, verified_at
      ) values (
        proposal.food_id,
        proposal.proposed_changes ->> 'alias',
        catalog.normalize_food_name(proposal.proposed_changes ->> 'alias'),
        proposal.proposed_changes ->> 'alias_type',
        proposal.proposed_changes ->> 'transliteration',
        case when proposal.proposed_changes ? 'transliteration'
          then catalog.normalize_food_name(proposal.proposed_changes ->> 'transliteration') end,
        proposal.proposed_changes ->> 'language_code',
        proposal.confidence,
        greatest(1, jsonb_array_length(proposal.evidence)),
        'verified',
        'approved proposal',
        now()
      )
      on conflict (food_id, normalized_alias, language_code) do update set
        confidence = greatest(catalog.food_aliases.confidence, excluded.confidence),
        source_count = greatest(catalog.food_aliases.source_count, excluded.source_count),
        status = 'verified',
        verified_at = now()
      returning id into related_id;
      perform catalog.log_related_food_change(
        proposal.food_id, 'food_alias', related_id::text, null,
        proposal.proposed_changes, proposal.id, 'Approved alias proposal'
      );

    when 'add_translation' then
      if exists (
        select 1 from catalog.food_translations t
        where t.food_id = proposal.food_id
          and t.language_code = proposal.proposed_changes ->> 'language_code'
          and t.localized_name <> proposal.proposed_changes ->> 'localized_name'
      ) then
        raise exception using errcode = '23505', message = 'A different translation already exists for this language';
      end if;
      insert into catalog.food_translations (
        food_id, language_code, localized_name, normalized_name,
        short_description, full_description, status, confidence, source, verified_at
      ) values (
        proposal.food_id,
        proposal.proposed_changes ->> 'language_code',
        proposal.proposed_changes ->> 'localized_name',
        catalog.normalize_food_name(proposal.proposed_changes ->> 'localized_name'),
        proposal.proposed_changes ->> 'short_description',
        proposal.proposed_changes ->> 'full_description',
        'verified', proposal.confidence, 'approved proposal', now()
      )
      on conflict (food_id, language_code) do update set
        confidence = greatest(catalog.food_translations.confidence, excluded.confidence),
        status = 'verified', verified_at = now()
      returning id into related_id;
      perform catalog.log_related_food_change(
        proposal.food_id, 'food_translation', related_id::text, null,
        proposal.proposed_changes, proposal.id, 'Approved translation proposal'
      );

    when 'add_ingredient', 'update_ingredient' then
      insert into catalog.food_ingredients (
        food_id, ingredient_id, role, confidence, source_count,
        independent_source_count, status, review_notes
      ) values (
        proposal.food_id,
        (proposal.proposed_changes ->> 'ingredient_id')::uuid,
        (proposal.proposed_changes ->> 'role')::catalog.ingredient_role,
        proposal.confidence,
        greatest(1, jsonb_array_length(proposal.evidence)),
        greatest(1, jsonb_array_length(proposal.evidence)),
        'verified',
        proposal.proposed_changes ->> 'review_notes'
      ) on conflict (food_id, ingredient_id, role) do update set
        confidence = greatest(catalog.food_ingredients.confidence, excluded.confidence),
        source_count = greatest(catalog.food_ingredients.source_count, excluded.source_count),
        independent_source_count = greatest(
          catalog.food_ingredients.independent_source_count,
          excluded.independent_source_count
        ),
        status = 'verified',
        review_notes = coalesce(excluded.review_notes, catalog.food_ingredients.review_notes);
      perform catalog.log_related_food_change(
        proposal.food_id, 'food_ingredient', proposal.proposed_changes ->> 'ingredient_id',
        proposal.previous_values, proposal.proposed_changes, proposal.id,
        'Approved ingredient proposal'
      );

    when 'add_allergen', 'update_allergen' then
      insert into catalog.food_allergens (
        food_id, allergen_id, presence, confidence, source_count,
        independent_source_count, status, medically_reviewed, reviewed_by, reviewed_at
      ) values (
        proposal.food_id,
        (proposal.proposed_changes ->> 'allergen_id')::uuid,
        (proposal.proposed_changes ->> 'presence')::catalog.allergen_presence,
        proposal.confidence,
        greatest(1, jsonb_array_length(proposal.evidence)),
        greatest(1, jsonb_array_length(proposal.evidence)),
        'verified', true, auth.uid(), now()
      ) on conflict (food_id, allergen_id) do update set
        presence = excluded.presence,
        confidence = greatest(catalog.food_allergens.confidence, excluded.confidence),
        source_count = greatest(catalog.food_allergens.source_count, excluded.source_count),
        independent_source_count = greatest(
          catalog.food_allergens.independent_source_count,
          excluded.independent_source_count
        ),
        status = 'verified', medically_reviewed = true,
        reviewed_by = auth.uid(), reviewed_at = now();
      perform catalog.log_related_food_change(
        proposal.food_id, 'food_allergen', proposal.proposed_changes ->> 'allergen_id',
        proposal.previous_values, proposal.proposed_changes, proposal.id,
        'Approved allergen proposal'
      );

    when 'update_category' then
      insert into catalog.food_category_links (
        food_id, category_id, is_primary, confidence, status
      ) values (
        proposal.food_id,
        (proposal.proposed_changes ->> 'category_id')::uuid,
        coalesce((proposal.proposed_changes ->> 'is_primary')::boolean, false),
        proposal.confidence,
        'verified'
      ) on conflict (food_id, category_id) do update set
        is_primary = excluded.is_primary,
        confidence = greatest(catalog.food_category_links.confidence, excluded.confidence),
        status = 'verified';
      perform catalog.log_related_food_change(
        proposal.food_id, 'food_category', proposal.proposed_changes ->> 'category_id',
        proposal.previous_values, proposal.proposed_changes, proposal.id,
        'Approved category proposal'
      );

    when 'add_image', 'replace_image' then
      if proposal.proposal_type = 'replace_image' then
        update catalog.food_images
        set verification_status = 'archived', archived_at = now()
        where food_id = proposal.food_id and storage_path = proposal.previous_values ->> 'storage_path';
      end if;
      insert into catalog.food_images (
        food_id, storage_path, variant, source, license, attribution,
        uploaded_by, moderation_status, verification_status, image_hash,
        width, height, file_size_bytes, mime_type, reviewed_by, reviewed_at
      ) values (
        proposal.food_id,
        proposal.proposed_changes ->> 'storage_path',
        proposal.proposed_changes ->> 'variant',
        proposal.proposed_changes ->> 'source',
        proposal.proposed_changes ->> 'license',
        proposal.proposed_changes ->> 'attribution',
        auth.uid(), 'approved', 'verified',
        proposal.proposed_changes ->> 'image_hash',
        (proposal.proposed_changes ->> 'width')::integer,
        (proposal.proposed_changes ->> 'height')::integer,
        (proposal.proposed_changes ->> 'file_size_bytes')::bigint,
        proposal.proposed_changes ->> 'mime_type',
        auth.uid(), now()
      ) returning id into related_id;
      update catalog.foods
      set primary_image_path = proposal.proposed_changes ->> 'storage_path',
          image_source = proposal.proposed_changes ->> 'source',
          image_license = proposal.proposed_changes ->> 'license'
      where id = proposal.food_id;

    when 'attach_evidence' then
      insert into catalog.food_facts (
        food_id, fact_type, fact_value, source_type, source_reference,
        source_url, confidence, source_count, independent_source_count,
        verified_source_count, status
      ) values (
        proposal.food_id,
        proposal.proposed_changes ->> 'fact_type',
        proposal.proposed_changes -> 'fact_value',
        proposal.proposed_changes ->> 'source_type',
        proposal.proposed_changes ->> 'source_reference',
        proposal.proposed_changes ->> 'source_url',
        proposal.confidence,
        greatest(1, jsonb_array_length(proposal.evidence)),
        greatest(1, jsonb_array_length(proposal.evidence)),
        0,
        'supported'
      ) returning id into related_id;
      perform catalog.log_related_food_change(
        proposal.food_id, 'food_fact', related_id::text, null,
        proposal.proposed_changes, proposal.id, 'Attached supporting evidence'
      );

    when 'merge_foods' then
      resulting_food_id := catalog.merge_food_records_internal(
        proposal.food_id,
        (proposal.proposed_changes ->> 'target_food_id')::uuid,
        coalesce(proposal.proposed_changes ->> 'reason', 'Reviewed duplicate merge'),
        proposal.id
      );

    else
      raise exception using errcode = '0A000', message = 'Unsupported proposal type';
  end case;

  update catalog.food_change_proposals
  set status = 'applied',
      applied_at = now(),
      failure_reason = null
  where id = proposal.id;
  return resulting_food_id;
end;
$$;

create or replace function public.create_food_change_proposal(
  p_food_id uuid,
  p_observation_id uuid,
  p_proposal_type catalog.proposal_type,
  p_proposed_changes jsonb,
  p_previous_values jsonb default '{}'::jsonb,
  p_evidence jsonb default '[]'::jsonb,
  p_confidence numeric default 0
)
returns uuid
language plpgsql
volatile
security definer
set search_path = ''
as $$
declare
  proposal_id uuid;
  calculated_risk catalog.risk_level;
  auto_approve boolean;
begin
  perform catalog.require_catalog_reviewer();
  if jsonb_typeof(p_proposed_changes) <> 'object'
     or jsonb_typeof(coalesce(p_previous_values, '{}'::jsonb)) <> 'object'
     or jsonb_typeof(coalesce(p_evidence, '[]'::jsonb)) <> 'array' then
    raise exception using errcode = '22023', message = 'Invalid proposal JSON shape';
  end if;
  if p_confidence not between 0 and 1 then
    raise exception using errcode = '22023', message = 'Confidence must be between 0 and 1';
  end if;
  if jsonb_array_length(p_evidence) > 100 then
    raise exception using errcode = '22023', message = 'Evidence is limited to 100 references';
  end if;

  calculated_risk := catalog.proposal_risk(p_proposal_type, p_proposed_changes);
  auto_approve := catalog.is_safe_auto_approval(
    p_proposal_type, p_proposed_changes, p_confidence, p_evidence
  );

  insert into catalog.food_change_proposals (
    food_id, observation_id, proposal_type, proposed_changes, previous_values,
    evidence, confidence, risk_level, status, auto_approval_rule, created_by
  ) values (
    p_food_id, p_observation_id, p_proposal_type, p_proposed_changes,
    coalesce(p_previous_values, '{}'::jsonb), coalesce(p_evidence, '[]'::jsonb),
    p_confidence, calculated_risk,
    case when auto_approve then 'auto_approved' else 'pending' end,
    case when auto_approve then 'configured_low_risk_rule' else null end,
    auth.uid()
  ) returning id into proposal_id;

  if auto_approve then
    perform catalog.apply_food_proposal_internal(proposal_id);
  end if;
  return proposal_id;
end;
$$;

create or replace function public.approve_food_proposal(
  p_proposal_id uuid,
  p_edited_changes jsonb default null
)
returns catalog.proposal_status
language plpgsql
volatile
security definer
set search_path = ''
as $$
declare
  proposal catalog.food_change_proposals;
  final_status catalog.proposal_status;
begin
  perform catalog.require_catalog_reviewer();
  select * into proposal from catalog.food_change_proposals where id = p_proposal_id for update;
  if proposal.id is null then
    raise exception using errcode = 'P0002', message = 'Proposal not found';
  end if;
  if proposal.risk_level in ('high', 'critical') and not catalog.is_catalog_admin() then
    raise exception using errcode = '42501', message = 'High-risk proposals require a catalog admin';
  end if;
  if p_edited_changes is not null then
    if jsonb_typeof(p_edited_changes) <> 'object' then
      raise exception using errcode = '22023', message = 'Edited changes must be an object';
    end if;
    update catalog.food_change_proposals
    set proposed_changes = p_edited_changes,
        risk_level = catalog.proposal_risk(proposal.proposal_type, p_edited_changes)
    where id = p_proposal_id
    returning * into proposal;
    if proposal.risk_level in ('high', 'critical') and not catalog.is_catalog_admin() then
      raise exception using errcode = '42501', message = 'Edited proposal now requires a catalog admin';
    end if;
  end if;

  update catalog.food_change_proposals
  set status = 'approved', reviewed_by = auth.uid(), reviewed_at = now(), rejection_reason = null
  where id = p_proposal_id;

  begin
    perform catalog.apply_food_proposal_internal(p_proposal_id);
  exception when others then
    update catalog.food_change_proposals
    set status = 'failed', failure_reason = sqlstate, reviewed_by = auth.uid(), reviewed_at = now()
    where id = p_proposal_id;
  end;
  select status into final_status from catalog.food_change_proposals where id = p_proposal_id;
  return final_status;
end;
$$;

create or replace function public.reject_food_proposal(
  p_proposal_id uuid,
  p_rejection_reason text
)
returns catalog.proposal_status
language plpgsql
volatile
security definer
set search_path = ''
as $$
declare
  final_status catalog.proposal_status;
begin
  perform catalog.require_catalog_reviewer();
  if p_rejection_reason is null or char_length(trim(p_rejection_reason)) not between 3 and 1000 then
    raise exception using errcode = '22023', message = 'A rejection reason is required';
  end if;
  update catalog.food_change_proposals
  set status = 'rejected',
      rejection_reason = trim(p_rejection_reason),
      reviewed_by = auth.uid(),
      reviewed_at = now()
  where id = p_proposal_id and status in ('pending', 'auto_approved', 'approved')
  returning status into final_status;
  if final_status is null then
    raise exception using errcode = '22023', message = 'Proposal cannot be rejected';
  end if;
  return final_status;
end;
$$;

create or replace function public.merge_food_records(
  p_source_food_id uuid,
  p_target_food_id uuid,
  p_reason text,
  p_proposal_id uuid default null
)
returns uuid
language plpgsql
volatile
security definer
set search_path = ''
as $$
begin
  perform catalog.require_catalog_admin();
  return catalog.merge_food_records_internal(
    p_source_food_id, p_target_food_id, p_reason, p_proposal_id
  );
end;
$$;

create or replace function public.suggest_food_duplicates(
  p_food_id uuid,
  p_limit integer default 20
)
returns table (
  candidate_food_id uuid,
  similarity_score numeric,
  similarity_components jsonb,
  merge_candidate_id uuid
)
language plpgsql
volatile
security definer
set search_path = ''
as $$
begin
  perform catalog.require_catalog_reviewer();
  return query
  with source_food as (
    select * from catalog.foods where id = p_food_id and archived_at is null
  ), candidates as (
    select
      f.id,
      greatest(
        extensions.similarity(sf.normalized_name, f.normalized_name),
        case when exists (
          select 1 from catalog.food_aliases a
          where a.food_id in (sf.id, f.id)
          group by a.normalized_alias
          having count(distinct a.food_id) = 2
        ) then 1 else 0 end,
        case when sf.embedding is not null and f.embedding is not null
          then greatest(0, 1 - (sf.embedding <=> f.embedding)) else 0 end
      )::numeric as score,
      jsonb_build_object(
        'name', round(extensions.similarity(sf.normalized_name, f.normalized_name)::numeric, 4),
        'sameCuisine', sf.primary_cuisine_id is not distinct from f.primary_cuisine_id,
        'vector', case when sf.embedding is not null and f.embedding is not null
          then round(greatest(0, 1 - (sf.embedding <=> f.embedding))::numeric, 4) else null end
      ) as components
    from source_food sf
    join catalog.foods f on f.id <> sf.id and f.archived_at is null
    where extensions.similarity(sf.normalized_name, f.normalized_name) >= 0.30
       or (sf.embedding is not null and f.embedding is not null and (sf.embedding <=> f.embedding) <= 0.25)
    order by score desc, f.id
    limit least(greatest(coalesce(p_limit, 20), 1), 50)
  ), inserted as (
    insert into catalog.food_merge_candidates (
      food_id_a, food_id_b, similarity_score, similarity_components, explanation
    )
    select
      least(p_food_id, c.id),
      greatest(p_food_id, c.id),
      least(1, c.score),
      c.components,
      'Database shortlist: exact/alias, trigram, cuisine metadata, then optional vector.'
    from candidates c
    where c.score >= catalog.setting_numeric('duplicate.minimum_similarity', 0.75)
    on conflict (food_id_a, food_id_b) do update set
      similarity_score = greatest(catalog.food_merge_candidates.similarity_score, excluded.similarity_score),
      similarity_components = excluded.similarity_components,
      updated_at = now()
    returning id, food_id_a, food_id_b, similarity_score, similarity_components
  )
  select
    case when i.food_id_a = p_food_id then i.food_id_b else i.food_id_a end,
    i.similarity_score,
    i.similarity_components,
    i.id
  from inserted i
  order by i.similarity_score desc;
end;
$$;

create or replace view catalog.admin_review_queue
with (security_invoker = true)
as
select
  'proposal'::text as queue_source,
  p.id as item_id,
  case
    when p.proposal_type in ('add_allergen', 'update_allergen') then 'allergen_changes'
    when p.proposed_changes ?| array['halal_status', 'alcohol_status'] then 'dietary_status_changes'
    when p.proposal_type in ('add_image', 'replace_image') then 'image_review'
    when p.proposal_type = 'add_alias' then 'new_aliases'
    when p.proposal_type = 'add_translation' then 'new_translations'
    when p.proposal_type = 'merge_foods' then 'possible_duplicates'
    when p.proposal_type = 'create_food' then 'new_food_candidates'
    else 'catalog_changes'
  end as queue_name,
  p.risk_level,
  p.status::text as status,
  p.confidence,
  p.created_at
from catalog.food_change_proposals p
where p.status in ('pending', 'needs_more_evidence', 'failed')
union all
select
  'observation',
  o.id,
  case
    when o.status = 'rejected' then 'rejected_junk'
    when o.status = 'new_food_candidate' then 'new_food_candidates'
    when o.status = 'enrichment_candidate' then 'missing_or_conflicting_information'
    else 'untriaged_observations'
  end,
  case when o.spam_score >= 0.8 or o.junk_score >= 0.8 then 'high' else 'medium' end::catalog.risk_level,
  o.status::text,
  o.match_confidence,
  o.created_at
from catalog.food_observations o
where o.status in ('pending', 'enrichment_candidate', 'new_food_candidate', 'rejected');

revoke all on function public.create_food_change_proposal(uuid, uuid, catalog.proposal_type, jsonb, jsonb, jsonb, numeric) from public;
revoke all on function public.approve_food_proposal(uuid, jsonb) from public;
revoke all on function public.reject_food_proposal(uuid, text) from public;
revoke all on function public.merge_food_records(uuid, uuid, text, uuid) from public;
revoke all on function public.suggest_food_duplicates(uuid, integer) from public;
revoke all on table catalog.admin_review_queue from public, anon, authenticated;

grant execute on function public.create_food_change_proposal(uuid, uuid, catalog.proposal_type, jsonb, jsonb, jsonb, numeric) to authenticated, service_role;
grant execute on function public.approve_food_proposal(uuid, jsonb) to authenticated, service_role;
grant execute on function public.reject_food_proposal(uuid, text) to authenticated, service_role;
grant execute on function public.merge_food_records(uuid, uuid, text, uuid) to authenticated, service_role;
grant execute on function public.suggest_food_duplicates(uuid, integer) to authenticated, service_role;
grant select on table catalog.admin_review_queue to service_role;

comment on function public.approve_food_proposal(uuid, jsonb) is
  'Applies a reviewed proposal, with admin-only enforcement for high/critical risk.';
comment on function public.merge_food_records(uuid, uuid, text, uuid) is
  'Explicit admin merge. Records a redirect and archives rather than deletes the source food.';

commit;
