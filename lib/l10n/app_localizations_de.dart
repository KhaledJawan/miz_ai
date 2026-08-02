// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Miz';

  @override
  String get conversationTitle => 'Unterhaltung';

  @override
  String get recommendationsTitle => 'Empfehlungen';

  @override
  String get restaurantDetailsTitle => 'Restaurantdetails';

  @override
  String get discoverTitle => 'Entdecken';

  @override
  String get menuTitle => 'Speisekarte';

  @override
  String get reserveTitle => 'Reservieren';

  @override
  String get checkoutTitle => 'Kasse';

  @override
  String get orderTrackingTitle => 'Bestellung verfolgen';

  @override
  String get comingSoonMessage =>
      'Dieses Erlebnis ist geplant und wurde noch nicht umgesetzt.';

  @override
  String get backToHome => 'Zur Startseite';

  @override
  String get mizThinking => 'Miz denkt nach';

  @override
  String get mizListening => 'Miz hört zu';

  @override
  String get mizTaskComplete => 'Miz hat die Aufgabe abgeschlossen';

  @override
  String restaurantPhoto(String name) {
    return 'Restaurantfoto von $name';
  }

  @override
  String restaurantImagePlaceholder(String name) {
    return 'Platzhalter für ein Restaurantbild von $name';
  }

  @override
  String get meetMiz => 'Lerne Miz kennen.';

  @override
  String get onboardingIntroDescription =>
      'Dein KI-Begleiter für die Entscheidung, was du essen möchtest, wo du es findest und wie du es bekommst.';

  @override
  String get findNearbyTitle => 'Finde Restaurants in deiner Nähe';

  @override
  String get findNearbyDescription =>
      'Entdecke die besten Restaurants in deiner Umgebung mit genauer Entfernung, Lieferzeit und Verfügbarkeit.';

  @override
  String get rememberChoicesTitle => 'Meine Auswahl merken?';

  @override
  String get rememberChoicesDescription =>
      'Lass Miz deinen Geschmack kennenlernen, damit jede Empfehlung schneller und persönlicher wird.';

  @override
  String get personalizeMiz => 'Miz personalisieren';

  @override
  String get changeAnytime => 'Du kannst dies jederzeit ändern.';

  @override
  String get getStarted => 'Loslegen';

  @override
  String get allowLocation => 'Standort erlauben';

  @override
  String get continueLabel => 'Weiter';

  @override
  String get notNow => 'Nicht jetzt';

  @override
  String get nearYou => 'In deiner Nähe';

  @override
  String get profile => 'Profil';

  @override
  String get openTodayOffers => 'Heutige Angebote öffnen';

  @override
  String get todayOffers => 'Heutige Angebote';

  @override
  String get offerDescription => '20 % Rabatt auf Desserts, nur heute Abend';

  @override
  String get hungry => 'Ich habe Hunger';

  @override
  String get orderFood => 'Essen bestellen';

  @override
  String get reserveTable => 'Tisch reservieren';

  @override
  String get findCafe => 'Café finden';

  @override
  String get yourFavorites => 'Deine Favoriten';

  @override
  String get seeAll => 'Alle ansehen';

  @override
  String get foodPrompt => 'Was möchtest du essen?';

  @override
  String get addPhotoComingSoon => 'Foto hinzufügen (demnächst)';

  @override
  String get voiceComingSoon => 'Spracheingabe (demnächst)';

  @override
  String get send => 'Senden';

  @override
  String get tasteProfilePreferences => 'Geschmacksprofil und Vorlieben';

  @override
  String get closeSettings => 'Einstellungen schließen';

  @override
  String get preferences => 'Einstellungen';

  @override
  String get language => 'Sprache';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get locationPermission => 'Standortberechtigung';

  @override
  String get rememberMyPreferences => 'Meine Vorlieben merken';

  @override
  String get supportAndPrivacy => 'Support und Datenschutz';

  @override
  String get privacy => 'Datenschutz';

  @override
  String get about => 'Über Miz';

  @override
  String get help => 'Hilfe';

  @override
  String get logOut => 'Abmelden';

  @override
  String get chooseLanguage => 'Sprache auswählen';

  @override
  String selectedLanguage(String language) {
    return 'Ausgewählte Sprache: $language';
  }

  @override
  String get noLimit => 'Keine Begrenzung';

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
    return '$minutes Min.';
  }

  @override
  String get openNow => 'Jetzt geöffnet';

  @override
  String get cuisineItalian => 'Italienisch';

  @override
  String get cuisineBurger => 'Burger';

  @override
  String get cuisineAsian => 'Asiatisch';

  @override
  String get cuisineHealthy => 'Gesund';

  @override
  String get cuisineDessert => 'Dessert';

  @override
  String get cuisineCafe => 'Café';

  @override
  String get cuisineDrinks => 'Weinbar';

  @override
  String get dietStepTitle => 'Was beschreibt deine Ernährung am besten?';

  @override
  String get dietVegan => 'Vegan';

  @override
  String get dietVegetarian => 'Vegetarisch';

  @override
  String get dietPescatarian => 'Pescetarisch';

  @override
  String get dietFlexitarian => 'Flexitarisch';

  @override
  String get dietOmnivore => 'Ich esse alles';

  @override
  String get dietOther => 'Andere';

  @override
  String get dietPreferNotToSay => 'Möchte ich nicht sagen';

  @override
  String get foodRulesStepTitle =>
      'Gibt es Ernährungsregeln, die wir kennen sollten?';

  @override
  String get foodRulesStepHint =>
      'Tippe auf einen Eintrag, um ihn als erforderlich, bevorzugt oder zu vermeiden zu markieren.';

  @override
  String get requirementRequired => 'Erforderlich';

  @override
  String get requirementPreferred => 'Bevorzugt';

  @override
  String get requirementAvoid => 'Vermeiden';

  @override
  String get allergiesStepTitle => 'Hast du Lebensmittelallergien?';

  @override
  String get noKnownAllergies => 'Keine bekannten Allergien';

  @override
  String get searchAllergens => 'Allergene suchen';

  @override
  String get customAllergyHint => 'Eine nicht aufgeführte Allergie hinzufügen';

  @override
  String get addCustomAllergy => 'Hinzufügen';

  @override
  String get allergySafetyNotice =>
      'Das hilft uns, keine unsicheren Speisen vorzuschlagen — bestätige Allergene vor der Bestellung aber immer beim Restaurant.';

  @override
  String get severityMild => 'Leicht';

  @override
  String get severityModerate => 'Mittel';

  @override
  String get severitySevere => 'Schwer';

  @override
  String get severityUnspecified => 'Nicht angegeben';

  @override
  String get severeAllergyConfirmTitle => 'Schwere Allergie bestätigen';

  @override
  String get severeAllergyConfirmBody =>
      'Du hast eine schwere Allergie markiert. Wir schließen Speisen, die sie enthalten, immer aus. Fortfahren?';

  @override
  String get intolerancesStepTitle =>
      'Hast du Lebensmittelunverträglichkeiten?';

  @override
  String get intolerancesStepHint =>
      'Das ist etwas anderes als eine Allergie — wir nutzen es, um Vorschläge anzupassen, nicht um Speisen komplett auszuschließen.';

  @override
  String get noneOfTheAbove => 'Nichts davon';

  @override
  String get proteinsStepTitle => 'Welche Proteine isst du?';

  @override
  String get showFewerOptions => 'Weniger Optionen anzeigen';

  @override
  String get showMoreOptions => 'Mehr Optionen anzeigen';

  @override
  String get eatAndLike => 'Esse ich gern';

  @override
  String get dislikeIngredient => 'Mag ich nicht';

  @override
  String get neverEat => 'Esse ich nie';

  @override
  String get cuisinesStepTitle => 'Welche Küchen magst du?';

  @override
  String get searchCuisines => 'Küchen suchen';

  @override
  String get preferenceLove => 'Liebe ich';

  @override
  String get preferenceLike => 'Mag ich';

  @override
  String get preferenceCurious => 'Neugierig';

  @override
  String get preferenceNotInterested => 'Kein Interesse';

  @override
  String get flavorsStepTitle => 'Welche Geschmacksrichtungen magst du?';

  @override
  String get spiceNotSpicy => 'Nicht scharf';

  @override
  String get spiceMild => 'Mild';

  @override
  String get spiceMedium => 'Mittel';

  @override
  String get spiceHot => 'Scharf';

  @override
  String get spiceVeryHot => 'Sehr scharf';

  @override
  String get eatingStyleStepTitle => 'Wie isst du am liebsten?';

  @override
  String get adventurousnessQuestion => 'Wie oft probierst du neue Speisen?';

  @override
  String get adventurousnessAlmostNever => 'Fast nie';

  @override
  String get adventurousnessSometimes => 'Manchmal';

  @override
  String get adventurousnessOften => 'Oft';

  @override
  String get adventurousnessAlmostAlways => 'Fast immer';

  @override
  String get topPrioritiesQuestion => 'Was ist dir am wichtigsten?';

  @override
  String get topPrioritiesHint => 'Wähle bis zu 3 aus.';

  @override
  String get priorityTaste => 'Geschmack';

  @override
  String get priorityPrice => 'Preis';

  @override
  String get priorityHealth => 'Gesundheit';

  @override
  String get priorityPortionSize => 'Portionsgröße';

  @override
  String get priorityIngredients => 'Zutaten';

  @override
  String get priorityAppearance => 'Aussehen';

  @override
  String get priorityPreparationTime => 'Zubereitungszeit';

  @override
  String get priorityPopularity => 'Beliebtheit';

  @override
  String get priorityFamiliarity => 'Vertrautheit';

  @override
  String get prioritySomethingNew => 'Etwas Neues';

  @override
  String get mealWeightQuestion => 'Wie sättigend magst du deine Mahlzeiten?';

  @override
  String get mealWeightLight => 'Leicht';

  @override
  String get mealWeightBalanced => 'Ausgewogen';

  @override
  String get mealWeightFilling => 'Sättigend';

  @override
  String get mealWeightDepends => 'Kommt auf die Situation an';

  @override
  String get budgetQuestion => 'Wie hoch ist dein übliches Budget?';

  @override
  String get budgetOptionalHint => 'Optional — du kannst das überspringen.';

  @override
  String get budgetLow => 'Niedrig';

  @override
  String get budgetMedium => 'Mittel';

  @override
  String get budgetHigh => 'Hoch';

  @override
  String get budgetNoPreference => 'Keine Präferenz';

  @override
  String get foodSamplesStepTitle =>
      'Ein paar Speisen, um deinen Geschmack kennenzulernen';

  @override
  String get foodSamplesStepHint =>
      'Tippe, wie du zu jeder Speise stehst — es gibt keine falsche Antwort.';

  @override
  String get foodSampleLike => 'Gefällt mir';

  @override
  String get foodSampleCurious => 'Neugierig';

  @override
  String get foodSampleNeverTried => 'Nie probiert';

  @override
  String get foodSampleDislike => 'Gefällt mir nicht';

  @override
  String get reviewStepTitle => 'Dein Geschmacksprofil im Überblick';

  @override
  String get reviewAnswered => 'Beantwortet';

  @override
  String get reviewNotAnswered => 'Noch nicht beantwortet';

  @override
  String reviewSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ausgewählt',
      one: '1 ausgewählt',
    );
    return '$_temp0';
  }

  @override
  String get reviewEdit => 'Bearbeiten';

  @override
  String get foodProfileWelcomeTitle => 'Lass uns deinen Geschmack verstehen';

  @override
  String get foodProfileWelcomeBody =>
      'Ein paar kurze Fragen helfen Miz, Speisen vorzuschlagen, die du wirklich essen möchtest. Du kannst jede Antwort später ändern.';

  @override
  String get foodProfileBack => 'Zurück';

  @override
  String get foodProfileComplete => 'Abschließen';

  @override
  String get cancelLabel => 'Abbrechen';

  @override
  String get doneLabel => 'Fertig';

  @override
  String get foodProfileTitle => 'Geschmacksprofil';

  @override
  String get foodProfilePreferences => 'Geschmacksprofil';

  @override
  String get foodProfileSectionsLabel => 'Deine Angaben';

  @override
  String get foodProfileCompletenessLabel => 'Vollständigkeit des Profils';

  @override
  String foodProfileLastUpdated(String date) {
    return 'Zuletzt aktualisiert am $date';
  }

  @override
  String get foodProfilePrivacyLabel => 'Datenschutz und Zurücksetzen';

  @override
  String get behaviorPersonalizationToggle =>
      'Anhand meiner Aktivität personalisieren';

  @override
  String get behaviorPersonalizationHint =>
      'Lässt Miz Vorschläge anhand dessen verfeinern, was du ansiehst, speicherst und ausblendest. Deine expliziten Angaben bleiben immer erhalten.';

  @override
  String get deleteInteractionHistory => 'Aktivitätsverlauf löschen';

  @override
  String get deleteInteractionHistoryConfirmBody =>
      'Dadurch wird der lokale Aktivitätsverlauf gelöscht, den Miz zur Verfeinerung nutzt. Deine expliziten Angaben, Allergien und Vorlieben sind davon nicht betroffen.';

  @override
  String get restartOnboardingAction => 'Einrichtung neu starten';

  @override
  String get restartOnboardingConfirmBody =>
      'Du durchläufst alle Fragen erneut von Anfang an. Deine aktuellen Angaben bleiben erhalten, bis du sie änderst.';

  @override
  String get resetFoodProfileAction => 'Geschmacksprofil zurücksetzen';

  @override
  String get resetFoodProfileConfirmBody =>
      'Dadurch werden alle deine Geschmacksvorlieben, Allergien, Einschränkungen und dein Aktivitätsverlauf dauerhaft gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get foodProfilePrivacyNotice =>
      'Dein Geschmacksprofil wird auf diesem Gerät gespeichert und zur Personalisierung der Miz-Vorschläge genutzt. Es ersetzt nicht die Bestätigung von Allergenen direkt beim Restaurant.';
}
