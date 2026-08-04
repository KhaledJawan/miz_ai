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

  @override
  String get spatialHomeInputLabel => 'Sag Miz, was du essen möchtest';

  @override
  String get promptWhatToday => 'Was soll ich heute essen?';

  @override
  String get promptMatchTaste => 'Finde etwas, das zu meinem Geschmack passt.';

  @override
  String get promptRestaurantsNearby =>
      'Zeig mir großartige Restaurants in der Nähe.';

  @override
  String get promptSomethingNew => 'Ich möchte etwas Neues probieren.';

  @override
  String get promptLightMeal => 'Finde ein leichtes Essen für heute Abend.';

  @override
  String get promptNearMeNow => 'Was kann ich gerade in meiner Nähe essen?';

  @override
  String get promptSpicy => 'Ich möchte etwas Scharfes.';

  @override
  String get promptCafe => 'Finde ein gutes Café in der Nähe.';

  @override
  String get cameraAction => 'Kamera öffnen';

  @override
  String get bookmarksAction => 'Gespeicherte Elemente öffnen';

  @override
  String get profileSettingsAction => 'Profil und Einstellungen öffnen';

  @override
  String get selectCity => 'Stadt auswählen';

  @override
  String get noCitySelected => 'Stadt auswählen';

  @override
  String get locationNeededTitle => 'Standort benötigt';

  @override
  String get locationNeededBody =>
      'Wähle eine Stadt oder teile deinen Standort, damit Miz Orte in deiner Nähe finden kann.';

  @override
  String changeCity(String city) {
    return 'Stadt ändern: $city';
  }

  @override
  String get searchCity => 'Stadt suchen';

  @override
  String get useCurrentLocation => 'Aktuellen Standort verwenden';

  @override
  String get currentLocationPrivacy =>
      'Wird nur auf deinen Wunsch angefragt. Die manuelle Stadtauswahl funktioniert immer.';

  @override
  String get recentCities => 'Zuletzt verwendet';

  @override
  String get availableCities => 'Verfügbare Städte';

  @override
  String get setAsDefault => 'Diese Stadt als Standard verwenden';

  @override
  String get clearLocation => 'Ausgewählte und Standardstadt löschen';

  @override
  String get locationDeniedTitle => 'Standortzugriff verweigert';

  @override
  String get locationDeniedBody =>
      'Wähle eine Stadt manuell oder aktiviere den ungefähren Standort in den Systemeinstellungen.';

  @override
  String get locationUnavailableTitle => 'Aktueller Standort nicht verfügbar';

  @override
  String get locationUnavailableBody =>
      'Aktiviere den Gerätestandort oder wähle eine unterstützte Stadt manuell. Deine Koordinaten werden nicht gespeichert.';

  @override
  String get closePage => 'Seite schließen';

  @override
  String get bookmarksTitle => 'Gespeichert';

  @override
  String get searchBookmarks => 'Gespeicherte Elemente suchen';

  @override
  String get filterAll => 'Alle';

  @override
  String get filterRestaurants => 'Restaurants';

  @override
  String get filterFoods => 'Speisen';

  @override
  String get filterMenuItems => 'Menüpunkte';

  @override
  String get noBookmarksTitle => 'Noch nichts gespeichert';

  @override
  String get noBookmarksBody =>
      'Gespeicherte Restaurants, Speisen, Menüpunkte und Entdeckungen bleiben hier offline verfügbar.';

  @override
  String get removeBookmark => 'Lesezeichen entfernen';

  @override
  String get savedOffline => 'Auf diesem Gerät gespeichert';

  @override
  String get profileSettingsTitle => 'Profil & Einstellungen';

  @override
  String get accountNotConnected => 'Miz lokal verwenden';

  @override
  String get connectAccount => 'Kontoverbindung ist noch nicht verfügbar';

  @override
  String get personalization => 'Personalisierung';

  @override
  String get appearance => 'Darstellung';

  @override
  String get locationSettings => 'Standort';

  @override
  String get dataPrivacy => 'Daten & Datenschutz';

  @override
  String get localActivity => 'Lokale Aktivität';

  @override
  String get conversationInputLabel => 'Essenssuche fortsetzen';

  @override
  String get aiUnavailableTitle => 'Miz AI ist vorübergehend nicht verfügbar';

  @override
  String get aiUnavailableBody =>
      'Der Assistent konnte gerade nicht antworten. Deine Nachricht bleibt in dieser Sitzung.';

  @override
  String get aiTimeoutTitle => 'Miz braucht etwas länger';

  @override
  String get aiTimeoutBody =>
      'Die Antwort hat zu lange gedauert. Versuche dieselbe Anfrage erneut.';

  @override
  String get aiRateLimitTitle => 'Miz ist gerade beschäftigt';

  @override
  String get aiRateLimitBody =>
      'Es werden zu viele Anfragen bearbeitet. Warte kurz und versuche es erneut.';

  @override
  String get placesUnavailableTitle => 'Ortssuche nicht verfügbar';

  @override
  String get placesUnavailableBody =>
      'Miz konnte gerade nicht nach Restaurants suchen. Versuche es gleich erneut.';

  @override
  String get noPlacesTitle => 'Keine Restaurants gefunden';

  @override
  String get noPlacesBody =>
      'Versuche ein anderes Gericht, einen größeren Bereich oder weniger Filter.';

  @override
  String get aiRequestErrorTitle => 'Miz konnte das nicht abschließen';

  @override
  String get aiRequestErrorBody =>
      'Ändere die Anfrage leicht oder versuche es erneut.';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get copyAction => 'Kopieren';

  @override
  String get saveDiscovery => 'Entdeckung speichern';

  @override
  String get newSearch => 'Neue Suche';

  @override
  String get closeConversation => 'Unterhaltung schließen';

  @override
  String get newChat => 'Neuer Chat';

  @override
  String get chatHistory => 'Chatverlauf';

  @override
  String get noChatHistory => 'Noch keine Unterhaltungen';

  @override
  String get noChatHistoryBody =>
      'Starte eine Unterhaltung mit Miz. Sie erscheint hier, wenn du einen neuen Chat beginnst oder die Unterhaltung verlässt.';

  @override
  String get chatHistoryUnavailable =>
      'Der Chatverlauf konnte nicht geladen werden.';

  @override
  String get deleteChat => 'Unterhaltung löschen';

  @override
  String restaurantResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Restaurantergebnisse',
      one: '1 Restaurantergebnis',
      zero: 'Restaurantergebnisse',
    );
    return '$_temp0';
  }

  @override
  String get cameraTitle => 'Kamera';

  @override
  String get cameraPermissionTitle => 'Kamerazugriff erforderlich';

  @override
  String get cameraPermissionBody =>
      'Richte die Kamera auf einen Miz-QR-Code, eine Speisekarte oder ein Gericht -- Miz erkennt automatisch, worum es sich handelt. Aufnahmen bleiben temporär und werden nie unbemerkt hochgeladen.';

  @override
  String get allowCamera => 'Kamera erlauben';

  @override
  String get cameraDeniedTitle => 'Kamerazugriff verweigert';

  @override
  String get cameraDeniedBody =>
      'Aktiviere die Kamera in den Systemeinstellungen, um Speisen, Miz-QR-Codes oder Menüs zu scannen.';

  @override
  String get cameraUnavailableTitle => 'Kamera nicht verfügbar';

  @override
  String get cameraUnavailableBody =>
      'Auf diesem Gerät ist keine nutzbare Kamera verfügbar. Für die Speise- oder Menüanalyse kannst du weiterhin ein Foto auswählen.';

  @override
  String get offlineTitle => 'Du bist offline';

  @override
  String get offlineBody =>
      'Erkennung und Verifizierung benötigen eine Verbindung. Es wurde kein Bild hochgeladen.';

  @override
  String get liveCamera => 'Live-Kameravorschau';

  @override
  String get capture => 'Aufnehmen';

  @override
  String get preview => 'Vorschau';

  @override
  String get retake => 'Neu aufnehmen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get processing => 'Sichere Verarbeitung';

  @override
  String get noConfidentResult => 'Kein sicheres Ergebnis';

  @override
  String get resultDetails => 'Ergebnisdetails';

  @override
  String get backendRequired => 'Sicheres Backend erforderlich';

  @override
  String get cloudProcessingNotice =>
      'Zum Fortfahren wäre eine sichere Cloud-Verarbeitung nötig. Miz fragt vor jedem Upload nach.';

  @override
  String get scanUnifiedInstruction =>
      'Richte die Kamera auf einen Miz-QR-Code, um ihn automatisch zu öffnen, oder fotografiere eine Speisekarte oder ein Gericht.';

  @override
  String get qrScannerUnavailableTitle => 'QR-Scanner nicht verfügbar';

  @override
  String get qrScannerUnavailableBody =>
      'Miz konnte die QR-Kamera nicht starten. Prüfe die Kameraberechtigung und versuche es erneut.';

  @override
  String get scanAgain => 'Erneut scannen';

  @override
  String get invalidQrTitle => 'Ungültiger Miz QR';

  @override
  String get invalidQrBody =>
      'Dieser Code ist keine vertrauenswürdige Miz-Nutzlast und wurde nicht geöffnet.';

  @override
  String get expiredQrTitle => 'Dieser Miz QR ist abgelaufen';

  @override
  String get expiredQrBody => 'Bitte das Restaurant um einen aktuellen Code.';

  @override
  String get unpublishedQrTitle => 'Restaurant nicht veröffentlicht';

  @override
  String get unpublishedQrBody =>
      'Dieses Miz-Restaurant kann derzeit nicht geöffnet werden.';

  @override
  String get inactiveTableTitle => 'Tisch ist inaktiv';

  @override
  String get inactiveTableBody =>
      'Dieser Tisch kann momentan keine Sitzung starten oder ihr beitreten.';

  @override
  String get qrVerificationRequired =>
      'Das QR-Format ist gültig. Vor dem Öffnen eines Restaurants oder einer Tischsitzung ist eine Netzwerkprüfung erforderlich.';

  @override
  String get captureUploadConsent =>
      'Wenn du auf Analysieren tippst, wird dieses temporäre Foto sicher zur KI-Analyse gesendet. Miz speichert es nicht.';

  @override
  String get analyzePhoto => 'Analysieren';

  @override
  String get captureUnrecognizedTitle =>
      'Miz konnte nicht erkennen, was das war';

  @override
  String get captureUnrecognizedBody =>
      'Versuche ein deutlicheres Foto einer Speisekarte oder eines einzelnen fertigen Gerichts, zentriert und scharf.';

  @override
  String get captureAnalysisFailedTitle =>
      'Miz konnte dieses Foto nicht analysieren';

  @override
  String get captureAnalysisFailedBody =>
      'Die sichere Analyse wurde nicht abgeschlossen. Dein Foto wurde nicht gespeichert. Prüfe die Verbindung und versuche es erneut.';

  @override
  String get foodRecognizedTitle => 'Speise erkannt';

  @override
  String get possibleMatchesTitle => 'Mögliche Treffer';

  @override
  String foodConfidence(int percent) {
    return '$percent % Treffer';
  }

  @override
  String get foodRecognitionDisclaimer =>
      'KI-Erkennung kann falsch sein und Zutaten oder Allergiesicherheit nicht anhand eines Fotos bestätigen.';

  @override
  String get scanAnotherFood => 'Weitere Speise scannen';

  @override
  String get foodUncertainTitle => 'Miz konnte diese Speise nicht erkennen';

  @override
  String get foodUncertainBody =>
      'Fotografiere ein einzelnes, gut beleuchtetes Gericht mittig und ohne Verpackung oder Unordnung.';

  @override
  String get foodAnalysisFailedTitle =>
      'Speiseerkennung wurde nicht abgeschlossen';

  @override
  String get foodAnalysisFailedBody =>
      'Die sichere Analyse ist fehlgeschlagen. Dein Foto wurde nicht gespeichert. Prüfe die Verbindung und versuche ein anderes Foto.';

  @override
  String get menuPagesTitle => 'Menüseiten';

  @override
  String get addPage => 'Seite hinzufügen';

  @override
  String pageNumber(int number) {
    return 'Seite $number';
  }

  @override
  String get reorderPage => 'Seite verschieben';

  @override
  String get deletePage => 'Seite löschen';

  @override
  String get confirmPages => 'Alle Seiten bestätigen';

  @override
  String get menuIncompleteTitle => 'Menüscan unvollständig';

  @override
  String get menuIncompleteBody =>
      'Nimm mindestens eine lesbare Seite auf. Preise und Zutaten müssen möglicherweise manuell korrigiert werden.';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get choosePhoto => 'Foto auswählen';

  @override
  String get menuPhotoInstruction =>
      'Fotografiere die Speisekarte klar und gerade oder wähle ein Bild aus deiner Mediathek.';

  @override
  String get menuImageUnavailableBody =>
      'Dieses Foto konnte nicht geöffnet werden. Wähle ein anderes Bild.';

  @override
  String get menuUploadConsent =>
      'Wenn du auf Menü erklären tippst, werden diese temporären Fotos sicher zur KI-Analyse gesendet. Miz speichert die Fotos nicht.';

  @override
  String get explainMenu => 'Menü erklären';

  @override
  String get menuExplainedTitle => 'Deine Speisekarte, erklärt';

  @override
  String menuExplainedBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count Gerichte gefunden und mit deinem Food Profile abgeglichen.',
      one: '1 Gericht gefunden und mit deinem Food Profile abgeglichen.',
      zero: 'Noch keine Gerichte in Miz\' Essensdatenbank gefunden.',
    );
    return '$_temp0';
  }

  @override
  String get menuNotesTitle => 'Hilfreiche Hinweise';

  @override
  String get menuAllergenDisclaimer =>
      'KI kann Fehler machen. Bestätige Zutaten und Allergene vor der Bestellung immer beim Restaurant.';

  @override
  String get menuDishSafe => 'Passt zu deinem Profil';

  @override
  String get menuDishWarning => 'Vor der Bestellung prüfen';

  @override
  String get menuDishRestricted => 'Passt nicht zu deinem Profil';

  @override
  String get menuPriceGood => 'Guter Preis';

  @override
  String get menuPriceHigh => 'Etwas teurer als im Durchschnitt';

  @override
  String get menuPriceVeryHigh => 'Hoher Preis';

  @override
  String get menuAskAboutThisMenu => 'Miz zu diesem Menü fragen';

  @override
  String get menuReasonNotHalal => 'Enthält nicht-halal Zutaten';

  @override
  String get menuReasonHalalUncertain =>
      'Halal-Status hängt von der Zubereitung ab';

  @override
  String get menuReasonHalalUnknown => 'Halal-Status unbekannt';

  @override
  String get menuReasonHalalPreferenceNotMet =>
      'Nicht als halal bestätigt (deine Präferenz)';

  @override
  String get menuReasonNotVegan => 'Nicht vegan';

  @override
  String get menuReasonVeganUncertain => 'Veganer Status unsicher';

  @override
  String get menuReasonNotVegetarian => 'Nicht vegetarisch';

  @override
  String get menuReasonVegetarianUncertain => 'Vegetarischer Status unsicher';

  @override
  String get menuReasonContainsAlcohol => 'Enthält Alkohol';

  @override
  String get menuReasonMayContainAlcohol => 'Kann Alkohol enthalten';

  @override
  String get menuReasonAlcoholUnknown => 'Alkoholgehalt unbekannt';

  @override
  String get menuReasonAllergensNotVerifiable =>
      'Allergene konnten nicht mit deinem Profil abgeglichen werden';

  @override
  String get scanAnotherMenu => 'Weiteres Menü scannen';

  @override
  String get tryAnotherPhoto => 'Anderes Foto versuchen';

  @override
  String get menuUnreadableTitle => 'Die Speisekarte war nicht deutlich genug';

  @override
  String get menuUnreadableBody =>
      'Versuche ein helleres, gerades Foto, auf dem der gesamte Menütext scharf ist.';

  @override
  String get menuAnalysisFailedTitle => 'Miz konnte dieses Menü nicht erklären';

  @override
  String get menuAnalysisFailedBody =>
      'Die sichere Analyse wurde nicht abgeschlossen. Deine Fotos wurden nicht gespeichert. Versuche es mit einem deutlichen Foto erneut.';

  @override
  String get menuImageTooLargeTitle => 'Foto ist zu groß';

  @override
  String get menuImageTooLargeBody =>
      'Wähle ein kleineres Foto oder fotografiere weniger Menüseiten gleichzeitig.';

  @override
  String get menuImageUnsupportedTitle => 'Fotoformat wird nicht unterstützt';

  @override
  String get menuImageUnsupportedBody =>
      'Wähle ein JPEG-, PNG-, WebP-, HEIC- oder HEIF-Foto.';

  @override
  String get menuTooManyPagesTitle => 'Zu viele Menüseiten';

  @override
  String get menuTooManyPagesBody =>
      'Du kannst bis zu vier Menüseiten gleichzeitig erklären lassen.';

  @override
  String get localDatabaseErrorTitle => 'Gespeicherte Elemente nicht verfügbar';

  @override
  String get localDatabaseErrorBody =>
      'Miz konnte die gespeicherten Elemente auf diesem Gerät nicht lesen. Schließe und öffne diese Seite erneut.';
}
