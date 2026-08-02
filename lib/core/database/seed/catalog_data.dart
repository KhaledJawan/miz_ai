/// Raw seed data for the food-profile catalog tables. Kept as plain Dart
/// records (no Drift/Flutter imports) so [SeedRunner] and tests can both
/// read it without a database. Display labels live in
/// `features/food_profile/domain/catalog_localizations.dart`, keyed by the
/// same stable `code` used here — codes are never translated (see
/// docs/DECISIONS.md ADR-014).
library;

class AllergenSeed {
  const AllergenSeed(this.code, this.category);
  final String code;
  final String category;
}

const List<AllergenSeed> kAllergenSeeds = [
  AllergenSeed('peanuts', 'common'),
  AllergenSeed('treeNuts', 'common'),
  AllergenSeed('milk', 'common'),
  AllergenSeed('eggs', 'common'),
  AllergenSeed('glutenWheat', 'common'),
  AllergenSeed('soy', 'common'),
  AllergenSeed('fish', 'common'),
  AllergenSeed('crustaceans', 'common'),
  AllergenSeed('molluscs', 'common'),
  AllergenSeed('sesame', 'common'),
  AllergenSeed('mustard', 'common'),
  AllergenSeed('celery', 'common'),
  AllergenSeed('lupin', 'common'),
  AllergenSeed('sulphites', 'common'),
];

const List<String> kIntoleranceCodes = [
  'lactose',
  'gluten',
  'fructose',
  'histamine',
  'spicyFoodSensitivity',
];

class FoodRuleSeed {
  const FoodRuleSeed(this.code, this.category);
  final String code;
  final String category;
}

const List<FoodRuleSeed> kFoodRuleSeeds = [
  FoodRuleSeed('halalRequired', 'religious'),
  FoodRuleSeed('halalPreferred', 'religious'),
  FoodRuleSeed('kosherRequired', 'religious'),
  FoodRuleSeed('noPork', 'dietary'),
  FoodRuleSeed('noAlcohol', 'dietary'),
  FoodRuleSeed('noAnimalGelatin', 'dietary'),
  FoodRuleSeed('noBeef', 'dietary'),
  FoodRuleSeed('noSeafood', 'dietary'),
  FoodRuleSeed('noRawFood', 'dietary'),
];

/// Pairs of food-rule codes that must never both be selected — enforced by
/// the onboarding controller, not the database.
const List<(String, String)> kContradictoryFoodRulePairs = [
  ('halalRequired', 'halalPreferred'),
];

class IngredientSeed {
  const IngredientSeed(
    this.code,
    this.parentCode,
    this.category, {
    this.isAnimalProduct = false,
    this.isMeat = false,
    this.isSeafood = false,
    this.isAlcoholRelated = false,
  });

  final String code;
  final String? parentCode;
  final String category;
  final bool isAnimalProduct;
  final bool isMeat;
  final bool isSeafood;
  final bool isAlcoholRelated;
}

/// Ordered parents-before-children so [SeedRunner] can resolve `parentId`
/// in a single pass.
const List<IngredientSeed> kIngredientSeeds = [
  // Top-level categories
  IngredientSeed('protein', null, 'category'),
  IngredientSeed('dairy', null, 'category', isAnimalProduct: true),
  IngredientSeed('alcohol', null, 'category', isAlcoholRelated: true),
  IngredientSeed('gelatin', null, 'category', isAnimalProduct: true),

  // protein > meat
  IngredientSeed(
    'meat',
    'protein',
    'meat',
    isAnimalProduct: true,
    isMeat: true,
  ),
  IngredientSeed('beef', 'meat', 'meat', isAnimalProduct: true, isMeat: true),
  IngredientSeed('veal', 'meat', 'meat', isAnimalProduct: true, isMeat: true),
  IngredientSeed(
    'chicken',
    'meat',
    'meat',
    isAnimalProduct: true,
    isMeat: true,
  ),
  IngredientSeed('turkey', 'meat', 'meat', isAnimalProduct: true, isMeat: true),
  IngredientSeed('lamb', 'meat', 'meat', isAnimalProduct: true, isMeat: true),
  IngredientSeed('goat', 'meat', 'meat', isAnimalProduct: true, isMeat: true),
  IngredientSeed('pork', 'meat', 'meat', isAnimalProduct: true, isMeat: true),
  IngredientSeed(
    'venison',
    'meat',
    'meat',
    isAnimalProduct: true,
    isMeat: true,
  ),
  IngredientSeed('rabbit', 'meat', 'meat', isAnimalProduct: true, isMeat: true),
  IngredientSeed('duck', 'meat', 'meat', isAnimalProduct: true, isMeat: true),
  IngredientSeed('goose', 'meat', 'meat', isAnimalProduct: true, isMeat: true),
  IngredientSeed('quail', 'meat', 'meat', isAnimalProduct: true, isMeat: true),
  IngredientSeed(
    'smallBirds',
    'meat',
    'meat',
    isAnimalProduct: true,
    isMeat: true,
  ),
  IngredientSeed(
    'organMeat',
    'meat',
    'meat',
    isAnimalProduct: true,
    isMeat: true,
  ),
  IngredientSeed(
    'processedMeat',
    'meat',
    'meat',
    isAnimalProduct: true,
    isMeat: true,
  ),
  IngredientSeed(
    'insects',
    'protein',
    'meat',
    isAnimalProduct: true,
    isMeat: false,
  ),

  // protein > seafood
  IngredientSeed(
    'seafood',
    'protein',
    'seafood',
    isAnimalProduct: true,
    isSeafood: true,
  ),
  IngredientSeed(
    'fishIngredient',
    'seafood',
    'seafood',
    isAnimalProduct: true,
    isSeafood: true,
  ),
  IngredientSeed(
    'shellfish',
    'seafood',
    'seafood',
    isAnimalProduct: true,
    isSeafood: true,
  ),
  IngredientSeed(
    'molluscsIngredient',
    'seafood',
    'seafood',
    isAnimalProduct: true,
    isSeafood: true,
  ),

  // protein > plant protein
  IngredientSeed('plantProtein', 'protein', 'plantProtein'),
  IngredientSeed('tofu', 'plantProtein', 'plantProtein'),
  IngredientSeed('legumes', 'plantProtein', 'plantProtein'),

  // protein > eggs
  IngredientSeed('eggsIngredient', 'protein', 'eggs', isAnimalProduct: true),

  // dairy children
  IngredientSeed('milkIngredient', 'dairy', 'dairy', isAnimalProduct: true),
  IngredientSeed('cheese', 'dairy', 'dairy', isAnimalProduct: true),
  IngredientSeed('yogurt', 'dairy', 'dairy', isAnimalProduct: true),
  IngredientSeed('butter', 'dairy', 'dairy', isAnimalProduct: true),

  // alcohol children
  IngredientSeed('wine', 'alcohol', 'alcohol', isAlcoholRelated: true),
  IngredientSeed('beer', 'alcohol', 'alcohol', isAlcoholRelated: true),
  IngredientSeed('spirits', 'alcohol', 'alcohol', isAlcoholRelated: true),
];

class CuisineSeed {
  const CuisineSeed(this.code, this.region);
  final String code;
  final String region;
}

const List<CuisineSeed> kCuisineSeeds = [
  CuisineSeed('afghan', 'centralAsia'),
  CuisineSeed('persian', 'middleEast'),
  CuisineSeed('german', 'europe'),
  CuisineSeed('italian', 'europe'),
  CuisineSeed('turkish', 'middleEast'),
  CuisineSeed('arabMiddleEastern', 'middleEast'),
  CuisineSeed('indian', 'southAsia'),
  CuisineSeed('chinese', 'eastAsia'),
  CuisineSeed('japanese', 'eastAsia'),
  CuisineSeed('korean', 'eastAsia'),
  CuisineSeed('thai', 'southeastAsia'),
  CuisineSeed('mexican', 'americas'),
  CuisineSeed('french', 'europe'),
  CuisineSeed('greek', 'europe'),
  CuisineSeed('mediterranean', 'europe'),
  CuisineSeed('african', 'africa'),
  CuisineSeed('american', 'americas'),
  CuisineSeed('other', 'other'),
];

const List<String> kFlavorAttributeCodes = [
  'sweet',
  'salty',
  'sour',
  'bitter',
  'umami',
  'spicy',
  'smoky',
  'creamy',
  'rich',
  'fresh',
  'crispy',
  'soft',
];

class FoodItemSeed {
  const FoodItemSeed(
    this.code,
    this.cuisineCode, {
    this.primaryIngredientCodes = const [],
    this.mayContainIngredientCodes = const [],
    this.allergenCodes = const [],
    this.mayContainAllergenCodes = const [],
    this.imageAsset,
  });

  final String code;
  final String cuisineCode;
  final List<String> primaryIngredientCodes;
  final List<String> mayContainIngredientCodes;
  final List<String> allergenCodes;
  final List<String> mayContainAllergenCodes;
  final String? imageAsset;
}

/// ~24 diverse sample foods for the onboarding "visual food selection"
/// step — not an exhaustive catalog (docs/DECISIONS.md).
const List<FoodItemSeed> kFoodItemSeeds = [
  FoodItemSeed(
    'margherita_pizza',
    'italian',
    primaryIngredientCodes: ['cheese'],
    allergenCodes: ['milk', 'glutenWheat'],
    imageAsset: 'assets/images/food_items/margherita_pizza.jpg',
  ),
  FoodItemSeed(
    'spaghetti_carbonara',
    'italian',
    primaryIngredientCodes: ['pork', 'eggsIngredient', 'cheese'],
    allergenCodes: ['glutenWheat', 'eggs', 'milk'],
    imageAsset: 'assets/images/food_items/spaghetti_carbonara.jpg',
  ),
  FoodItemSeed(
    'falafel_wrap',
    'arabMiddleEastern',
    primaryIngredientCodes: ['legumes'],
    allergenCodes: ['glutenWheat', 'sesame'],
    imageAsset: 'assets/images/food_items/falafel_wrap.jpg',
  ),
  FoodItemSeed(
    'chicken_biryani',
    'indian',
    primaryIngredientCodes: ['chicken'],
    mayContainAllergenCodes: ['milk'],
    imageAsset: 'assets/images/food_items/chicken_biryani.jpg',
  ),
  FoodItemSeed(
    'beef_pho',
    'other',
    primaryIngredientCodes: ['beef'],
    allergenCodes: ['fish'],
    imageAsset: 'assets/images/food_items/beef_pho.jpg',
  ),
  FoodItemSeed(
    'salmon_nigiri',
    'japanese',
    primaryIngredientCodes: ['fishIngredient'],
    allergenCodes: ['fish'],
    mayContainAllergenCodes: ['soy'],
    imageAsset: 'assets/images/food_items/salmon_nigiri.jpg',
  ),
  FoodItemSeed(
    'vegetable_ramen',
    'japanese',
    primaryIngredientCodes: ['tofu'],
    allergenCodes: ['soy', 'glutenWheat'],
    imageAsset: 'assets/images/food_items/vegetable_ramen.jpg',
  ),
  FoodItemSeed(
    'kimchi_stew',
    'korean',
    primaryIngredientCodes: ['pork'],
    allergenCodes: ['fish', 'soy'],
    imageAsset: 'assets/images/food_items/kimchi_stew.jpg',
  ),
  FoodItemSeed(
    'pad_thai',
    'thai',
    primaryIngredientCodes: ['shellfish', 'eggsIngredient'],
    allergenCodes: ['peanuts', 'eggs', 'crustaceans'],
    imageAsset: 'assets/images/food_items/pad_thai.jpg',
  ),
  FoodItemSeed(
    'green_curry',
    'thai',
    primaryIngredientCodes: ['chicken'],
    allergenCodes: ['fish'],
    imageAsset: 'assets/images/food_items/green_curry.jpg',
  ),
  FoodItemSeed(
    'beef_tacos',
    'mexican',
    primaryIngredientCodes: ['beef', 'cheese'],
    allergenCodes: ['milk'],
    imageAsset: 'assets/images/food_items/beef_tacos.jpg',
  ),
  FoodItemSeed(
    'black_bean_burrito',
    'mexican',
    primaryIngredientCodes: ['legumes', 'cheese'],
    allergenCodes: ['milk', 'glutenWheat'],
    imageAsset: 'assets/images/food_items/black_bean_burrito.jpg',
  ),
  FoodItemSeed(
    'coq_au_vin',
    'french',
    primaryIngredientCodes: ['chicken', 'wine'],
    imageAsset: 'assets/images/food_items/coq_au_vin.jpg',
  ),
  FoodItemSeed(
    'ratatouille',
    'french',
    imageAsset: 'assets/images/food_items/ratatouille.jpg',
  ),
  FoodItemSeed(
    'greek_moussaka',
    'greek',
    primaryIngredientCodes: ['lamb', 'cheese'],
    allergenCodes: ['milk', 'eggs'],
    imageAsset: 'assets/images/food_items/greek_moussaka.jpg',
  ),
  FoodItemSeed(
    'greek_salad',
    'mediterranean',
    primaryIngredientCodes: ['cheese'],
    allergenCodes: ['milk'],
    imageAsset: 'assets/images/food_items/greek_salad.jpg',
  ),
  FoodItemSeed(
    'hummus_plate',
    'arabMiddleEastern',
    primaryIngredientCodes: ['legumes'],
    allergenCodes: ['sesame'],
    imageAsset: 'assets/images/food_items/hummus_plate.jpg',
  ),
  FoodItemSeed(
    'persian_kebab',
    'persian',
    primaryIngredientCodes: ['lamb'],
    imageAsset: 'assets/images/food_items/persian_kebab.jpg',
  ),
  FoodItemSeed(
    'schnitzel',
    'german',
    primaryIngredientCodes: ['pork'],
    allergenCodes: ['glutenWheat', 'eggs'],
    imageAsset: 'assets/images/food_items/schnitzel.jpg',
  ),
  FoodItemSeed(
    'pretzel',
    'german',
    allergenCodes: ['glutenWheat'],
    imageAsset: 'assets/images/food_items/pretzel.jpg',
  ),
  FoodItemSeed(
    'jollof_rice',
    'african',
    imageAsset: 'assets/images/food_items/jollof_rice.jpg',
  ),
  FoodItemSeed(
    'classic_cheeseburger',
    'american',
    primaryIngredientCodes: ['beef', 'cheese'],
    allergenCodes: ['glutenWheat', 'milk'],
    imageAsset: 'assets/images/food_items/classic_cheeseburger.jpg',
  ),
  FoodItemSeed(
    'vegan_buddha_bowl',
    'american',
    primaryIngredientCodes: ['legumes', 'tofu'],
    allergenCodes: ['soy'],
    imageAsset: 'assets/images/food_items/vegan_buddha_bowl.jpg',
  ),
  FoodItemSeed(
    'chocolate_lava_cake',
    'french',
    primaryIngredientCodes: ['eggsIngredient', 'butter'],
    allergenCodes: ['glutenWheat', 'eggs', 'milk'],
    imageAsset: 'assets/images/food_items/chocolate_lava_cake.jpg',
  ),
];
