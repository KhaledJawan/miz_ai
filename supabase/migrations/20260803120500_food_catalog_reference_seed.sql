begin;

insert into catalog.settings (key, value, description) values
  ('trust.reject_below', '40', 'Reject or archive candidates scoring below this threshold.'),
  ('trust.review_below', '70', 'Candidates below this threshold wait for more evidence.'),
  ('trust.auto_approval_floor', '90', 'Minimum trust score before low-risk auto-approval is considered.'),
  ('trust.max_independent_source_points', '35', 'Maximum points contributed by independent sources.'),
  ('trust.points_per_independent_source', '10', 'Points for each unique source fingerprint.'),
  ('trust.source_reliability_points', '20', 'Maximum reliability-weight contribution.'),
  ('trust.points_per_restaurant_source', '3', 'Points for each independent restaurant source, capped in the function.'),
  ('trust.trusted_import_points', '15', 'Points for an approved admin/staff import source.'),
  ('trust.description_quality_points', '5', 'Points for a useful bounded description.'),
  ('trust.ingredient_quality_points', '5', 'Points for at least three structured ingredients.'),
  ('trust.language_consistency_points', '3', 'Points for a validated language code.'),
  ('trust.match_consistency_points', '7', 'Maximum contribution from a catalog match.'),
  ('trust.spam_penalty_points', '50', 'Maximum spam-score penalty.'),
  ('trust.junk_penalty_points', '60', 'Maximum junk-score penalty.'),
  ('auto_approval.alias_confidence', '0.95', 'Minimum confidence for safe transliteration auto-approval.'),
  ('auto_approval.minimum_evidence', '3', 'Minimum independent evidence references for safe alias auto-approval.'),
  ('duplicate.minimum_similarity', '0.75', 'Minimum database similarity before a merge candidate is stored.'),
  ('retention.search_event_days', '90', 'Raw search-event retention before aggregation.'),
  ('retention.resolved_observation_days', '730', 'Default evidence-observation retention after resolution.')
on conflict (key) do nothing;

insert into catalog.food_types (slug, name) values
  ('prepared-dish', 'Prepared Dish'),
  ('beverage', 'Beverage'),
  ('bread', 'Bread'),
  ('dessert', 'Dessert'),
  ('snack', 'Snack'),
  ('sauce-condiment', 'Sauce or Condiment'),
  ('raw-ingredient', 'Raw Ingredient')
on conflict (slug) do nothing;

insert into catalog.preparation_methods (slug, name) values
  ('baked', 'Baked'),
  ('boiled', 'Boiled'),
  ('braised', 'Braised'),
  ('fried', 'Fried'),
  ('grilled', 'Grilled'),
  ('raw', 'Raw'),
  ('roasted', 'Roasted'),
  ('steamed', 'Steamed'),
  ('stewed', 'Stewed'),
  ('mixed', 'Mixed or Multi-step')
on conflict (slug) do nothing;

insert into catalog.countries (iso2, iso3, name) values
  ('AF', 'AFG', 'Afghanistan'),
  ('DE', 'DEU', 'Germany'),
  ('IT', 'ITA', 'Italy'),
  ('IR', 'IRN', 'Iran'),
  ('SA', 'SAU', 'Saudi Arabia'),
  ('AE', 'ARE', 'United Arab Emirates')
on conflict (iso2) do nothing;

insert into catalog.cuisines (slug, name, country_id) values
  ('afghan', 'Afghan', (select id from catalog.countries where iso2 = 'AF')),
  ('arabian-peninsula', 'Arabian Peninsula', null),
  ('emirati', 'Emirati', (select id from catalog.countries where iso2 = 'AE')),
  ('german', 'German', (select id from catalog.countries where iso2 = 'DE')),
  ('italian', 'Italian', (select id from catalog.countries where iso2 = 'IT')),
  ('persian', 'Persian', (select id from catalog.countries where iso2 = 'IR'))
on conflict (slug) do nothing;

insert into catalog.food_categories (slug, name) values
  ('main-course', 'Main Course'),
  ('dessert', 'Dessert'),
  ('soup', 'Soup'),
  ('salad', 'Salad'),
  ('street-food', 'Street Food'),
  ('fast-food', 'Fast Food'),
  ('hot-drink', 'Hot Drink'),
  ('cold-drink', 'Cold Drink'),
  ('seafood', 'Seafood'),
  ('bread', 'Bread'),
  ('sauce', 'Sauce'),
  ('snack', 'Snack')
on conflict (slug) do nothing;

insert into catalog.food_categories (parent_id, slug, name) values
  ((select id from catalog.food_categories where slug = 'main-course'), 'rice-dish', 'Rice Dish')
on conflict (slug) do nothing;

insert into catalog.allergens (
  code, canonical_name, is_regulated, jurisdiction, verification_status
) values
  ('celery', 'Celery', true, 'EU-14', 'verified'),
  ('gluten', 'Cereals containing gluten', true, 'EU-14', 'verified'),
  ('crustaceans', 'Crustaceans', true, 'EU-14', 'verified'),
  ('eggs', 'Eggs', true, 'EU-14', 'verified'),
  ('fish', 'Fish', true, 'EU-14', 'verified'),
  ('lupin', 'Lupin', true, 'EU-14', 'verified'),
  ('milk', 'Milk', true, 'EU-14', 'verified'),
  ('molluscs', 'Molluscs', true, 'EU-14', 'verified'),
  ('mustard', 'Mustard', true, 'EU-14', 'verified'),
  ('peanuts', 'Peanuts', true, 'EU-14', 'verified'),
  ('sesame', 'Sesame', true, 'EU-14', 'verified'),
  ('soybeans', 'Soybeans', true, 'EU-14', 'verified'),
  ('sulphites', 'Sulphur dioxide and sulphites', true, 'EU-14', 'verified'),
  ('tree_nuts', 'Tree nuts', true, 'EU-14', 'verified')
on conflict (code) do nothing;

insert into catalog.ingredients (
  canonical_name, normalized_name, slug, is_animal_product, is_meat,
  is_seafood, is_alcohol_related, verification_status
) values
  ('Rice', 'rice', 'rice', false, false, false, false, 'verified'),
  ('Wheat flour', 'wheat flour', 'wheat-flour', false, false, false, false, 'verified'),
  ('Tomato', 'tomato', 'tomato', false, false, false, false, 'verified'),
  ('Onion', 'onion', 'onion', false, false, false, false, 'verified'),
  ('Garlic', 'garlic', 'garlic', false, false, false, false, 'verified'),
  ('Chicken', 'chicken', 'chicken', true, true, false, false, 'verified'),
  ('Beef', 'beef', 'beef', true, true, false, false, 'verified'),
  ('Lamb', 'lamb', 'lamb', true, true, false, false, 'verified'),
  ('Egg', 'egg', 'egg', true, false, false, false, 'verified'),
  ('Milk', 'milk', 'milk', true, false, false, false, 'verified'),
  ('Cheese', 'cheese', 'cheese', true, false, false, false, 'verified'),
  ('Fish', 'fish', 'fish', true, false, true, false, 'verified'),
  ('Wine', 'wine', 'wine', false, false, false, true, 'verified')
on conflict (slug) do nothing;

commit;
