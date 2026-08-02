/// Display labels for every stable catalog `code` seeded by
/// `core/database/seed/catalog_data.dart`, in the app's three shipped
/// languages. Codes themselves are never translated (docs/DECISIONS.md
/// ADR-014) — this is the one place a code turns into user-facing text.
/// Falls back to English, then to a humanized version of the code itself,
/// so a missing translation never crashes or shows a raw code to the user.
library;

const Map<String, Map<String, String>> kCatalogLabels = {
  // Diet types
  'vegan': {'en': 'Vegan', 'de': 'Vegan', 'fa': 'وگان'},
  'vegetarian': {'en': 'Vegetarian', 'de': 'Vegetarisch', 'fa': 'گیاه‌خوار'},
  'pescatarian': {'en': 'Pescatarian', 'de': 'Pescetarisch', 'fa': 'پسکاتارین'},
  'flexitarian': {
    'en': 'Flexitarian',
    'de': 'Flexitarisch',
    'fa': 'فلکسیتارین',
  },
  'omnivore': {
    'en': 'I eat everything',
    'de': 'Ich esse alles',
    'fa': 'همه‌چیزخوار',
  },
  'other': {'en': 'Other', 'de': 'Andere', 'fa': 'دیگر'},
  'preferNotToSay': {
    'en': 'Prefer not to say',
    'de': 'Möchte ich nicht angeben',
    'fa': 'ترجیح می‌دهم نگویم',
  },

  // Food rules
  'halalRequired': {
    'en': 'Halal required',
    'de': 'Halal erforderlich',
    'fa': 'حلال الزامی',
  },
  'halalPreferred': {
    'en': 'Prefer halal',
    'de': 'Halal bevorzugt',
    'fa': 'ترجیحاً حلال',
  },
  'kosherRequired': {
    'en': 'Kosher required',
    'de': 'Koscher erforderlich',
    'fa': 'کوشر الزامی',
  },
  'noPork': {
    'en': 'No pork',
    'de': 'Kein Schweinefleisch',
    'fa': 'بدون گوشت خوک',
  },
  'noAlcohol': {'en': 'No alcohol', 'de': 'Kein Alkohol', 'fa': 'بدون الکل'},
  'noAnimalGelatin': {
    'en': 'No animal-derived gelatin',
    'de': 'Keine tierische Gelatine',
    'fa': 'بدون ژلاتین حیوانی',
  },
  'noBeef': {'en': 'No beef', 'de': 'Kein Rindfleisch', 'fa': 'بدون گوشت گاو'},
  'noSeafood': {
    'en': 'No seafood',
    'de': 'Keine Meeresfrüchte',
    'fa': 'بدون غذای دریایی',
  },
  'noRawFood': {
    'en': 'No raw food',
    'de': 'Keine rohen Speisen',
    'fa': 'بدون غذای خام',
  },

  // Allergens
  'peanuts': {'en': 'Peanuts', 'de': 'Erdnüsse', 'fa': 'بادام‌زمینی'},
  'treeNuts': {'en': 'Tree nuts', 'de': 'Schalenfrüchte', 'fa': 'آجیل درختی'},
  'milk': {'en': 'Milk', 'de': 'Milch', 'fa': 'شیر'},
  'eggs': {'en': 'Eggs', 'de': 'Eier', 'fa': 'تخم‌مرغ'},
  'glutenWheat': {
    'en': 'Gluten or wheat',
    'de': 'Gluten oder Weizen',
    'fa': 'گلوتن یا گندم',
  },
  'soy': {'en': 'Soy', 'de': 'Soja', 'fa': 'سویا'},
  'fish': {'en': 'Fish', 'de': 'Fisch', 'fa': 'ماهی'},
  'crustaceans': {'en': 'Crustaceans', 'de': 'Krebstiere', 'fa': 'سخت‌پوستان'},
  'molluscs': {'en': 'Molluscs', 'de': 'Weichtiere', 'fa': 'نرم‌تنان'},
  'sesame': {'en': 'Sesame', 'de': 'Sesam', 'fa': 'کنجد'},
  'mustard': {'en': 'Mustard', 'de': 'Senf', 'fa': 'خردل'},
  'celery': {'en': 'Celery', 'de': 'Sellerie', 'fa': 'کرفس'},
  'lupin': {'en': 'Lupin', 'de': 'Lupine', 'fa': 'لوپن'},
  'sulphites': {'en': 'Sulphites', 'de': 'Sulfite', 'fa': 'سولفیت‌ها'},

  // Intolerances
  'lactose': {'en': 'Lactose', 'de': 'Laktose', 'fa': 'لاکتوز'},
  'gluten': {'en': 'Gluten', 'de': 'Gluten', 'fa': 'گلوتن'},
  'fructose': {'en': 'Fructose', 'de': 'Fruktose', 'fa': 'فروکتوز'},
  'histamine': {'en': 'Histamine', 'de': 'Histamin', 'fa': 'هیستامین'},
  'spicyFoodSensitivity': {
    'en': 'Spicy food sensitivity',
    'de': 'Empfindlichkeit gegen scharfes Essen',
    'fa': 'حساسیت به غذای تند',
  },

  // Ingredient categories
  'protein': {'en': 'Protein', 'de': 'Protein', 'fa': 'پروتئین'},
  'dairy': {'en': 'Dairy', 'de': 'Milchprodukte', 'fa': 'لبنیات'},
  'alcohol': {'en': 'Alcohol', 'de': 'Alkohol', 'fa': 'الکل'},
  'gelatin': {'en': 'Gelatin', 'de': 'Gelatine', 'fa': 'ژلاتین'},
  'meat': {'en': 'Meat', 'de': 'Fleisch', 'fa': 'گوشت'},
  'beef': {'en': 'Beef', 'de': 'Rindfleisch', 'fa': 'گوشت گاو'},
  'veal': {'en': 'Veal', 'de': 'Kalbfleisch', 'fa': 'گوشت گوساله'},
  'chicken': {'en': 'Chicken', 'de': 'Hähnchen', 'fa': 'مرغ'},
  'turkey': {'en': 'Turkey', 'de': 'Truthahn', 'fa': 'بوقلمون'},
  'lamb': {'en': 'Lamb', 'de': 'Lamm', 'fa': 'بره'},
  'goat': {'en': 'Goat', 'de': 'Ziege', 'fa': 'بز'},
  'pork': {'en': 'Pork', 'de': 'Schweinefleisch', 'fa': 'گوشت خوک'},
  'venison': {'en': 'Venison', 'de': 'Wildfleisch', 'fa': 'گوشت گوزن'},
  'rabbit': {'en': 'Rabbit', 'de': 'Kaninchen', 'fa': 'خرگوش'},
  'duck': {'en': 'Duck', 'de': 'Ente', 'fa': 'اردک'},
  'goose': {'en': 'Goose', 'de': 'Gans', 'fa': 'غاز'},
  'quail': {'en': 'Quail', 'de': 'Wachtel', 'fa': 'بلدرچین'},
  'smallBirds': {'en': 'Small birds', 'de': 'Kleinvögel', 'fa': 'پرندگان کوچک'},
  'organMeat': {'en': 'Organ meat', 'de': 'Innereien', 'fa': 'احشاء'},
  'processedMeat': {
    'en': 'Processed meat',
    'de': 'Verarbeitetes Fleisch',
    'fa': 'گوشت فرآوری‌شده',
  },
  'insects': {'en': 'Insects', 'de': 'Insekten', 'fa': 'حشرات'},
  'seafood': {'en': 'Seafood', 'de': 'Meeresfrüchte', 'fa': 'غذای دریایی'},
  'fishIngredient': {'en': 'Fish', 'de': 'Fisch', 'fa': 'ماهی'},
  'shellfish': {'en': 'Shellfish', 'de': 'Schalentiere', 'fa': 'صدف‌داران'},
  'molluscsIngredient': {
    'en': 'Molluscs',
    'de': 'Weichtiere',
    'fa': 'نرم‌تنان',
  },
  'plantProtein': {
    'en': 'Plant protein',
    'de': 'Pflanzliches Protein',
    'fa': 'پروتئین گیاهی',
  },
  'tofu': {'en': 'Tofu', 'de': 'Tofu', 'fa': 'توفو'},
  'legumes': {'en': 'Legumes', 'de': 'Hülsenfrüchte', 'fa': 'حبوبات'},
  'eggsIngredient': {'en': 'Eggs', 'de': 'Eier', 'fa': 'تخم‌مرغ'},
  'milkIngredient': {'en': 'Milk', 'de': 'Milch', 'fa': 'شیر'},
  'cheese': {'en': 'Cheese', 'de': 'Käse', 'fa': 'پنیر'},
  'yogurt': {'en': 'Yogurt', 'de': 'Joghurt', 'fa': 'ماست'},
  'butter': {'en': 'Butter', 'de': 'Butter', 'fa': 'کره'},
  'wine': {'en': 'Wine', 'de': 'Wein', 'fa': 'شراب'},
  'beer': {'en': 'Beer', 'de': 'Bier', 'fa': 'آبجو'},
  'spirits': {'en': 'Spirits', 'de': 'Spirituosen', 'fa': 'مشروبات الکلی'},

  // Cuisines
  'afghan': {'en': 'Afghan', 'de': 'Afghanisch', 'fa': 'افغانی'},
  'persian': {'en': 'Persian', 'de': 'Persisch', 'fa': 'ایرانی'},
  'german': {'en': 'German', 'de': 'Deutsch', 'fa': 'آلمانی'},
  'italian': {'en': 'Italian', 'de': 'Italienisch', 'fa': 'ایتالیایی'},
  'turkish': {'en': 'Turkish', 'de': 'Türkisch', 'fa': 'ترکی'},
  'arabMiddleEastern': {
    'en': 'Arab / Middle Eastern',
    'de': 'Arabisch / Nahost',
    'fa': 'عربی / خاورمیانه',
  },
  'indian': {'en': 'Indian', 'de': 'Indisch', 'fa': 'هندی'},
  'chinese': {'en': 'Chinese', 'de': 'Chinesisch', 'fa': 'چینی'},
  'japanese': {'en': 'Japanese', 'de': 'Japanisch', 'fa': 'ژاپنی'},
  'korean': {'en': 'Korean', 'de': 'Koreanisch', 'fa': 'کره‌ای'},
  'thai': {'en': 'Thai', 'de': 'Thailändisch', 'fa': 'تایلندی'},
  'mexican': {'en': 'Mexican', 'de': 'Mexikanisch', 'fa': 'مکزیکی'},
  'french': {'en': 'French', 'de': 'Französisch', 'fa': 'فرانسوی'},
  'greek': {'en': 'Greek', 'de': 'Griechisch', 'fa': 'یونانی'},
  'mediterranean': {
    'en': 'Mediterranean',
    'de': 'Mediterran',
    'fa': 'مدیترانه‌ای',
  },
  'african': {'en': 'African', 'de': 'Afrikanisch', 'fa': 'آفریقایی'},
  'american': {'en': 'American', 'de': 'Amerikanisch', 'fa': 'آمریکایی'},

  // Flavor attributes
  'sweet': {'en': 'Sweet', 'de': 'Süß', 'fa': 'شیرین'},
  'salty': {'en': 'Salty', 'de': 'Salzig', 'fa': 'شور'},
  'sour': {'en': 'Sour', 'de': 'Sauer', 'fa': 'ترش'},
  'bitter': {'en': 'Bitter', 'de': 'Bitter', 'fa': 'تلخ'},
  'umami': {'en': 'Umami', 'de': 'Umami', 'fa': 'اومامی'},
  'spicy': {'en': 'Spicy', 'de': 'Scharf', 'fa': 'تند'},
  'smoky': {'en': 'Smoky', 'de': 'Rauchig', 'fa': 'دودی'},
  'creamy': {'en': 'Creamy', 'de': 'Cremig', 'fa': 'خامه‌ای'},
  'rich': {'en': 'Rich', 'de': 'Kräftig', 'fa': 'غنی'},
  'fresh': {'en': 'Fresh', 'de': 'Frisch', 'fa': 'تازه'},
  'crispy': {'en': 'Crispy', 'de': 'Knusprig', 'fa': 'ترد'},
  'soft': {'en': 'Soft', 'de': 'Weich', 'fa': 'نرم'},

  // Sample food items
  'margherita_pizza': {
    'en': 'Margherita Pizza',
    'de': 'Pizza Margherita',
    'fa': 'پیتزا مارگاریتا',
  },
  'spaghetti_carbonara': {
    'en': 'Spaghetti Carbonara',
    'de': 'Spaghetti Carbonara',
    'fa': 'اسپاگتی کاربونارا',
  },
  'falafel_wrap': {
    'en': 'Falafel Wrap',
    'de': 'Falafel-Wrap',
    'fa': 'ساندویچ فلافل',
  },
  'chicken_biryani': {
    'en': 'Chicken Biryani',
    'de': 'Hähnchen-Biryani',
    'fa': 'مرغ بریانی',
  },
  'beef_pho': {'en': 'Beef Pho', 'de': 'Rindfleisch-Pho', 'fa': 'فو گوشت'},
  'salmon_nigiri': {
    'en': 'Salmon Nigiri',
    'de': 'Lachs-Nigiri',
    'fa': 'نیگیری سالمون',
  },
  'vegetable_ramen': {
    'en': 'Vegetable Ramen',
    'de': 'Gemüse-Ramen',
    'fa': 'رامن سبزیجات',
  },
  'kimchi_stew': {
    'en': 'Kimchi Stew',
    'de': 'Kimchi-Eintopf',
    'fa': 'خورش کیمچی',
  },
  'pad_thai': {'en': 'Pad Thai', 'de': 'Pad Thai', 'fa': 'پاد تای'},
  'green_curry': {'en': 'Green Curry', 'de': 'Grünes Curry', 'fa': 'کاری سبز'},
  'beef_tacos': {
    'en': 'Beef Tacos',
    'de': 'Rindfleisch-Tacos',
    'fa': 'تاکوی گوشت',
  },
  'black_bean_burrito': {
    'en': 'Black Bean Burrito',
    'de': 'Burrito mit schwarzen Bohnen',
    'fa': 'بوریتو لوبیا سیاه',
  },
  'coq_au_vin': {'en': 'Coq au Vin', 'de': 'Coq au Vin', 'fa': 'کوک او ون'},
  'ratatouille': {'en': 'Ratatouille', 'de': 'Ratatouille', 'fa': 'راتاتویی'},
  'greek_moussaka': {
    'en': 'Greek Moussaka',
    'de': 'Griechische Moussaka',
    'fa': 'موساکای یونانی',
  },
  'greek_salad': {
    'en': 'Greek Salad',
    'de': 'Griechischer Salat',
    'fa': 'سالاد یونانی',
  },
  'hummus_plate': {
    'en': 'Hummus Plate',
    'de': 'Hummusteller',
    'fa': 'بشقاب حمص',
  },
  'persian_kebab': {
    'en': 'Persian Kebab',
    'de': 'Persischer Kebab',
    'fa': 'کباب ایرانی',
  },
  'schnitzel': {'en': 'Schnitzel', 'de': 'Schnitzel', 'fa': 'اشنیتسل'},
  'pretzel': {'en': 'Pretzel', 'de': 'Brezel', 'fa': 'برتزل'},
  'jollof_rice': {'en': 'Jollof Rice', 'de': 'Jollof-Reis', 'fa': 'برنج جولوف'},
  'classic_cheeseburger': {
    'en': 'Classic Cheeseburger',
    'de': 'Klassischer Cheeseburger',
    'fa': 'چیزبرگر کلاسیک',
  },
  'vegan_buddha_bowl': {
    'en': 'Vegan Buddha Bowl',
    'de': 'Veganer Buddha Bowl',
    'fa': 'کاسه بودا وگان',
  },
  'chocolate_lava_cake': {
    'en': 'Chocolate Lava Cake',
    'de': 'Schokoladenkuchen mit flüssigem Kern',
    'fa': 'کیک لاوای شکلاتی',
  },
};

/// Resolves [code] to a display label for [languageCode], falling back to
/// English and then to a humanized version of the code itself.
String catalogLabel(String code, String languageCode) {
  final entry = kCatalogLabels[code];
  if (entry == null) return _humanize(code);
  return entry[languageCode] ?? entry['en'] ?? _humanize(code);
}

String _humanize(String code) {
  final withSpaces = code.replaceAllMapped(
    RegExp('([a-z0-9])([A-Z])'),
    (m) => '${m[1]} ${m[2]}',
  );
  final normalized = withSpaces.replaceAll('_', ' ');
  if (normalized.isEmpty) return normalized;
  return normalized[0].toUpperCase() + normalized.substring(1);
}
