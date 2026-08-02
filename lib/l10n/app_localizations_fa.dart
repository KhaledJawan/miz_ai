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
}
