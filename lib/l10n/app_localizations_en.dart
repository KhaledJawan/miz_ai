// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Miz';

  @override
  String get conversationTitle => 'Conversation';

  @override
  String get recommendationsTitle => 'Recommendations';

  @override
  String get restaurantDetailsTitle => 'Restaurant Details';

  @override
  String get discoverTitle => 'Discover';

  @override
  String get menuTitle => 'Menu';

  @override
  String get reserveTitle => 'Reserve';

  @override
  String get checkoutTitle => 'Checkout';

  @override
  String get orderTrackingTitle => 'Order Tracking';

  @override
  String get comingSoonMessage =>
      'This experience is on the roadmap and has not been built yet.';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get mizThinking => 'Miz is thinking';

  @override
  String get mizListening => 'Miz is listening';

  @override
  String get mizTaskComplete => 'Miz completed the task';

  @override
  String restaurantPhoto(String name) {
    return '$name restaurant photo';
  }

  @override
  String restaurantImagePlaceholder(String name) {
    return '$name restaurant image placeholder';
  }

  @override
  String get meetMiz => 'Meet Miz.';

  @override
  String get onboardingIntroDescription =>
      'Your AI food companion for deciding what to eat, where to find it, and how to get it.';

  @override
  String get findNearbyTitle => 'Find what\'s near you';

  @override
  String get findNearbyDescription =>
      'See the best restaurants around you with accurate distance, delivery time, and availability.';

  @override
  String get rememberChoicesTitle => 'Remember my choices?';

  @override
  String get rememberChoicesDescription =>
      'Let Miz learn your tastes so each recommendation becomes faster and more personal.';

  @override
  String get personalizeMiz => 'Personalize Miz';

  @override
  String get changeAnytime => 'You can change this anytime.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get allowLocation => 'Allow Location';

  @override
  String get continueLabel => 'Continue';

  @override
  String get notNow => 'Not now';

  @override
  String get nearYou => 'Near you';

  @override
  String get profile => 'Profile';

  @override
  String get openTodayOffers => 'Open today\'s offers';

  @override
  String get todayOffers => 'Today\'s Offers';

  @override
  String get offerDescription => '20% off desserts, tonight only';

  @override
  String get hungry => 'I\'m Hungry';

  @override
  String get orderFood => 'Order Food';

  @override
  String get reserveTable => 'Reserve a Table';

  @override
  String get findCafe => 'Find a Café';

  @override
  String get yourFavorites => 'Your Favorites';

  @override
  String get seeAll => 'See all';

  @override
  String get foodPrompt => 'What do you want to eat?';

  @override
  String get addPhotoComingSoon => 'Add photo (coming soon)';

  @override
  String get voiceComingSoon => 'Voice (coming soon)';

  @override
  String get send => 'Send';

  @override
  String get tasteProfilePreferences => 'Taste profile and preferences';

  @override
  String get closeSettings => 'Close settings';

  @override
  String get preferences => 'Preferences';

  @override
  String get language => 'Language';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get notifications => 'Notifications';

  @override
  String get locationPermission => 'Location Permission';

  @override
  String get rememberMyPreferences => 'Remember My Preferences';

  @override
  String get supportAndPrivacy => 'Support and privacy';

  @override
  String get privacy => 'Privacy';

  @override
  String get about => 'About';

  @override
  String get help => 'Help';

  @override
  String get logOut => 'Log Out';

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String selectedLanguage(String language) {
    return 'Selected language: $language';
  }

  @override
  String get noLimit => 'No Limit';

  @override
  String distanceMeters(int distance) {
    return '$distance m';
  }

  @override
  String distanceKilometers(String distance) {
    return '$distance km';
  }

  @override
  String minutesShort(int minutes) {
    return '$minutes min';
  }

  @override
  String get openNow => 'Open now';

  @override
  String get cuisineItalian => 'Italian';

  @override
  String get cuisineBurger => 'Burger';

  @override
  String get cuisineAsian => 'Asian';

  @override
  String get cuisineHealthy => 'Healthy';

  @override
  String get cuisineDessert => 'Dessert';

  @override
  String get cuisineCafe => 'Café';

  @override
  String get cuisineDrinks => 'Wine Bar';

  @override
  String get dietStepTitle => 'What best describes how you eat?';

  @override
  String get dietVegan => 'Vegan';

  @override
  String get dietVegetarian => 'Vegetarian';

  @override
  String get dietPescatarian => 'Pescatarian';

  @override
  String get dietFlexitarian => 'Flexitarian';

  @override
  String get dietOmnivore => 'I eat everything';

  @override
  String get dietOther => 'Other';

  @override
  String get dietPreferNotToSay => 'Prefer not to say';

  @override
  String get foodRulesStepTitle => 'Any food rules we should know about?';

  @override
  String get foodRulesStepHint =>
      'Tap an item to mark it required, preferred, or something to avoid.';

  @override
  String get requirementRequired => 'Required';

  @override
  String get requirementPreferred => 'Preferred';

  @override
  String get requirementAvoid => 'Avoid';

  @override
  String get allergiesStepTitle => 'Do you have any food allergies?';

  @override
  String get noKnownAllergies => 'No known allergies';

  @override
  String get searchAllergens => 'Search allergens';

  @override
  String get customAllergyHint => 'Add an allergy not listed above';

  @override
  String get addCustomAllergy => 'Add';

  @override
  String get allergySafetyNotice =>
      'This helps us avoid suggesting unsafe foods, but always confirm allergens with the restaurant before ordering.';

  @override
  String get severityMild => 'Mild';

  @override
  String get severityModerate => 'Moderate';

  @override
  String get severitySevere => 'Severe';

  @override
  String get severityUnspecified => 'Not specified';

  @override
  String get severeAllergyConfirmTitle => 'Confirm severe allergy';

  @override
  String get severeAllergyConfirmBody =>
      'You\'ve marked a severe allergy. We\'ll always exclude foods that contain it. Continue?';

  @override
  String get intolerancesStepTitle => 'Any food intolerances?';

  @override
  String get intolerancesStepHint =>
      'These are different from allergies — we use them to guide suggestions, not to block foods outright.';

  @override
  String get noneOfTheAbove => 'None of the above';

  @override
  String get proteinsStepTitle => 'What proteins do you eat?';

  @override
  String get showFewerOptions => 'Show fewer options';

  @override
  String get showMoreOptions => 'Show more options';

  @override
  String get eatAndLike => 'Eat and like';

  @override
  String get dislikeIngredient => 'Dislike';

  @override
  String get neverEat => 'Never eat';

  @override
  String get cuisinesStepTitle => 'Which cuisines do you enjoy?';

  @override
  String get searchCuisines => 'Search cuisines';

  @override
  String get preferenceLove => 'Love it';

  @override
  String get preferenceLike => 'Like it';

  @override
  String get preferenceCurious => 'Curious';

  @override
  String get preferenceNotInterested => 'Not interested';

  @override
  String get flavorsStepTitle => 'What flavors do you enjoy?';

  @override
  String get spiceNotSpicy => 'Not spicy';

  @override
  String get spiceMild => 'Mild';

  @override
  String get spiceMedium => 'Medium';

  @override
  String get spiceHot => 'Hot';

  @override
  String get spiceVeryHot => 'Very hot';

  @override
  String get eatingStyleStepTitle => 'How do you like to eat?';

  @override
  String get adventurousnessQuestion => 'How often do you try new foods?';

  @override
  String get adventurousnessAlmostNever => 'Almost never';

  @override
  String get adventurousnessSometimes => 'Sometimes';

  @override
  String get adventurousnessOften => 'Often';

  @override
  String get adventurousnessAlmostAlways => 'Almost always';

  @override
  String get topPrioritiesQuestion => 'What matters most to you?';

  @override
  String get topPrioritiesHint => 'Choose up to 3.';

  @override
  String get priorityTaste => 'Taste';

  @override
  String get priorityPrice => 'Price';

  @override
  String get priorityHealth => 'Health';

  @override
  String get priorityPortionSize => 'Portion size';

  @override
  String get priorityIngredients => 'Ingredients';

  @override
  String get priorityAppearance => 'Appearance';

  @override
  String get priorityPreparationTime => 'Preparation time';

  @override
  String get priorityPopularity => 'Popularity';

  @override
  String get priorityFamiliarity => 'Familiarity';

  @override
  String get prioritySomethingNew => 'Something new';

  @override
  String get mealWeightQuestion => 'How filling do you like your meals?';

  @override
  String get mealWeightLight => 'Light';

  @override
  String get mealWeightBalanced => 'Balanced';

  @override
  String get mealWeightFilling => 'Filling';

  @override
  String get mealWeightDepends => 'Depends on the situation';

  @override
  String get budgetQuestion => 'What\'s your usual budget?';

  @override
  String get budgetOptionalHint => 'Optional — you can skip this.';

  @override
  String get budgetLow => 'Low';

  @override
  String get budgetMedium => 'Medium';

  @override
  String get budgetHigh => 'High';

  @override
  String get budgetNoPreference => 'No preference';

  @override
  String get foodSamplesStepTitle => 'A few foods to get a feel for your taste';

  @override
  String get foodSamplesStepHint =>
      'Tap how you feel about each one — there\'s no wrong answer.';

  @override
  String get foodSampleLike => 'Like';

  @override
  String get foodSampleCurious => 'Curious';

  @override
  String get foodSampleNeverTried => 'Never tried';

  @override
  String get foodSampleDislike => 'Dislike';

  @override
  String get reviewStepTitle => 'Review your food profile';

  @override
  String get reviewAnswered => 'Answered';

  @override
  String get reviewNotAnswered => 'Not answered yet';

  @override
  String reviewSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selected',
      one: '1 selected',
    );
    return '$_temp0';
  }

  @override
  String get reviewEdit => 'Edit';

  @override
  String get foodProfileWelcomeTitle => 'Let\'s understand your taste';

  @override
  String get foodProfileWelcomeBody =>
      'A few quick questions help Miz suggest foods you\'ll actually want to eat. You can change any answer later.';

  @override
  String get foodProfileBack => 'Back';

  @override
  String get foodProfileComplete => 'Complete';

  @override
  String get cancelLabel => 'Cancel';

  @override
  String get doneLabel => 'Done';

  @override
  String get foodProfileTitle => 'Food Profile';

  @override
  String get foodProfilePreferences => 'Food profile';

  @override
  String get foodProfileSectionsLabel => 'Your answers';

  @override
  String get foodProfileCompletenessLabel => 'Profile completeness';

  @override
  String foodProfileLastUpdated(String date) {
    return 'Last updated $date';
  }

  @override
  String get foodProfilePrivacyLabel => 'Privacy and reset';

  @override
  String get behaviorPersonalizationToggle => 'Personalize from my activity';

  @override
  String get behaviorPersonalizationHint =>
      'Lets Miz refine suggestions from what you view, save, and hide. Your explicit answers are always kept.';

  @override
  String get deleteInteractionHistory => 'Delete interaction history';

  @override
  String get deleteInteractionHistoryConfirmBody =>
      'This removes the local activity Miz uses to refine suggestions. Your explicit answers, allergies, and preferences are not affected.';

  @override
  String get restartOnboardingAction => 'Restart onboarding';

  @override
  String get restartOnboardingConfirmBody =>
      'You\'ll be taken through every question again from the start. Your current answers stay until you change them.';

  @override
  String get resetFoodProfileAction => 'Reset food profile';

  @override
  String get resetFoodProfileConfirmBody =>
      'This permanently deletes all your food preferences, allergies, restrictions, and activity history. This can\'t be undone.';

  @override
  String get foodProfilePrivacyNotice =>
      'Your food profile is stored on this device and used to personalize what Miz suggests. It\'s not a substitute for confirming allergens directly with a restaurant.';
}
