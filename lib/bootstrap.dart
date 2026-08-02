import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/database/app_database.dart';
import 'core/database/app_database_provider.dart';
import 'core/localization/app_language.dart';
import 'core/localization/language_store.dart';
import 'core/router/app_router.dart';
import 'features/food_profile/data/food_profile_repository_impl.dart';

/// Composition root. Milestone 6 adds Supabase.initialize() and env loading
/// here before runApp — see docs/DEPLOYMENT.md environments table.
///
/// Also opens and seeds the local Food Preference Profile database (Drift)
/// and resolves the app's start route *before* `runApp`: a completed or
/// skipped profile opens straight to Home, anything else (including a
/// resumed in-progress onboarding) opens onboarding — see
/// docs/DECISIONS.md ADR-013. This avoids an async GoRouter redirect and
/// the splash-frame flicker that comes with it.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  final languageStore = SharedPreferencesLanguageStore(
    SharedPreferencesAsync(),
  );
  final savedLanguageCode = await languageStore.readLanguageCode();
  final initialLanguage = AppLanguage.fromCode(
    savedLanguageCode ?? AppLanguage.english.code,
  );

  final database = AppDatabase();
  final profile = await FoodProfileRepositoryImpl(database).ensureProfile();
  final initialLocation = profile.isOnboarded
      ? AppRoutes.home
      : AppRoutes.onboarding;

  runApp(
    ProviderScope(
      overrides: [
        initialLanguageCodeProvider.overrideWithValue(initialLanguage.code),
        languageStoreProvider.overrideWithValue(languageStore),
        appDatabaseProvider.overrideWithValue(database),
        initialLocationProvider.overrideWithValue(initialLocation),
      ],
      child: const MizApp(),
    ),
  );
}
