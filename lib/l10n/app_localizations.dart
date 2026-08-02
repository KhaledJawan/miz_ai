import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('fa'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Miz'**
  String get appTitle;

  /// No description provided for @conversationTitle.
  ///
  /// In en, this message translates to:
  /// **'Conversation'**
  String get conversationTitle;

  /// No description provided for @recommendationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recommendations'**
  String get recommendationsTitle;

  /// No description provided for @restaurantDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Details'**
  String get restaurantDetailsTitle;

  /// No description provided for @discoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discoverTitle;

  /// No description provided for @menuTitle.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menuTitle;

  /// No description provided for @reserveTitle.
  ///
  /// In en, this message translates to:
  /// **'Reserve'**
  String get reserveTitle;

  /// No description provided for @checkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutTitle;

  /// No description provided for @orderTrackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Tracking'**
  String get orderTrackingTitle;

  /// No description provided for @comingSoonMessage.
  ///
  /// In en, this message translates to:
  /// **'This experience is on the roadmap and has not been built yet.'**
  String get comingSoonMessage;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @mizThinking.
  ///
  /// In en, this message translates to:
  /// **'Miz is thinking'**
  String get mizThinking;

  /// No description provided for @mizListening.
  ///
  /// In en, this message translates to:
  /// **'Miz is listening'**
  String get mizListening;

  /// No description provided for @mizTaskComplete.
  ///
  /// In en, this message translates to:
  /// **'Miz completed the task'**
  String get mizTaskComplete;

  /// No description provided for @restaurantPhoto.
  ///
  /// In en, this message translates to:
  /// **'{name} restaurant photo'**
  String restaurantPhoto(String name);

  /// No description provided for @restaurantImagePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'{name} restaurant image placeholder'**
  String restaurantImagePlaceholder(String name);

  /// No description provided for @meetMiz.
  ///
  /// In en, this message translates to:
  /// **'Meet Miz.'**
  String get meetMiz;

  /// No description provided for @onboardingIntroDescription.
  ///
  /// In en, this message translates to:
  /// **'Your AI food companion for deciding what to eat, where to find it, and how to get it.'**
  String get onboardingIntroDescription;

  /// No description provided for @findNearbyTitle.
  ///
  /// In en, this message translates to:
  /// **'Find what\'s near you'**
  String get findNearbyTitle;

  /// No description provided for @findNearbyDescription.
  ///
  /// In en, this message translates to:
  /// **'See the best restaurants around you with accurate distance, delivery time, and availability.'**
  String get findNearbyDescription;

  /// No description provided for @rememberChoicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Remember my choices?'**
  String get rememberChoicesTitle;

  /// No description provided for @rememberChoicesDescription.
  ///
  /// In en, this message translates to:
  /// **'Let Miz learn your tastes so each recommendation becomes faster and more personal.'**
  String get rememberChoicesDescription;

  /// No description provided for @personalizeMiz.
  ///
  /// In en, this message translates to:
  /// **'Personalize Miz'**
  String get personalizeMiz;

  /// No description provided for @changeAnytime.
  ///
  /// In en, this message translates to:
  /// **'You can change this anytime.'**
  String get changeAnytime;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @allowLocation.
  ///
  /// In en, this message translates to:
  /// **'Allow Location'**
  String get allowLocation;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @nearYou.
  ///
  /// In en, this message translates to:
  /// **'Near you'**
  String get nearYou;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @openTodayOffers.
  ///
  /// In en, this message translates to:
  /// **'Open today\'s offers'**
  String get openTodayOffers;

  /// No description provided for @todayOffers.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Offers'**
  String get todayOffers;

  /// No description provided for @offerDescription.
  ///
  /// In en, this message translates to:
  /// **'20% off desserts, tonight only'**
  String get offerDescription;

  /// No description provided for @hungry.
  ///
  /// In en, this message translates to:
  /// **'I\'m Hungry'**
  String get hungry;

  /// No description provided for @orderFood.
  ///
  /// In en, this message translates to:
  /// **'Order Food'**
  String get orderFood;

  /// No description provided for @reserveTable.
  ///
  /// In en, this message translates to:
  /// **'Reserve a Table'**
  String get reserveTable;

  /// No description provided for @findCafe.
  ///
  /// In en, this message translates to:
  /// **'Find a Café'**
  String get findCafe;

  /// No description provided for @yourFavorites.
  ///
  /// In en, this message translates to:
  /// **'Your Favorites'**
  String get yourFavorites;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @foodPrompt.
  ///
  /// In en, this message translates to:
  /// **'What do you want to eat?'**
  String get foodPrompt;

  /// No description provided for @addPhotoComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Add photo (coming soon)'**
  String get addPhotoComingSoon;

  /// No description provided for @voiceComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Voice (coming soon)'**
  String get voiceComingSoon;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @tasteProfilePreferences.
  ///
  /// In en, this message translates to:
  /// **'Taste profile and preferences'**
  String get tasteProfilePreferences;

  /// No description provided for @closeSettings.
  ///
  /// In en, this message translates to:
  /// **'Close settings'**
  String get closeSettings;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @locationPermission.
  ///
  /// In en, this message translates to:
  /// **'Location Permission'**
  String get locationPermission;

  /// No description provided for @rememberMyPreferences.
  ///
  /// In en, this message translates to:
  /// **'Remember My Preferences'**
  String get rememberMyPreferences;

  /// No description provided for @supportAndPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Support and privacy'**
  String get supportAndPrivacy;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @selectedLanguage.
  ///
  /// In en, this message translates to:
  /// **'Selected language: {language}'**
  String selectedLanguage(String language);

  /// No description provided for @noLimit.
  ///
  /// In en, this message translates to:
  /// **'No Limit'**
  String get noLimit;

  /// No description provided for @distanceMeters.
  ///
  /// In en, this message translates to:
  /// **'{distance} m'**
  String distanceMeters(int distance);

  /// No description provided for @distanceKilometers.
  ///
  /// In en, this message translates to:
  /// **'{distance} km'**
  String distanceKilometers(String distance);

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String minutesShort(int minutes);

  /// No description provided for @openNow.
  ///
  /// In en, this message translates to:
  /// **'Open now'**
  String get openNow;

  /// No description provided for @cuisineItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get cuisineItalian;

  /// No description provided for @cuisineBurger.
  ///
  /// In en, this message translates to:
  /// **'Burger'**
  String get cuisineBurger;

  /// No description provided for @cuisineAsian.
  ///
  /// In en, this message translates to:
  /// **'Asian'**
  String get cuisineAsian;

  /// No description provided for @cuisineHealthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get cuisineHealthy;

  /// No description provided for @cuisineDessert.
  ///
  /// In en, this message translates to:
  /// **'Dessert'**
  String get cuisineDessert;

  /// No description provided for @cuisineCafe.
  ///
  /// In en, this message translates to:
  /// **'Café'**
  String get cuisineCafe;

  /// No description provided for @cuisineDrinks.
  ///
  /// In en, this message translates to:
  /// **'Wine Bar'**
  String get cuisineDrinks;

  /// No description provided for @dietStepTitle.
  ///
  /// In en, this message translates to:
  /// **'What best describes how you eat?'**
  String get dietStepTitle;

  /// No description provided for @dietVegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get dietVegan;

  /// No description provided for @dietVegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get dietVegetarian;

  /// No description provided for @dietPescatarian.
  ///
  /// In en, this message translates to:
  /// **'Pescatarian'**
  String get dietPescatarian;

  /// No description provided for @dietFlexitarian.
  ///
  /// In en, this message translates to:
  /// **'Flexitarian'**
  String get dietFlexitarian;

  /// No description provided for @dietOmnivore.
  ///
  /// In en, this message translates to:
  /// **'I eat everything'**
  String get dietOmnivore;

  /// No description provided for @dietOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get dietOther;

  /// No description provided for @dietPreferNotToSay.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get dietPreferNotToSay;

  /// No description provided for @foodRulesStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Any food rules we should know about?'**
  String get foodRulesStepTitle;

  /// No description provided for @foodRulesStepHint.
  ///
  /// In en, this message translates to:
  /// **'Tap an item to mark it required, preferred, or something to avoid.'**
  String get foodRulesStepHint;

  /// No description provided for @requirementRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requirementRequired;

  /// No description provided for @requirementPreferred.
  ///
  /// In en, this message translates to:
  /// **'Preferred'**
  String get requirementPreferred;

  /// No description provided for @requirementAvoid.
  ///
  /// In en, this message translates to:
  /// **'Avoid'**
  String get requirementAvoid;

  /// No description provided for @allergiesStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Do you have any food allergies?'**
  String get allergiesStepTitle;

  /// No description provided for @noKnownAllergies.
  ///
  /// In en, this message translates to:
  /// **'No known allergies'**
  String get noKnownAllergies;

  /// No description provided for @searchAllergens.
  ///
  /// In en, this message translates to:
  /// **'Search allergens'**
  String get searchAllergens;

  /// No description provided for @customAllergyHint.
  ///
  /// In en, this message translates to:
  /// **'Add an allergy not listed above'**
  String get customAllergyHint;

  /// No description provided for @addCustomAllergy.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addCustomAllergy;

  /// No description provided for @allergySafetyNotice.
  ///
  /// In en, this message translates to:
  /// **'This helps us avoid suggesting unsafe foods, but always confirm allergens with the restaurant before ordering.'**
  String get allergySafetyNotice;

  /// No description provided for @severityMild.
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get severityMild;

  /// No description provided for @severityModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get severityModerate;

  /// No description provided for @severitySevere.
  ///
  /// In en, this message translates to:
  /// **'Severe'**
  String get severitySevere;

  /// No description provided for @severityUnspecified.
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get severityUnspecified;

  /// No description provided for @severeAllergyConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm severe allergy'**
  String get severeAllergyConfirmTitle;

  /// No description provided for @severeAllergyConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ve marked a severe allergy. We\'ll always exclude foods that contain it. Continue?'**
  String get severeAllergyConfirmBody;

  /// No description provided for @intolerancesStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Any food intolerances?'**
  String get intolerancesStepTitle;

  /// No description provided for @intolerancesStepHint.
  ///
  /// In en, this message translates to:
  /// **'These are different from allergies — we use them to guide suggestions, not to block foods outright.'**
  String get intolerancesStepHint;

  /// No description provided for @noneOfTheAbove.
  ///
  /// In en, this message translates to:
  /// **'None of the above'**
  String get noneOfTheAbove;

  /// No description provided for @proteinsStepTitle.
  ///
  /// In en, this message translates to:
  /// **'What proteins do you eat?'**
  String get proteinsStepTitle;

  /// No description provided for @showFewerOptions.
  ///
  /// In en, this message translates to:
  /// **'Show fewer options'**
  String get showFewerOptions;

  /// No description provided for @showMoreOptions.
  ///
  /// In en, this message translates to:
  /// **'Show more options'**
  String get showMoreOptions;

  /// No description provided for @eatAndLike.
  ///
  /// In en, this message translates to:
  /// **'Eat and like'**
  String get eatAndLike;

  /// No description provided for @dislikeIngredient.
  ///
  /// In en, this message translates to:
  /// **'Dislike'**
  String get dislikeIngredient;

  /// No description provided for @neverEat.
  ///
  /// In en, this message translates to:
  /// **'Never eat'**
  String get neverEat;

  /// No description provided for @cuisinesStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Which cuisines do you enjoy?'**
  String get cuisinesStepTitle;

  /// No description provided for @searchCuisines.
  ///
  /// In en, this message translates to:
  /// **'Search cuisines'**
  String get searchCuisines;

  /// No description provided for @preferenceLove.
  ///
  /// In en, this message translates to:
  /// **'Love it'**
  String get preferenceLove;

  /// No description provided for @preferenceLike.
  ///
  /// In en, this message translates to:
  /// **'Like it'**
  String get preferenceLike;

  /// No description provided for @preferenceCurious.
  ///
  /// In en, this message translates to:
  /// **'Curious'**
  String get preferenceCurious;

  /// No description provided for @preferenceNotInterested.
  ///
  /// In en, this message translates to:
  /// **'Not interested'**
  String get preferenceNotInterested;

  /// No description provided for @flavorsStepTitle.
  ///
  /// In en, this message translates to:
  /// **'What flavors do you enjoy?'**
  String get flavorsStepTitle;

  /// No description provided for @spiceNotSpicy.
  ///
  /// In en, this message translates to:
  /// **'Not spicy'**
  String get spiceNotSpicy;

  /// No description provided for @spiceMild.
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get spiceMild;

  /// No description provided for @spiceMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get spiceMedium;

  /// No description provided for @spiceHot.
  ///
  /// In en, this message translates to:
  /// **'Hot'**
  String get spiceHot;

  /// No description provided for @spiceVeryHot.
  ///
  /// In en, this message translates to:
  /// **'Very hot'**
  String get spiceVeryHot;

  /// No description provided for @eatingStyleStepTitle.
  ///
  /// In en, this message translates to:
  /// **'How do you like to eat?'**
  String get eatingStyleStepTitle;

  /// No description provided for @adventurousnessQuestion.
  ///
  /// In en, this message translates to:
  /// **'How often do you try new foods?'**
  String get adventurousnessQuestion;

  /// No description provided for @adventurousnessAlmostNever.
  ///
  /// In en, this message translates to:
  /// **'Almost never'**
  String get adventurousnessAlmostNever;

  /// No description provided for @adventurousnessSometimes.
  ///
  /// In en, this message translates to:
  /// **'Sometimes'**
  String get adventurousnessSometimes;

  /// No description provided for @adventurousnessOften.
  ///
  /// In en, this message translates to:
  /// **'Often'**
  String get adventurousnessOften;

  /// No description provided for @adventurousnessAlmostAlways.
  ///
  /// In en, this message translates to:
  /// **'Almost always'**
  String get adventurousnessAlmostAlways;

  /// No description provided for @topPrioritiesQuestion.
  ///
  /// In en, this message translates to:
  /// **'What matters most to you?'**
  String get topPrioritiesQuestion;

  /// No description provided for @topPrioritiesHint.
  ///
  /// In en, this message translates to:
  /// **'Choose up to 3.'**
  String get topPrioritiesHint;

  /// No description provided for @priorityTaste.
  ///
  /// In en, this message translates to:
  /// **'Taste'**
  String get priorityTaste;

  /// No description provided for @priorityPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priorityPrice;

  /// No description provided for @priorityHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get priorityHealth;

  /// No description provided for @priorityPortionSize.
  ///
  /// In en, this message translates to:
  /// **'Portion size'**
  String get priorityPortionSize;

  /// No description provided for @priorityIngredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get priorityIngredients;

  /// No description provided for @priorityAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get priorityAppearance;

  /// No description provided for @priorityPreparationTime.
  ///
  /// In en, this message translates to:
  /// **'Preparation time'**
  String get priorityPreparationTime;

  /// No description provided for @priorityPopularity.
  ///
  /// In en, this message translates to:
  /// **'Popularity'**
  String get priorityPopularity;

  /// No description provided for @priorityFamiliarity.
  ///
  /// In en, this message translates to:
  /// **'Familiarity'**
  String get priorityFamiliarity;

  /// No description provided for @prioritySomethingNew.
  ///
  /// In en, this message translates to:
  /// **'Something new'**
  String get prioritySomethingNew;

  /// No description provided for @mealWeightQuestion.
  ///
  /// In en, this message translates to:
  /// **'How filling do you like your meals?'**
  String get mealWeightQuestion;

  /// No description provided for @mealWeightLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get mealWeightLight;

  /// No description provided for @mealWeightBalanced.
  ///
  /// In en, this message translates to:
  /// **'Balanced'**
  String get mealWeightBalanced;

  /// No description provided for @mealWeightFilling.
  ///
  /// In en, this message translates to:
  /// **'Filling'**
  String get mealWeightFilling;

  /// No description provided for @mealWeightDepends.
  ///
  /// In en, this message translates to:
  /// **'Depends on the situation'**
  String get mealWeightDepends;

  /// No description provided for @budgetQuestion.
  ///
  /// In en, this message translates to:
  /// **'What\'s your usual budget?'**
  String get budgetQuestion;

  /// No description provided for @budgetOptionalHint.
  ///
  /// In en, this message translates to:
  /// **'Optional — you can skip this.'**
  String get budgetOptionalHint;

  /// No description provided for @budgetLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get budgetLow;

  /// No description provided for @budgetMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get budgetMedium;

  /// No description provided for @budgetHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get budgetHigh;

  /// No description provided for @budgetNoPreference.
  ///
  /// In en, this message translates to:
  /// **'No preference'**
  String get budgetNoPreference;

  /// No description provided for @foodSamplesStepTitle.
  ///
  /// In en, this message translates to:
  /// **'A few foods to get a feel for your taste'**
  String get foodSamplesStepTitle;

  /// No description provided for @foodSamplesStepHint.
  ///
  /// In en, this message translates to:
  /// **'Tap how you feel about each one — there\'s no wrong answer.'**
  String get foodSamplesStepHint;

  /// No description provided for @foodSampleLike.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get foodSampleLike;

  /// No description provided for @foodSampleCurious.
  ///
  /// In en, this message translates to:
  /// **'Curious'**
  String get foodSampleCurious;

  /// No description provided for @foodSampleNeverTried.
  ///
  /// In en, this message translates to:
  /// **'Never tried'**
  String get foodSampleNeverTried;

  /// No description provided for @foodSampleDislike.
  ///
  /// In en, this message translates to:
  /// **'Dislike'**
  String get foodSampleDislike;

  /// No description provided for @reviewStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Review your food profile'**
  String get reviewStepTitle;

  /// No description provided for @reviewAnswered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get reviewAnswered;

  /// No description provided for @reviewNotAnswered.
  ///
  /// In en, this message translates to:
  /// **'Not answered yet'**
  String get reviewNotAnswered;

  /// No description provided for @reviewSelectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 selected} other{{count} selected}}'**
  String reviewSelectedCount(int count);

  /// No description provided for @reviewEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get reviewEdit;

  /// No description provided for @foodProfileWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s understand your taste'**
  String get foodProfileWelcomeTitle;

  /// No description provided for @foodProfileWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'A few quick questions help Miz suggest foods you\'ll actually want to eat. You can change any answer later.'**
  String get foodProfileWelcomeBody;

  /// No description provided for @foodProfileBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get foodProfileBack;

  /// No description provided for @foodProfileComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get foodProfileComplete;

  /// No description provided for @cancelLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelLabel;

  /// No description provided for @doneLabel.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneLabel;

  /// No description provided for @foodProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Food Profile'**
  String get foodProfileTitle;

  /// No description provided for @foodProfilePreferences.
  ///
  /// In en, this message translates to:
  /// **'Food profile'**
  String get foodProfilePreferences;

  /// No description provided for @foodProfileSectionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Your answers'**
  String get foodProfileSectionsLabel;

  /// No description provided for @foodProfileCompletenessLabel.
  ///
  /// In en, this message translates to:
  /// **'Profile completeness'**
  String get foodProfileCompletenessLabel;

  /// No description provided for @foodProfileLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated {date}'**
  String foodProfileLastUpdated(String date);

  /// No description provided for @foodProfilePrivacyLabel.
  ///
  /// In en, this message translates to:
  /// **'Privacy and reset'**
  String get foodProfilePrivacyLabel;

  /// No description provided for @behaviorPersonalizationToggle.
  ///
  /// In en, this message translates to:
  /// **'Personalize from my activity'**
  String get behaviorPersonalizationToggle;

  /// No description provided for @behaviorPersonalizationHint.
  ///
  /// In en, this message translates to:
  /// **'Lets Miz refine suggestions from what you view, save, and hide. Your explicit answers are always kept.'**
  String get behaviorPersonalizationHint;

  /// No description provided for @deleteInteractionHistory.
  ///
  /// In en, this message translates to:
  /// **'Delete interaction history'**
  String get deleteInteractionHistory;

  /// No description provided for @deleteInteractionHistoryConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This removes the local activity Miz uses to refine suggestions. Your explicit answers, allergies, and preferences are not affected.'**
  String get deleteInteractionHistoryConfirmBody;

  /// No description provided for @restartOnboardingAction.
  ///
  /// In en, this message translates to:
  /// **'Restart onboarding'**
  String get restartOnboardingAction;

  /// No description provided for @restartOnboardingConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ll be taken through every question again from the start. Your current answers stay until you change them.'**
  String get restartOnboardingConfirmBody;

  /// No description provided for @resetFoodProfileAction.
  ///
  /// In en, this message translates to:
  /// **'Reset food profile'**
  String get resetFoodProfileAction;

  /// No description provided for @resetFoodProfileConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes all your food preferences, allergies, restrictions, and activity history. This can\'t be undone.'**
  String get resetFoodProfileConfirmBody;

  /// No description provided for @foodProfilePrivacyNotice.
  ///
  /// In en, this message translates to:
  /// **'Your food profile is stored on this device and used to personalize what Miz suggests. It\'s not a substitute for confirming allergens directly with a restaurant.'**
  String get foodProfilePrivacyNotice;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
