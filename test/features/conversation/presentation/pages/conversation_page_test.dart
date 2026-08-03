import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:miz_ai/core/database/app_database.dart';
import 'package:miz_ai/core/database/app_database_provider.dart';
import 'package:miz_ai/core/localization/localization.dart';
import 'package:miz_ai/core/theme/app_theme.dart';
import 'package:miz_ai/features/conversation/domain/conversation_models.dart';
import 'package:miz_ai/features/conversation/domain/conversation_service.dart';
import 'package:miz_ai/features/conversation/presentation/pages/conversation_page.dart';
import 'package:miz_ai/features/conversation/presentation/providers/conversation_controller.dart';
import 'package:miz_ai/features/location/data/device_location_gateway.dart';
import 'package:miz_ai/features/location/data/transient_position_reader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _StubConversationService implements ConversationService {
  _StubConversationService(this._reply);
  final ConversationReply _reply;

  @override
  Future<ConversationReply> respond(ConversationRequest request) async =>
      _reply;
}

class _ErrorConversationService implements ConversationService {
  const _ErrorConversationService(this.code);
  final String code;

  @override
  Future<ConversationReply> respond(ConversationRequest request) async {
    throw ConversationAiException(code, 'safe message');
  }
}

class _NoPositionGateway implements DeviceLocationGateway {
  @override
  Future<bool> isServiceEnabled() async => false;

  @override
  Future<DeviceLocationPermission> checkPermission() async =>
      DeviceLocationPermission.denied;

  @override
  Future<DeviceLocationPermission> requestPermission() async =>
      DeviceLocationPermission.denied;

  @override
  Future<DevicePosition> currentPosition() async => throw StateError('unused');
}

Widget _wrap({
  required String initialPrompt,
  required ConversationService service,
  required AppDatabase database,
}) {
  final router = GoRouter(
    initialLocation: '/chat',
    routes: [
      GoRoute(
        path: '/chat',
        builder: (context, state) =>
            ConversationPage(initialPrompt: initialPrompt),
      ),
      GoRoute(
        path: '/city',
        builder: (context, state) => const Scaffold(body: Text('City picker')),
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      conversationServiceProvider.overrideWithValue(service),
      appDatabaseProvider.overrideWithValue(database),
      transientPositionReaderProvider.overrideWithValue(
        TransientPositionReader(gateway: _NoPositionGateway()),
      ),
    ],
    child: MaterialApp.router(
      theme: AppTheme.light(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
    ),
  );
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  late AppDatabase database;
  setUp(() => database = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => database.close());

  testWidgets('renders a place result card when the reply includes places', (
    tester,
  ) async {
    final service = _StubConversationService(
      const ConversationReply(
        text: 'Here is a great spot.',
        places: [
          AiPlace(
            id: 'places/1',
            name: 'Café Central',
            address: 'Hauptstraße 1',
            latitude: 49.75,
            longitude: 6.64,
            rating: 4.5,
            distanceMeters: 250,
          ),
        ],
      ),
    );

    await tester.pumpWidget(
      _wrap(initialPrompt: 'Find a café', service: service, database: database),
    );
    await tester.pumpAndSettle();

    expect(find.text('Here is a great spot.'), findsOneWidget);
    expect(find.text('Café Central'), findsOneWidget);
    expect(find.text('Hauptstraße 1'), findsOneWidget);
  });

  testWidgets('renders a location-required card with a select-city action', (
    tester,
  ) async {
    final service = _StubConversationService(
      const ConversationReply(text: '', requiresLocation: true),
    );

    await tester.pumpWidget(
      _wrap(
        initialPrompt: 'Find sushi near me',
        service: service,
        database: database,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Location needed'), findsOneWidget);

    await tester.tap(find.text('Select city'));
    await tester.pumpAndSettle();

    expect(find.text('City picker'), findsOneWidget);
  });

  testWidgets('renders a dedicated timeout state', (tester) async {
    await tester.pumpWidget(
      _wrap(
        initialPrompt: 'Find dinner',
        service: const _ErrorConversationService('AI_TIMEOUT'),
        database: database,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Miz needs a little longer'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('renders a dedicated no-results state', (tester) async {
    await tester.pumpWidget(
      _wrap(
        initialPrompt: 'Find moon restaurants',
        service: const _ErrorConversationService('NO_RESULTS'),
        database: database,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No restaurants found'), findsOneWidget);
  });

  testWidgets(
    'visually separates user and Miz messages without copy controls',
    (tester) async {
      await tester.pumpWidget(
        _wrap(
          initialPrompt: 'Find ramen',
          service: _StubConversationService(
            const ConversationReply(text: 'Here are two good options.'),
          ),
          database: database,
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('conversation-user-message')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('conversation-miz-message')),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.auto_awesome_rounded), findsOneWidget);
      expect(find.byIcon(Icons.copy_rounded), findsNothing);
      expect(find.byIcon(Icons.close_rounded), findsNothing);
      expect(find.byIcon(Icons.history_rounded), findsOneWidget);
      expect(find.byIcon(Icons.add_comment_rounded), findsOneWidget);
    },
  );

  testWidgets('sending dismisses the keyboard so the reply is visible', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        initialPrompt: '',
        service: _StubConversationService(
          const ConversationReply(text: 'Try pasta tonight.'),
        ),
        database: database,
      ),
    );
    await tester.tap(find.byKey(const ValueKey('spatial-ai-input')));
    await tester.enterText(
      find.byKey(const ValueKey('spatial-ai-input')),
      'What should I eat?',
    );
    await tester.pump();
    expect(tester.testTextInput.isVisible, isTrue);

    await tester.tap(find.byKey(const ValueKey('spatial-send-button')));
    await tester.pumpAndSettle();

    expect(tester.testTextInput.isVisible, isFalse);
    expect(find.text('Try pasta tonight.'), findsOneWidget);
  });
}
