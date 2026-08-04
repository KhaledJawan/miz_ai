// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'Miz';

  @override
  String get conversationTitle => 'گفت‌وگو';

  @override
  String get recommendationsTitle => 'پیشنهادها';

  @override
  String get restaurantDetailsTitle => 'جزئیات رستوران';

  @override
  String get discoverTitle => 'کاوش';

  @override
  String get menuTitle => 'منو';

  @override
  String get reserveTitle => 'رزرو';

  @override
  String get checkoutTitle => 'پرداخت';

  @override
  String get orderTrackingTitle => 'پیگیری سفارش';

  @override
  String get comingSoonMessage =>
      'این بخش در برنامهٔ توسعه قرار دارد و هنوز ساخته نشده است.';

  @override
  String get backToHome => 'بازگشت به خانه';

  @override
  String get mizThinking => 'Miz در حال فکر کردن است';

  @override
  String get mizListening => 'Miz در حال شنیدن است';

  @override
  String get mizTaskComplete => 'Miz کار را انجام داد';

  @override
  String restaurantPhoto(String name) {
    return 'عکس رستوران $name';
  }

  @override
  String restaurantImagePlaceholder(String name) {
    return 'جایگزین تصویر رستوران $name';
  }

  @override
  String get meetMiz => 'با Miz آشنا شوید.';

  @override
  String get onboardingIntroDescription =>
      'همراه هوشمند غذایی شما برای انتخاب غذا، پیدا کردن آن و سفارش دادن.';

  @override
  String get findNearbyTitle => 'اطراف خود را پیدا کنید';

  @override
  String get findNearbyDescription =>
      'بهترین رستوران‌های اطراف را همراه با فاصله، زمان ارسال و وضعیت دسترسی دقیق ببینید.';

  @override
  String get rememberChoicesTitle => 'انتخاب‌هایم را به خاطر بسپار؟';

  @override
  String get rememberChoicesDescription =>
      'اجازه دهید Miz سلیقهٔ شما را یاد بگیرد تا هر پیشنهاد سریع‌تر و شخصی‌تر شود.';

  @override
  String get personalizeMiz => 'شخصی‌سازی Miz';

  @override
  String get changeAnytime =>
      'هر زمان بخواهید می‌توانید این گزینه را تغییر دهید.';

  @override
  String get getStarted => 'شروع کنید';

  @override
  String get allowLocation => 'اجازهٔ دسترسی به موقعیت';

  @override
  String get continueLabel => 'ادامه';

  @override
  String get notNow => 'فعلاً نه';

  @override
  String get nearYou => 'نزدیک شما';

  @override
  String get profile => 'پروفایل';

  @override
  String get openTodayOffers => 'باز کردن پیشنهادهای امروز';

  @override
  String get todayOffers => 'پیشنهادهای امروز';

  @override
  String get offerDescription => '۲۰٪ تخفیف دسر، فقط امشب';

  @override
  String get hungry => 'گرسنه‌ام';

  @override
  String get orderFood => 'سفارش غذا';

  @override
  String get reserveTable => 'رزرو میز';

  @override
  String get findCafe => 'پیدا کردن کافه';

  @override
  String get yourFavorites => 'علاقه‌مندی‌های شما';

  @override
  String get seeAll => 'مشاهدهٔ همه';

  @override
  String get foodPrompt => 'دوست دارید چه غذایی بخورید؟';

  @override
  String get addPhotoComingSoon => 'افزودن عکس (به‌زودی)';

  @override
  String get voiceComingSoon => 'ورودی صوتی (به‌زودی)';

  @override
  String get send => 'ارسال';

  @override
  String get tasteProfilePreferences => 'پروفایل ذائقه و ترجیحات';

  @override
  String get closeSettings => 'بستن تنظیمات';

  @override
  String get preferences => 'تنظیمات';

  @override
  String get language => 'زبان';

  @override
  String get darkMode => 'حالت تاریک';

  @override
  String get notifications => 'اعلان‌ها';

  @override
  String get locationPermission => 'دسترسی به موقعیت';

  @override
  String get rememberMyPreferences => 'ترجیحاتم را به خاطر بسپار';

  @override
  String get supportAndPrivacy => 'پشتیبانی و حریم خصوصی';

  @override
  String get privacy => 'حریم خصوصی';

  @override
  String get about => 'دربارهٔ Miz';

  @override
  String get help => 'راهنما';

  @override
  String get logOut => 'خروج از حساب';

  @override
  String get chooseLanguage => 'انتخاب زبان';

  @override
  String selectedLanguage(String language) {
    return 'زبان انتخاب‌شده: $language';
  }

  @override
  String get noLimit => 'بدون محدودیت';

  @override
  String distanceMeters(int distance) {
    return '$distance متر';
  }

  @override
  String distanceKilometers(String distance) {
    return '$distance کیلومتر';
  }

  @override
  String minutesShort(int minutes) {
    return '$minutes دقیقه';
  }

  @override
  String get openNow => 'اکنون باز است';

  @override
  String get cuisineItalian => 'ایتالیایی';

  @override
  String get cuisineBurger => 'برگر';

  @override
  String get cuisineAsian => 'آسیایی';

  @override
  String get cuisineHealthy => 'سالم';

  @override
  String get cuisineDessert => 'دسر';

  @override
  String get cuisineCafe => 'کافه';

  @override
  String get cuisineDrinks => 'کافهٔ شراب';

  @override
  String get dietStepTitle => 'کدام گزینه بهتر رژیم غذایی شما را توصیف می‌کند؟';

  @override
  String get dietVegan => 'وگان';

  @override
  String get dietVegetarian => 'گیاه‌خوار';

  @override
  String get dietPescatarian => 'پسکتارین (فقط ماهی و غذای دریایی)';

  @override
  String get dietFlexitarian => 'فلکسیتارین';

  @override
  String get dietOmnivore => 'همه‌چیزخوار';

  @override
  String get dietOther => 'سایر';

  @override
  String get dietPreferNotToSay => 'ترجیح می‌دهم نگویم';

  @override
  String get foodRulesStepTitle => 'قانون خاصی برای غذا خوردن دارید؟';

  @override
  String get foodRulesStepHint =>
      'روی هر مورد ضربه بزنید تا آن را الزامی، ترجیحی یا موردی برای پرهیز علامت بزنید.';

  @override
  String get requirementRequired => 'الزامی';

  @override
  String get requirementPreferred => 'ترجیحی';

  @override
  String get requirementAvoid => 'پرهیز';

  @override
  String get allergiesStepTitle => 'آیا آلرژی غذایی دارید؟';

  @override
  String get noKnownAllergies => 'هیچ آلرژی شناخته‌شده‌ای ندارم';

  @override
  String get searchAllergens => 'جست‌وجوی آلرژن‌ها';

  @override
  String get customAllergyHint => 'افزودن آلرژی‌ای که در فهرست نیست';

  @override
  String get addCustomAllergy => 'افزودن';

  @override
  String get allergySafetyNotice =>
      'این اطلاعات کمک می‌کند غذاهای ناایمن پیشنهاد نشوند، اما همیشه پیش از سفارش، آلرژن‌ها را با رستوران تأیید کنید.';

  @override
  String get severityMild => 'خفیف';

  @override
  String get severityModerate => 'متوسط';

  @override
  String get severitySevere => 'شدید';

  @override
  String get severityUnspecified => 'مشخص نشده';

  @override
  String get severeAllergyConfirmTitle => 'تأیید آلرژی شدید';

  @override
  String get severeAllergyConfirmBody =>
      'شما یک آلرژی شدید را علامت زده‌اید. ما همیشه غذاهای حاوی آن را حذف می‌کنیم. ادامه می‌دهید؟';

  @override
  String get intolerancesStepTitle => 'آیا حساسیت غذایی (عدم تحمل) دارید؟';

  @override
  String get intolerancesStepHint =>
      'این با آلرژی فرق دارد — از آن برای بهبود پیشنهادها استفاده می‌کنیم، نه برای حذف کامل غذاها.';

  @override
  String get noneOfTheAbove => 'هیچ‌کدام';

  @override
  String get proteinsStepTitle => 'چه پروتئین‌هایی می‌خورید؟';

  @override
  String get showFewerOptions => 'نمایش گزینه‌های کمتر';

  @override
  String get showMoreOptions => 'نمایش گزینه‌های بیشتر';

  @override
  String get eatAndLike => 'می‌خورم و دوست دارم';

  @override
  String get dislikeIngredient => 'دوست ندارم';

  @override
  String get neverEat => 'هرگز نمی‌خورم';

  @override
  String get cuisinesStepTitle => 'کدام غذاهای ملی را دوست دارید؟';

  @override
  String get searchCuisines => 'جست‌وجوی غذاهای ملی';

  @override
  String get preferenceLove => 'خیلی دوست دارم';

  @override
  String get preferenceLike => 'دوست دارم';

  @override
  String get preferenceCurious => 'کنجکاوم';

  @override
  String get preferenceNotInterested => 'علاقه‌ای ندارم';

  @override
  String get flavorsStepTitle => 'چه طعم‌هایی را دوست دارید؟';

  @override
  String get spiceNotSpicy => 'بدون تندی';

  @override
  String get spiceMild => 'کمی تند';

  @override
  String get spiceMedium => 'تندی متوسط';

  @override
  String get spiceHot => 'تند';

  @override
  String get spiceVeryHot => 'خیلی تند';

  @override
  String get eatingStyleStepTitle => 'چگونه غذا خوردن را ترجیح می‌دهید؟';

  @override
  String get adventurousnessQuestion => 'چقدر غذاهای جدید امتحان می‌کنید؟';

  @override
  String get adventurousnessAlmostNever => 'تقریباً هرگز';

  @override
  String get adventurousnessSometimes => 'گاهی اوقات';

  @override
  String get adventurousnessOften => 'اغلب';

  @override
  String get adventurousnessAlmostAlways => 'تقریباً همیشه';

  @override
  String get topPrioritiesQuestion => 'چه چیزی برای شما مهم‌تر است؟';

  @override
  String get topPrioritiesHint => 'حداکثر ۳ مورد را انتخاب کنید.';

  @override
  String get priorityTaste => 'طعم';

  @override
  String get priorityPrice => 'قیمت';

  @override
  String get priorityHealth => 'سلامت';

  @override
  String get priorityPortionSize => 'اندازهٔ سهم غذا';

  @override
  String get priorityIngredients => 'مواد اولیه';

  @override
  String get priorityAppearance => 'ظاهر غذا';

  @override
  String get priorityPreparationTime => 'زمان آماده‌سازی';

  @override
  String get priorityPopularity => 'محبوبیت';

  @override
  String get priorityFamiliarity => 'آشنا بودن';

  @override
  String get prioritySomethingNew => 'چیزی تازه';

  @override
  String get mealWeightQuestion => 'غذایتان چقدر سنگین باشد بهتر است؟';

  @override
  String get mealWeightLight => 'سبک';

  @override
  String get mealWeightBalanced => 'متعادل';

  @override
  String get mealWeightFilling => 'سیرکننده';

  @override
  String get mealWeightDepends => 'بستگی به موقعیت دارد';

  @override
  String get budgetQuestion => 'بودجهٔ معمول شما چقدر است؟';

  @override
  String get budgetOptionalHint => 'اختیاری — می‌توانید رد شوید.';

  @override
  String get budgetLow => 'کم';

  @override
  String get budgetMedium => 'متوسط';

  @override
  String get budgetHigh => 'زیاد';

  @override
  String get budgetNoPreference => 'بدون ترجیح';

  @override
  String get foodSamplesStepTitle => 'چند غذا برای آشنایی با سلیقهٔ شما';

  @override
  String get foodSamplesStepHint =>
      'روی هرکدام ضربه بزنید تا نظرتان را بگویید — پاسخ اشتباهی وجود ندارد.';

  @override
  String get foodSampleLike => 'دوست دارم';

  @override
  String get foodSampleCurious => 'کنجکاوم';

  @override
  String get foodSampleNeverTried => 'هرگز امتحان نکرده‌ام';

  @override
  String get foodSampleDislike => 'دوست ندارم';

  @override
  String get reviewStepTitle => 'مرور پروفایل ذائقهٔ شما';

  @override
  String get reviewAnswered => 'پاسخ داده شده';

  @override
  String get reviewNotAnswered => 'هنوز پاسخ داده نشده';

  @override
  String reviewSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مورد انتخاب شده',
      one: '۱ مورد انتخاب شده',
    );
    return '$_temp0';
  }

  @override
  String get reviewEdit => 'ویرایش';

  @override
  String get foodProfileWelcomeTitle => 'بیایید سلیقهٔ شما را بشناسیم';

  @override
  String get foodProfileWelcomeBody =>
      'چند سؤال کوتاه به Miz کمک می‌کند غذاهایی را پیشنهاد دهد که واقعاً دوست دارید. هر پاسخ را بعداً می‌توانید تغییر دهید.';

  @override
  String get foodProfileBack => 'بازگشت';

  @override
  String get foodProfileComplete => 'پایان';

  @override
  String get cancelLabel => 'لغو';

  @override
  String get doneLabel => 'تمام';

  @override
  String get foodProfileTitle => 'پروفایل ذائقه';

  @override
  String get foodProfilePreferences => 'پروفایل ذائقه';

  @override
  String get foodProfileSectionsLabel => 'پاسخ‌های شما';

  @override
  String get foodProfileCompletenessLabel => 'میزان تکمیل پروفایل';

  @override
  String foodProfileLastUpdated(String date) {
    return 'آخرین به‌روزرسانی $date';
  }

  @override
  String get foodProfilePrivacyLabel => 'حریم خصوصی و بازنشانی';

  @override
  String get behaviorPersonalizationToggle => 'شخصی‌سازی بر اساس فعالیتم';

  @override
  String get behaviorPersonalizationHint =>
      'به Miz اجازه می‌دهد پیشنهادها را بر اساس مواردی که می‌بینید، ذخیره می‌کنید یا پنهان می‌کنید بهبود دهد. پاسخ‌های صریح شما همیشه حفظ می‌شوند.';

  @override
  String get deleteInteractionHistory => 'حذف تاریخچهٔ فعالیت';

  @override
  String get deleteInteractionHistoryConfirmBody =>
      'این کار تاریخچهٔ فعالیت محلی‌ای را که Miz برای بهبود پیشنهادها استفاده می‌کند حذف می‌کند. پاسخ‌های صریح، آلرژی‌ها و ترجیحات شما تحت تأثیر قرار نمی‌گیرند.';

  @override
  String get restartOnboardingAction => 'شروع دوبارهٔ راه‌اندازی';

  @override
  String get restartOnboardingConfirmBody =>
      'همهٔ سؤال‌ها را دوباره از ابتدا خواهید دید. پاسخ‌های فعلی شما تا زمانی که تغییرشان ندهید باقی می‌مانند.';

  @override
  String get resetFoodProfileAction => 'بازنشانی پروفایل ذائقه';

  @override
  String get resetFoodProfileConfirmBody =>
      'این کار همهٔ ترجیحات غذایی، آلرژی‌ها، محدودیت‌ها و تاریخچهٔ فعالیت شما را برای همیشه حذف می‌کند. این عمل قابل بازگشت نیست.';

  @override
  String get foodProfilePrivacyNotice =>
      'پروفایل ذائقهٔ شما روی همین دستگاه ذخیره می‌شود و برای شخصی‌سازی پیشنهادهای Miz استفاده می‌شود. جایگزین تأیید مستقیم آلرژن‌ها با رستوران نیست.';

  @override
  String get spatialHomeInputLabel => 'به Miz بگویید چه می‌خواهید بخورید';

  @override
  String get promptWhatToday => 'امروز چه بخورم؟';

  @override
  String get promptMatchTaste => 'چیزی متناسب با ذائقه‌ام پیدا کن.';

  @override
  String get promptRestaurantsNearby => 'رستوران‌های عالی نزدیک را نشان بده.';

  @override
  String get promptSomethingNew => 'می‌خواهم چیز تازه‌ای امتحان کنم.';

  @override
  String get promptLightMeal => 'برای امشب یک غذای سبک پیدا کن.';

  @override
  String get promptNearMeNow => 'همین حالا نزدیک من چه می‌توانم بخورم؟';

  @override
  String get promptSpicy => 'یک غذای تند می‌خواهم.';

  @override
  String get promptCafe => 'یک کافهٔ خوب نزدیک پیدا کن.';

  @override
  String get cameraAction => 'باز کردن دوربین';

  @override
  String get bookmarksAction => 'باز کردن ذخیره‌شده‌ها';

  @override
  String get profileSettingsAction => 'باز کردن پروفایل و تنظیمات';

  @override
  String get selectCity => 'انتخاب شهر';

  @override
  String get noCitySelected => 'یک شهر انتخاب کنید';

  @override
  String get locationNeededTitle => 'نیاز به موقعیت مکانی';

  @override
  String get locationNeededBody =>
      'یک شهر انتخاب کنید یا موقعیت مکانی خود را به اشتراک بگذارید تا Miz بتواند مکان‌های نزدیک شما را پیدا کند.';

  @override
  String changeCity(String city) {
    return 'تغییر شهر: $city';
  }

  @override
  String get searchCity => 'جست‌وجوی شهر';

  @override
  String get useCurrentLocation => 'استفاده از موقعیت فعلی';

  @override
  String get currentLocationPrivacy =>
      'فقط با انتخاب شما درخواست می‌شود. انتخاب دستی شهر همیشه در دسترس است.';

  @override
  String get recentCities => 'شهرهای اخیر';

  @override
  String get availableCities => 'شهرهای موجود';

  @override
  String get setAsDefault => 'این شهر پیش‌فرض باشد';

  @override
  String get clearLocation => 'پاک کردن شهر انتخابی و پیش‌فرض';

  @override
  String get locationDeniedTitle => 'دسترسی موقعیت رد شد';

  @override
  String get locationDeniedBody =>
      'شهر را دستی انتخاب کنید یا موقعیت تقریبی را در تنظیمات سیستم فعال کنید.';

  @override
  String get locationUnavailableTitle => 'موقعیت فعلی در دسترس نیست';

  @override
  String get locationUnavailableBody =>
      'موقعیت دستگاه را روشن کنید یا یک شهر پشتیبانی‌شده را دستی انتخاب کنید. مختصات شما ذخیره نمی‌شود.';

  @override
  String get closePage => 'بستن صفحه';

  @override
  String get bookmarksTitle => 'ذخیره‌شده‌ها';

  @override
  String get searchBookmarks => 'جست‌وجوی موارد ذخیره‌شده';

  @override
  String get filterAll => 'همه';

  @override
  String get filterRestaurants => 'رستوران‌ها';

  @override
  String get filterFoods => 'غذاها';

  @override
  String get filterMenuItems => 'آیتم‌های منو';

  @override
  String get noBookmarksTitle => 'هنوز چیزی ذخیره نشده';

  @override
  String get noBookmarksBody =>
      'رستوران‌ها، غذاها، آیتم‌های منو و یافته‌های ذخیره‌شده به‌صورت آفلاین اینجا می‌مانند.';

  @override
  String get removeBookmark => 'حذف نشانک';

  @override
  String get savedOffline => 'روی این دستگاه ذخیره شد';

  @override
  String get profileSettingsTitle => 'پروفایل و تنظیمات';

  @override
  String get accountNotConnected => 'استفادهٔ محلی از Miz';

  @override
  String get connectAccount => 'اتصال حساب هنوز در دسترس نیست';

  @override
  String get personalization => 'شخصی‌سازی';

  @override
  String get appearance => 'ظاهر';

  @override
  String get locationSettings => 'موقعیت';

  @override
  String get dataPrivacy => 'داده و حریم خصوصی';

  @override
  String get localActivity => 'فعالیت محلی';

  @override
  String get conversationInputLabel => 'ادامهٔ جست‌وجوی غذا';

  @override
  String get aiUnavailableTitle => 'هوش مصنوعی Miz موقتاً در دسترس نیست';

  @override
  String get aiUnavailableBody =>
      'دستیار اکنون نتوانست پاسخ دهد. پیام شما در این نشست می‌ماند.';

  @override
  String get aiTimeoutTitle => 'Miz به زمان بیشتری نیاز دارد';

  @override
  String get aiTimeoutBody =>
      'پاسخ بیش از حد طول کشید. همان درخواست را دوباره امتحان کنید.';

  @override
  String get aiRateLimitTitle => 'Miz اکنون مشغول است';

  @override
  String get aiRateLimitBody =>
      'درخواست‌های زیادی در حال پردازش است. کمی صبر کنید و دوباره تلاش کنید.';

  @override
  String get placesUnavailableTitle => 'جست‌وجوی مکان در دسترس نیست';

  @override
  String get placesUnavailableBody =>
      'Miz اکنون نتوانست رستوران‌ها را جست‌وجو کند. کمی بعد دوباره تلاش کنید.';

  @override
  String get noPlacesTitle => 'رستورانی پیدا نشد';

  @override
  String get noPlacesBody =>
      'غذای دیگری، محدودهٔ بزرگ‌تر یا فیلترهای کمتری را امتحان کنید.';

  @override
  String get aiRequestErrorTitle => 'Miz نتوانست درخواست را کامل کند';

  @override
  String get aiRequestErrorBody =>
      'درخواست را کمی تغییر دهید یا دوباره تلاش کنید.';

  @override
  String get retry => 'تلاش دوباره';

  @override
  String get copyAction => 'کپی';

  @override
  String get saveDiscovery => 'ذخیرهٔ یافته';

  @override
  String get newSearch => 'جست‌وجوی تازه';

  @override
  String get closeConversation => 'بستن گفت‌وگو';

  @override
  String get newChat => 'گفت‌وگوی تازه';

  @override
  String get chatHistory => 'تاریخچهٔ گفت‌وگو';

  @override
  String get noChatHistory => 'هنوز گفت‌وگویی ندارید';

  @override
  String get noChatHistoryBody =>
      'گفت‌وگویی را با Miz شروع کنید. با آغاز گفت‌وگوی تازه یا خروج از صفحه، گفت‌وگوی فعلی اینجا نمایش داده می‌شود.';

  @override
  String get chatHistoryUnavailable => 'تاریخچهٔ گفت‌وگو بارگذاری نشد.';

  @override
  String get deleteChat => 'حذف گفت‌وگو';

  @override
  String restaurantResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count نتیجهٔ رستوران',
      one: '۱ نتیجهٔ رستوران',
      zero: 'نتایج رستوران‌ها',
    );
    return '$_temp0';
  }

  @override
  String get cameraTitle => 'دوربین';

  @override
  String get cameraPermissionTitle => 'دسترسی دوربین لازم است';

  @override
  String get cameraPermissionBody =>
      'دوربین را به سمت یک کد QR میز، یک منو، یا یک غذا بگیرید -- Miz به‌طور خودکار تشخیص می‌دهد. عکس‌ها موقت‌اند و بی‌اجازه بارگذاری نمی‌شوند.';

  @override
  String get allowCamera => 'اجازه به دوربین';

  @override
  String get cameraDeniedTitle => 'دسترسی دوربین رد شد';

  @override
  String get cameraDeniedBody =>
      'برای اسکن غذا، QR میز یا منو، دوربین را در تنظیمات سیستم فعال کنید.';

  @override
  String get cameraUnavailableTitle => 'دوربین در دسترس نیست';

  @override
  String get cameraUnavailableBody =>
      'دوربین قابل استفاده‌ای در این دستگاه در دسترس نیست. برای تحلیل غذا یا منو همچنان می‌توانید عکس انتخاب کنید.';

  @override
  String get offlineTitle => 'آفلاین هستید';

  @override
  String get offlineBody =>
      'تشخیص و تأیید راه‌دور به اینترنت نیاز دارد. هیچ تصویری بارگذاری نشده است.';

  @override
  String get liveCamera => 'پیش‌نمایش زندهٔ دوربین';

  @override
  String get capture => 'عکس گرفتن';

  @override
  String get preview => 'پیش‌نمایش';

  @override
  String get retake => 'عکس دوباره';

  @override
  String get confirm => 'تأیید';

  @override
  String get processing => 'پردازش امن';

  @override
  String get noConfidentResult => 'نتیجهٔ مطمئنی نیست';

  @override
  String get resultDetails => 'جزئیات نتیجه';

  @override
  String get backendRequired => 'بک‌اند امن لازم است';

  @override
  String get cloudProcessingNotice =>
      'ادامه به پردازش امن ابری نیاز دارد. Miz پیش از هر بارگذاری اجازه می‌گیرد.';

  @override
  String get scanUnifiedInstruction =>
      'دوربین را به سمت یک کد QR میز بگیرید تا خودکار باز شود، یا از یک منو یا غذا عکس بگیرید.';

  @override
  String get qrScannerUnavailableTitle => 'اسکنر QR در دسترس نیست';

  @override
  String get qrScannerUnavailableBody =>
      'Miz نتوانست دوربین زنده QR را اجرا کند. مجوز دوربین را بررسی و دوباره تلاش کنید.';

  @override
  String get scanAgain => 'اسکن دوباره';

  @override
  String get invalidQrTitle => 'QR نامعتبر Miz';

  @override
  String get invalidQrBody => 'این کد دادهٔ معتبر Miz نیست و باز نشد.';

  @override
  String get expiredQrTitle => 'این QR منقضی شده است';

  @override
  String get expiredQrBody => 'از رستوران کد تازه بخواهید.';

  @override
  String get unpublishedQrTitle => 'رستوران منتشر نشده است';

  @override
  String get unpublishedQrBody => 'این رستوران Miz اکنون قابل باز کردن نیست.';

  @override
  String get inactiveTableTitle => 'میز غیرفعال است';

  @override
  String get inactiveTableBody =>
      'این میز اکنون نمی‌تواند نشستی را شروع کند یا به آن بپیوندد.';

  @override
  String get qrVerificationRequired =>
      'قالب QR معتبر است. پیش از باز کردن رستوران یا نشست میز، تأیید شبکه لازم است.';

  @override
  String get captureUploadConsent =>
      'با زدن «تحلیل»، این عکس موقت برای تحلیل امن هوش مصنوعی ارسال می‌شود. Miz آن را ذخیره نمی‌کند.';

  @override
  String get analyzePhoto => 'تحلیل';

  @override
  String get captureUnrecognizedTitle => 'Miz نتوانست تشخیص دهد این چیست';

  @override
  String get captureUnrecognizedBody =>
      'عکسی واضح‌تر از یک منو یا یک غذای آمادهٔ تکی بگیرید، در مرکز و با فوکوس مناسب.';

  @override
  String get captureAnalysisFailedTitle => 'Miz نتوانست این عکس را تحلیل کند';

  @override
  String get captureAnalysisFailedBody =>
      'تحلیل امن کامل نشد. عکس شما ذخیره نشد. اتصال را بررسی کرده و دوباره تلاش کنید.';

  @override
  String get foodRecognizedTitle => 'غذا شناسایی شد';

  @override
  String get possibleMatchesTitle => 'نتایج احتمالی';

  @override
  String foodConfidence(int percent) {
    return '٪$percent تطابق';
  }

  @override
  String get foodRecognitionDisclaimer =>
      'شناسایی هوش مصنوعی ممکن است اشتباه باشد و نمی‌تواند مواد اولیه یا ایمنی حساسیت را از روی عکس تأیید کند.';

  @override
  String get scanAnotherFood => 'اسکن غذای دیگر';

  @override
  String get foodUncertainTitle => 'Miz نتوانست این غذا را شناسایی کند';

  @override
  String get foodUncertainBody =>
      'یک غذای روشن و واضح را بدون بسته‌بندی یا شلوغی در مرکز عکس قرار دهید.';

  @override
  String get foodAnalysisFailedTitle => 'شناسایی غذا کامل نشد';

  @override
  String get foodAnalysisFailedBody =>
      'تحلیل امن ناموفق بود. عکس شما ذخیره نشد. اتصال را بررسی کرده و عکس دیگری امتحان کنید.';

  @override
  String get menuPagesTitle => 'صفحه‌های منو';

  @override
  String get addPage => 'افزودن صفحه';

  @override
  String pageNumber(int number) {
    return 'صفحهٔ $number';
  }

  @override
  String get reorderPage => 'جابجایی صفحه';

  @override
  String get deletePage => 'حذف صفحه';

  @override
  String get confirmPages => 'تأیید همهٔ صفحه‌ها';

  @override
  String get menuIncompleteTitle => 'اسکن منو کامل نیست';

  @override
  String get menuIncompleteBody =>
      'پیش از ادامه دست‌کم یک صفحهٔ خوانا بگیرید. قیمت و مواد ممکن است به اصلاح دستی نیاز داشته باشند.';

  @override
  String get takePhoto => 'عکس گرفتن';

  @override
  String get choosePhoto => 'انتخاب عکس';

  @override
  String get menuPhotoInstruction =>
      'یک عکس واضح و مستقیم از منو بگیرید یا تصویری از گالری انتخاب کنید.';

  @override
  String get menuImageUnavailableBody =>
      'این عکس باز نشد. تصویر دیگری انتخاب کنید.';

  @override
  String get menuUploadConsent =>
      'با زدن «توضیح منو»، این عکس‌های موقت به‌صورت امن برای تحلیل هوش مصنوعی ارسال می‌شوند. Miz عکس‌ها را ذخیره نمی‌کند.';

  @override
  String get explainMenu => 'توضیح منو';

  @override
  String get menuExplainedTitle => 'توضیح منوی شما';

  @override
  String menuExplainedBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count غذا پیدا شد و با پروفایل غذایی شما بررسی شد.',
      one: '۱ غذا پیدا شد و با پروفایل غذایی شما بررسی شد.',
      zero: 'هنوز غذایی در پایگاه دادهٔ Miz پیدا نشد.',
    );
    return '$_temp0';
  }

  @override
  String get menuNotesTitle => 'نکته‌های مفید';

  @override
  String get menuAllergenDisclaimer =>
      'هوش مصنوعی ممکن است اشتباه کند. پیش از سفارش، مواد و آلرژن‌ها را حتماً با رستوران تأیید کنید.';

  @override
  String get menuDishSafe => 'با پروفایل شما سازگار است';

  @override
  String get menuDishWarning => 'پیش از سفارش بررسی کنید';

  @override
  String get menuDishRestricted => 'با پروفایل شما سازگار نیست';

  @override
  String get menuPriceGood => 'قیمت مناسب';

  @override
  String get menuPriceHigh => 'کمی گران‌تر از میانگین';

  @override
  String get menuPriceVeryHigh => 'قیمت بالا';

  @override
  String get menuAskAboutThisMenu => 'دربارهٔ این منو از Miz بپرس';

  @override
  String get menuReasonNotHalal => 'شامل مواد غیرحلال است';

  @override
  String get menuReasonHalalUncertain =>
      'وضعیت حلال بودن به نحوهٔ تهیه بستگی دارد';

  @override
  String get menuReasonHalalUnknown => 'وضعیت حلال بودن نامشخص است';

  @override
  String get menuReasonHalalPreferenceNotMet =>
      'حلال بودن تأیید نشده (بر اساس ترجیح شما)';

  @override
  String get menuReasonNotVegan => 'وگان نیست';

  @override
  String get menuReasonVeganUncertain => 'وضعیت وگان بودن نامشخص است';

  @override
  String get menuReasonNotVegetarian => 'گیاهی نیست';

  @override
  String get menuReasonVegetarianUncertain => 'وضعیت گیاهی بودن نامشخص است';

  @override
  String get menuReasonContainsAlcohol => 'حاوی الکل است';

  @override
  String get menuReasonMayContainAlcohol => 'ممکن است حاوی الکل باشد';

  @override
  String get menuReasonAlcoholUnknown => 'میزان الکل نامشخص است';

  @override
  String get menuReasonAllergensNotVerifiable =>
      'آلرژن‌ها با پروفایل شما بررسی نشدند';

  @override
  String get scanAnotherMenu => 'اسکن منوی دیگر';

  @override
  String get tryAnotherPhoto => 'امتحان عکس دیگر';

  @override
  String get menuUnreadableTitle => 'منو به‌اندازهٔ کافی واضح نبود';

  @override
  String get menuUnreadableBody =>
      'عکسی روشن‌تر و مستقیم بگیرید که همهٔ متن منو در فوکوس باشد.';

  @override
  String get menuAnalysisFailedTitle => 'Miz نتوانست این منو را توضیح دهد';

  @override
  String get menuAnalysisFailedBody =>
      'تحلیل امن کامل نشد. عکس‌های شما ذخیره نشدند. با یک عکس واضح دوباره تلاش کنید.';

  @override
  String get menuImageTooLargeTitle => 'عکس بیش از حد بزرگ است';

  @override
  String get menuImageTooLargeBody =>
      'عکس کوچک‌تری انتخاب کنید یا صفحه‌های کمتری را هم‌زمان بفرستید.';

  @override
  String get menuImageUnsupportedTitle => 'فرمت عکس پشتیبانی نمی‌شود';

  @override
  String get menuImageUnsupportedBody =>
      'یک عکس JPEG، PNG، WebP، HEIC یا HEIF انتخاب کنید.';

  @override
  String get menuTooManyPagesTitle => 'صفحه‌های منو بیش از حد است';

  @override
  String get menuTooManyPagesBody =>
      'هر بار می‌توانید تا چهار صفحهٔ منو را برای توضیح بفرستید.';

  @override
  String get localDatabaseErrorTitle => 'ذخیره‌شده‌ها در دسترس نیستند';

  @override
  String get localDatabaseErrorBody =>
      'Miz نتوانست موارد ذخیره‌شدهٔ این دستگاه را بخواند. صفحه را ببندید و دوباره باز کنید.';
}
