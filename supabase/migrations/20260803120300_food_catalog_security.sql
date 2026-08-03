begin;

create or replace function catalog.is_catalog_admin()
returns boolean
language sql
stable
security invoker
set search_path = ''
as $$
  select coalesce(auth.jwt() ->> 'role', '') = 'service_role'
    or coalesce(auth.jwt() -> 'app_metadata' ->> 'catalog_role', '') = 'admin'
$$;

create or replace function catalog.is_catalog_reviewer()
returns boolean
language sql
stable
security invoker
set search_path = ''
as $$
  select catalog.is_catalog_admin()
    or coalesce(auth.jwt() -> 'app_metadata' ->> 'catalog_role', '') = 'reviewer'
$$;

alter table catalog.settings enable row level security;
alter table catalog.settings force row level security;
alter table catalog.food_types enable row level security;
alter table catalog.food_types force row level security;
alter table catalog.preparation_methods enable row level security;
alter table catalog.preparation_methods force row level security;
alter table catalog.countries enable row level security;
alter table catalog.countries force row level security;
alter table catalog.regions enable row level security;
alter table catalog.regions force row level security;
alter table catalog.cuisines enable row level security;
alter table catalog.cuisines force row level security;
alter table catalog.food_categories enable row level security;
alter table catalog.food_categories force row level security;
alter table catalog.food_tags enable row level security;
alter table catalog.food_tags force row level security;
alter table catalog.ingredients enable row level security;
alter table catalog.ingredients force row level security;
alter table catalog.ingredient_translations enable row level security;
alter table catalog.ingredient_translations force row level security;
alter table catalog.allergens enable row level security;
alter table catalog.allergens force row level security;
alter table catalog.allergen_translations enable row level security;
alter table catalog.allergen_translations force row level security;
alter table catalog.foods enable row level security;
alter table catalog.foods force row level security;
alter table catalog.food_translations enable row level security;
alter table catalog.food_translations force row level security;
alter table catalog.food_aliases enable row level security;
alter table catalog.food_aliases force row level security;
alter table catalog.food_cuisine_links enable row level security;
alter table catalog.food_cuisine_links force row level security;
alter table catalog.food_category_links enable row level security;
alter table catalog.food_category_links force row level security;
alter table catalog.food_tag_links enable row level security;
alter table catalog.food_tag_links force row level security;
alter table catalog.food_ingredients enable row level security;
alter table catalog.food_ingredients force row level security;
alter table catalog.food_allergens enable row level security;
alter table catalog.food_allergens force row level security;
alter table catalog.food_facts enable row level security;
alter table catalog.food_facts force row level security;
alter table catalog.food_versions enable row level security;
alter table catalog.food_versions force row level security;
alter table catalog.food_audit_log enable row level security;
alter table catalog.food_audit_log force row level security;
alter table catalog.food_redirects enable row level security;
alter table catalog.food_redirects force row level security;
alter table catalog.source_registry enable row level security;
alter table catalog.source_registry force row level security;
alter table catalog.restaurant_source_access enable row level security;
alter table catalog.restaurant_source_access force row level security;
alter table catalog.food_observations enable row level security;
alter table catalog.food_observations force row level security;
alter table catalog.food_observation_sources enable row level security;
alter table catalog.food_observation_sources force row level security;
alter table catalog.food_search_events enable row level security;
alter table catalog.food_search_events force row level security;
alter table catalog.food_change_proposals enable row level security;
alter table catalog.food_change_proposals force row level security;
alter table catalog.food_decisions enable row level security;
alter table catalog.food_decisions force row level security;
alter table catalog.food_merge_candidates enable row level security;
alter table catalog.food_merge_candidates force row level security;
alter table catalog.food_embedding_jobs enable row level security;
alter table catalog.food_embedding_jobs force row level security;
alter table catalog.food_images enable row level security;
alter table catalog.food_images force row level security;
alter table catalog.catalog_menu_item_links enable row level security;
alter table catalog.catalog_menu_item_links force row level security;
alter table catalog.food_import_batches enable row level security;
alter table catalog.food_import_batches force row level security;
alter table catalog.food_import_errors enable row level security;
alter table catalog.food_import_errors force row level security;

create policy food_types_public_read on catalog.food_types
for select using (is_active or catalog.is_catalog_reviewer());
create policy preparation_methods_public_read on catalog.preparation_methods
for select using (is_active or catalog.is_catalog_reviewer());
create policy countries_public_read on catalog.countries
for select using (is_active or catalog.is_catalog_reviewer());
create policy regions_public_read on catalog.regions
for select using (is_active or catalog.is_catalog_reviewer());
create policy cuisines_public_read on catalog.cuisines
for select using (is_active or catalog.is_catalog_reviewer());
create policy categories_public_read on catalog.food_categories
for select using (is_active or catalog.is_catalog_reviewer());
create policy tags_public_read on catalog.food_tags
for select using (is_active or catalog.is_catalog_reviewer());

create policy ingredients_verified_read on catalog.ingredients
for select using (
  (verification_status = 'verified' and archived_at is null)
  or catalog.is_catalog_reviewer()
);
create policy ingredient_translations_verified_read on catalog.ingredient_translations
for select using (
  (
    status in ('reviewed', 'verified')
    and exists (
      select 1 from catalog.ingredients i
      where i.id = ingredient_id
        and i.verification_status = 'verified'
        and i.archived_at is null
    )
  ) or catalog.is_catalog_reviewer()
);
create policy allergens_verified_read on catalog.allergens
for select using (
  (verification_status = 'verified' and archived_at is null)
  or catalog.is_catalog_reviewer()
);
create policy allergen_translations_verified_read on catalog.allergen_translations
for select using (
  (
    status in ('reviewed', 'verified')
    and exists (
      select 1 from catalog.allergens a
      where a.id = allergen_id
        and a.verification_status = 'verified'
        and a.archived_at is null
    )
  ) or catalog.is_catalog_reviewer()
);

create policy foods_verified_read on catalog.foods
for select using (
  (verification_status = 'verified' and archived_at is null and merged_into_food_id is null)
  or catalog.is_catalog_reviewer()
);
create policy food_translations_verified_read on catalog.food_translations
for select using (
  (
    status in ('reviewed', 'verified')
    and exists (
      select 1 from catalog.foods f
      where f.id = food_id
        and f.verification_status = 'verified'
        and f.archived_at is null
        and f.merged_into_food_id is null
    )
  ) or catalog.is_catalog_reviewer()
);
create policy food_aliases_verified_read on catalog.food_aliases
for select using (
  (
    status in ('reviewed', 'verified')
    and exists (
      select 1 from catalog.foods f
      where f.id = food_id
        and f.verification_status = 'verified'
        and f.archived_at is null
        and f.merged_into_food_id is null
    )
  ) or catalog.is_catalog_reviewer()
);
create policy food_cuisine_links_verified_read on catalog.food_cuisine_links
for select using (
  (
    status in ('supported', 'verified')
    and exists (
      select 1 from catalog.foods f
      where f.id = food_id and f.verification_status = 'verified' and f.archived_at is null
    )
  ) or catalog.is_catalog_reviewer()
);
create policy food_category_links_verified_read on catalog.food_category_links
for select using (
  (
    status in ('supported', 'verified')
    and exists (
      select 1 from catalog.foods f
      where f.id = food_id and f.verification_status = 'verified' and f.archived_at is null
    )
  ) or catalog.is_catalog_reviewer()
);
create policy food_tag_links_verified_read on catalog.food_tag_links
for select using (
  (
    status in ('supported', 'verified')
    and exists (
      select 1 from catalog.foods f
      where f.id = food_id and f.verification_status = 'verified' and f.archived_at is null
    )
  ) or catalog.is_catalog_reviewer()
);
create policy food_ingredients_verified_read on catalog.food_ingredients
for select using (
  (
    status in ('supported', 'verified')
    and exists (
      select 1 from catalog.foods f
      where f.id = food_id and f.verification_status = 'verified' and f.archived_at is null
    )
  ) or catalog.is_catalog_reviewer()
);
create policy food_allergens_verified_read on catalog.food_allergens
for select using (
  (
    status = 'verified'
    and medically_reviewed
    and exists (
      select 1 from catalog.foods f
      where f.id = food_id and f.verification_status = 'verified' and f.archived_at is null
    )
  ) or catalog.is_catalog_reviewer()
);
create policy food_facts_verified_read on catalog.food_facts
for select using (
  (
    status = 'verified'
    and exists (
      select 1 from catalog.foods f
      where f.id = food_id and f.verification_status = 'verified' and f.archived_at is null
    )
  ) or catalog.is_catalog_reviewer()
);
create policy food_redirects_public_read on catalog.food_redirects
for select using (true);

create policy settings_reviewer_read on catalog.settings
for select using (catalog.is_catalog_reviewer());
create policy food_versions_reviewer_read on catalog.food_versions
for select using (catalog.is_catalog_reviewer());
create policy food_audit_reviewer_read on catalog.food_audit_log
for select using (catalog.is_catalog_reviewer());
create policy source_registry_reviewer_read on catalog.source_registry
for select using (catalog.is_catalog_reviewer());
create policy restaurant_access_owner_or_reviewer_read on catalog.restaurant_source_access
for select using (user_id = auth.uid() or catalog.is_catalog_reviewer());
create policy food_observations_reviewer_read on catalog.food_observations
for select using (catalog.is_catalog_reviewer());
create policy observation_sources_reviewer_read on catalog.food_observation_sources
for select using (catalog.is_catalog_reviewer());
create policy search_events_reviewer_read on catalog.food_search_events
for select using (catalog.is_catalog_reviewer());
create policy proposals_reviewer_read on catalog.food_change_proposals
for select using (catalog.is_catalog_reviewer());
create policy decisions_reviewer_read on catalog.food_decisions
for select using (catalog.is_catalog_reviewer());
create policy merge_candidates_reviewer_read on catalog.food_merge_candidates
for select using (catalog.is_catalog_reviewer());
create policy embedding_jobs_reviewer_read on catalog.food_embedding_jobs
for select using (catalog.is_catalog_reviewer());
create policy food_images_reviewer_read on catalog.food_images
for select using (catalog.is_catalog_reviewer());
create policy menu_links_reviewer_read on catalog.catalog_menu_item_links
for select using (catalog.is_catalog_reviewer());
create policy import_batches_reviewer_read on catalog.food_import_batches
for select using (catalog.is_catalog_reviewer());
create policy import_errors_reviewer_read on catalog.food_import_errors
for select using (catalog.is_catalog_reviewer());

revoke all on schema catalog from public;
grant usage on schema catalog to anon, authenticated, service_role;
revoke all on all tables in schema catalog from public, anon, authenticated;
revoke all on all sequences in schema catalog from public, anon, authenticated;
revoke all on all functions in schema catalog from public, anon, authenticated;
grant execute on function catalog.is_catalog_admin() to anon, authenticated, service_role;
grant execute on function catalog.is_catalog_reviewer() to anon, authenticated, service_role;
grant all on all tables in schema catalog to service_role;
grant all on all sequences in schema catalog to service_role;
grant execute on all functions in schema catalog to service_role;

insert into storage.buckets (
  id,
  name,
  public,
  file_size_limit,
  allowed_mime_types
) values (
  'food-images',
  'food-images',
  false,
  10485760,
  array['image/webp', 'image/jpeg', 'image/png']
) on conflict (id) do nothing;

do $$
declare
  bucket_public boolean;
begin
  select public into bucket_public from storage.buckets where id = 'food-images';
  if bucket_public is distinct from false then
    raise exception 'Existing food-images bucket must remain private';
  end if;
end;
$$;

create policy catalog_admin_food_image_read
on storage.objects for select
to authenticated
using (bucket_id = 'food-images' and catalog.is_catalog_reviewer());

create policy catalog_admin_food_image_insert
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'food-images'
  and catalog.is_catalog_admin()
  and owner_id = auth.uid()::text
  and name ~ '^foods/[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}/(original|medium|thumbnail)\.(webp|jpg|jpeg|png)$'
);

create policy catalog_admin_food_image_update
on storage.objects for update
to authenticated
using (
  bucket_id = 'food-images'
  and catalog.is_catalog_admin()
  and owner_id = auth.uid()::text
)
with check (
  bucket_id = 'food-images'
  and catalog.is_catalog_admin()
  and owner_id = auth.uid()::text
  and name ~ '^foods/[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}/(original|medium|thumbnail)\.(webp|jpg|jpeg|png)$'
);

create policy catalog_admin_food_image_delete
on storage.objects for delete
to authenticated
using (
  bucket_id = 'food-images'
  and catalog.is_catalog_admin()
  and owner_id = auth.uid()::text
);

comment on policy foods_verified_read on catalog.foods is
  'Public roles can read only verified active canonical foods; reviewers can inspect all states.';
comment on policy food_allergens_verified_read on catalog.food_allergens is
  'Only medically reviewed, verified allergen assertions are public.';

commit;
