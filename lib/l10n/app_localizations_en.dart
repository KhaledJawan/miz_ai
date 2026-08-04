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

  @override
  String get spatialHomeInputLabel => 'Tell Miz what you want to eat';

  @override
  String get promptWhatToday => 'What should I eat today?';

  @override
  String get promptMatchTaste => 'Find something that matches my taste.';

  @override
  String get promptRestaurantsNearby => 'Show me great restaurants nearby.';

  @override
  String get promptSomethingNew => 'I want to try something new.';

  @override
  String get promptLightMeal => 'Find a light meal for tonight.';

  @override
  String get promptNearMeNow => 'What can I eat near me right now?';

  @override
  String get promptSpicy => 'I want something spicy.';

  @override
  String get promptCafe => 'Find a good café nearby.';

  @override
  String get cameraAction => 'Open camera';

  @override
  String get bookmarksAction => 'Open bookmarks';

  @override
  String get profileSettingsAction => 'Open profile and settings';

  @override
  String get selectCity => 'Select city';

  @override
  String get noCitySelected => 'Choose a city';

  @override
  String get locationNeededTitle => 'Location needed';

  @override
  String get locationNeededBody =>
      'Choose a city or share your location so Miz can find places near you.';

  @override
  String changeCity(String city) {
    return 'Change city: $city';
  }

  @override
  String get searchCity => 'Search city';

  @override
  String get useCurrentLocation => 'Use current location';

  @override
  String get currentLocationPrivacy =>
      'Requested only when you choose this. Manual city selection always works.';

  @override
  String get recentCities => 'Recent cities';

  @override
  String get availableCities => 'Available cities';

  @override
  String get setAsDefault => 'Use this city by default';

  @override
  String get clearLocation => 'Clear selected and default city';

  @override
  String get locationDeniedTitle => 'Location access denied';

  @override
  String get locationDeniedBody =>
      'Choose a city manually or enable approximate location in system settings.';

  @override
  String get locationUnavailableTitle => 'Current location unavailable';

  @override
  String get locationUnavailableBody =>
      'Turn on device location or choose a supported city manually. Your coordinates are not stored.';

  @override
  String get closePage => 'Close page';

  @override
  String get bookmarksTitle => 'Saved';

  @override
  String get searchBookmarks => 'Search saved items';

  @override
  String get filterAll => 'All';

  @override
  String get filterRestaurants => 'Restaurants';

  @override
  String get filterFoods => 'Foods';

  @override
  String get filterMenuItems => 'Menu items';

  @override
  String get noBookmarksTitle => 'Nothing saved yet';

  @override
  String get noBookmarksBody =>
      'Restaurants, foods, menu items, and discoveries you save will stay available here offline.';

  @override
  String get removeBookmark => 'Remove bookmark';

  @override
  String get savedOffline => 'Saved on this device';

  @override
  String get profileSettingsTitle => 'Profile & Settings';

  @override
  String get accountNotConnected => 'Using Miz locally';

  @override
  String get connectAccount => 'Account connection is not available yet';

  @override
  String get personalization => 'Personalization';

  @override
  String get appearance => 'Appearance';

  @override
  String get locationSettings => 'Location';

  @override
  String get dataPrivacy => 'Data & privacy';

  @override
  String get localActivity => 'Local activity';

  @override
  String get conversationInputLabel => 'Continue your food search';

  @override
  String get aiUnavailableTitle => 'Miz AI is temporarily unavailable';

  @override
  String get aiUnavailableBody =>
      'The assistant could not respond right now. Your message remains in this session.';

  @override
  String get aiTimeoutTitle => 'Miz needs a little longer';

  @override
  String get aiTimeoutBody =>
      'The response took too long. Try the same request again.';

  @override
  String get aiRateLimitTitle => 'Miz is busy right now';

  @override
  String get aiRateLimitBody =>
      'Too many requests are being handled. Wait a moment, then try again.';

  @override
  String get placesUnavailableTitle => 'Place search is unavailable';

  @override
  String get placesUnavailableBody =>
      'Miz could not search restaurants right now. Try again shortly.';

  @override
  String get noPlacesTitle => 'No restaurants found';

  @override
  String get noPlacesBody =>
      'Try a different food, a wider area, or fewer filters.';

  @override
  String get aiRequestErrorTitle => 'Miz couldn\'t complete that';

  @override
  String get aiRequestErrorBody => 'Change the request slightly or try again.';

  @override
  String get retry => 'Retry';

  @override
  String get copyAction => 'Copy';

  @override
  String get saveDiscovery => 'Save discovery';

  @override
  String get newSearch => 'New search';

  @override
  String get closeConversation => 'Close conversation';

  @override
  String get newChat => 'New chat';

  @override
  String get chatHistory => 'Chat history';

  @override
  String get noChatHistory => 'No conversations yet';

  @override
  String get noChatHistoryBody =>
      'Start a conversation with Miz. It will appear here when you begin a new chat or leave the conversation.';

  @override
  String get chatHistoryUnavailable => 'Chat history could not be loaded.';

  @override
  String get deleteChat => 'Delete conversation';

  @override
  String restaurantResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count restaurant results',
      one: '1 restaurant result',
      zero: 'Restaurant results',
    );
    return '$_temp0';
  }

  @override
  String get cameraTitle => 'Camera';

  @override
  String get cameraPermissionTitle => 'Camera access needed';

  @override
  String get cameraPermissionBody =>
      'Point the camera at a Miz QR code, a menu, or a dish -- Miz figures out which. Captures stay temporary and are never uploaded silently.';

  @override
  String get allowCamera => 'Allow camera';

  @override
  String get cameraDeniedTitle => 'Camera access denied';

  @override
  String get cameraDeniedBody =>
      'Enable camera access in system settings to scan food, Miz QR codes, or menus.';

  @override
  String get cameraUnavailableTitle => 'Camera unavailable';

  @override
  String get cameraUnavailableBody =>
      'No usable camera is available on this device. You can still choose a photo for food or menu analysis.';

  @override
  String get offlineTitle => 'You\'re offline';

  @override
  String get offlineBody =>
      'Remote recognition and verification need a connection. No image has been uploaded.';

  @override
  String get liveCamera => 'Live camera preview';

  @override
  String get capture => 'Capture';

  @override
  String get preview => 'Preview';

  @override
  String get retake => 'Retake';

  @override
  String get confirm => 'Confirm';

  @override
  String get processing => 'Processing securely';

  @override
  String get noConfidentResult => 'No confident result';

  @override
  String get resultDetails => 'Result details';

  @override
  String get backendRequired => 'Secure backend required';

  @override
  String get cloudProcessingNotice =>
      'Continuing would require secure cloud processing. Miz will ask before any upload.';

  @override
  String get scanUnifiedInstruction =>
      'Point at a Miz QR code to open it automatically, or take a photo of a menu or a dish.';

  @override
  String get qrScannerUnavailableTitle => 'QR scanner unavailable';

  @override
  String get qrScannerUnavailableBody =>
      'Miz could not start the live QR camera. Check camera permission and try again.';

  @override
  String get scanAgain => 'Scan again';

  @override
  String get invalidQrTitle => 'Invalid Miz QR';

  @override
  String get invalidQrBody =>
      'This code is not a trusted Miz payload and was not opened.';

  @override
  String get expiredQrTitle => 'This Miz QR has expired';

  @override
  String get expiredQrBody => 'Ask the restaurant for a current code.';

  @override
  String get unpublishedQrTitle => 'Restaurant not published';

  @override
  String get unpublishedQrBody =>
      'This Miz restaurant is not currently available to open.';

  @override
  String get inactiveTableTitle => 'Table is inactive';

  @override
  String get inactiveTableBody =>
      'This table cannot start or join a session right now.';

  @override
  String get qrVerificationRequired =>
      'The QR format is valid. Network verification is required before opening a restaurant or table session.';

  @override
  String get captureUploadConsent =>
      'When you tap Analyze, this temporary photo is sent securely for AI analysis. Miz does not save it.';

  @override
  String get analyzePhoto => 'Analyze';

  @override
  String get captureUnrecognizedTitle => 'Miz couldn\'t tell what this was';

  @override
  String get captureUnrecognizedBody =>
      'Try a clearer photo of a menu or a single prepared dish, centered and in focus.';

  @override
  String get captureAnalysisFailedTitle => 'Miz could not analyze this photo';

  @override
  String get captureAnalysisFailedBody =>
      'The secure analysis did not finish. Your photo was not saved. Check your connection and try again.';

  @override
  String get foodRecognizedTitle => 'Food recognized';

  @override
  String get possibleMatchesTitle => 'Possible matches';

  @override
  String foodConfidence(int percent) {
    return '$percent% match';
  }

  @override
  String get foodRecognitionDisclaimer =>
      'AI recognition can be wrong and cannot confirm ingredients or allergy safety from a photo.';

  @override
  String get scanAnotherFood => 'Scan another food';

  @override
  String get foodUncertainTitle => 'Miz could not identify this food';

  @override
  String get foodUncertainBody =>
      'Try one well-lit dish in the center of the photo without packaging or clutter.';

  @override
  String get foodAnalysisFailedTitle => 'Food recognition did not finish';

  @override
  String get foodAnalysisFailedBody =>
      'The secure analysis failed. Your photo was not saved. Check your connection and try another photo.';

  @override
  String get menuPagesTitle => 'Menu pages';

  @override
  String get addPage => 'Add page';

  @override
  String pageNumber(int number) {
    return 'Page $number';
  }

  @override
  String get reorderPage => 'Reorder page';

  @override
  String get deletePage => 'Delete page';

  @override
  String get confirmPages => 'Confirm all pages';

  @override
  String get menuIncompleteTitle => 'Menu scan incomplete';

  @override
  String get menuIncompleteBody =>
      'Capture at least one readable page before continuing. Prices and ingredients may still require manual correction.';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get choosePhoto => 'Choose photo';

  @override
  String get menuPhotoInstruction =>
      'Take a clear, straight photo of the menu or choose one from your library.';

  @override
  String get menuImageUnavailableBody =>
      'This photo could not be opened. Choose another image.';

  @override
  String get menuUploadConsent =>
      'When you tap Explain menu, these temporary photos are sent securely for AI analysis. Miz does not save the photos.';

  @override
  String get explainMenu => 'Explain menu';

  @override
  String get menuExplainedTitle => 'Your menu, explained';

  @override
  String menuExplainedBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dishes found and checked against your Food Profile.',
      one: '1 dish found and checked against your Food Profile.',
      zero: 'No dishes matched Miz\'s food database yet.',
    );
    return '$_temp0';
  }

  @override
  String get menuNotesTitle => 'Helpful notes';

  @override
  String get menuAllergenDisclaimer =>
      'AI can make mistakes. Always confirm ingredients and allergens with the restaurant before ordering.';

  @override
  String get menuDishSafe => 'Fits your profile';

  @override
  String get menuDishWarning => 'Check before ordering';

  @override
  String get menuDishRestricted => 'Doesn\'t fit your profile';

  @override
  String get menuPriceGood => 'Good price';

  @override
  String get menuPriceHigh => 'A little pricier than average';

  @override
  String get menuPriceVeryHigh => 'High price';

  @override
  String get menuAskAboutThisMenu => 'Ask Miz about this menu';

  @override
  String get menuReasonNotHalal => 'Contains non-halal ingredients';

  @override
  String get menuReasonHalalUncertain => 'Halal status depends on preparation';

  @override
  String get menuReasonHalalUnknown => 'Halal status unknown';

  @override
  String get menuReasonHalalPreferenceNotMet =>
      'Not confirmed halal (your preference)';

  @override
  String get menuReasonNotVegan => 'Not vegan';

  @override
  String get menuReasonVeganUncertain => 'Vegan status uncertain';

  @override
  String get menuReasonNotVegetarian => 'Not vegetarian';

  @override
  String get menuReasonVegetarianUncertain => 'Vegetarian status uncertain';

  @override
  String get menuReasonContainsAlcohol => 'Contains alcohol';

  @override
  String get menuReasonMayContainAlcohol => 'May contain alcohol';

  @override
  String get menuReasonAlcoholUnknown => 'Alcohol content unknown';

  @override
  String get menuReasonAllergensNotVerifiable =>
      'Allergens could not be checked against your profile';

  @override
  String get scanAnotherMenu => 'Scan another menu';

  @override
  String get tryAnotherPhoto => 'Try another photo';

  @override
  String get menuUnreadableTitle => 'The menu was not clear enough';

  @override
  String get menuUnreadableBody =>
      'Try a brighter, straighter photo with the full menu text in focus.';

  @override
  String get menuAnalysisFailedTitle => 'Miz could not explain this menu';

  @override
  String get menuAnalysisFailedBody =>
      'The secure analysis did not finish. Your photos were not saved. Try again with a clear photo.';

  @override
  String get menuImageTooLargeTitle => 'Photo is too large';

  @override
  String get menuImageTooLargeBody =>
      'Choose a smaller photo or photograph fewer menu pages at once.';

  @override
  String get menuImageUnsupportedTitle => 'Photo format is not supported';

  @override
  String get menuImageUnsupportedBody =>
      'Choose a JPEG, PNG, WebP, HEIC, or HEIF photo.';

  @override
  String get menuTooManyPagesTitle => 'Too many menu pages';

  @override
  String get menuTooManyPagesBody =>
      'You can explain up to four menu pages at a time.';

  @override
  String get localDatabaseErrorTitle => 'Saved items unavailable';

  @override
  String get localDatabaseErrorBody =>
      'Miz couldn\'t read saved items from this device. Try closing and reopening this page.';
}
