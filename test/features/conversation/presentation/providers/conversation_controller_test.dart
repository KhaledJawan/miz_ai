import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/core/database/app_database.dart';
import 'package:miz_ai/core/database/app_database_provider.dart';
import 'package:miz_ai/features/conversation/domain/conversation_models.dart';
import 'package:miz_ai/features/conversation/domain/conversation_service.dart';
import 'package:miz_ai/features/conversation/presentation/providers/conversation_controller.dart';
import 'package:miz_ai/features/location/data/device_location_gateway.dart';
import 'package:miz_ai/features/location/data/transient_position_reader.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<DevicePosition> currentPosition() async =>
      throw StateError('should never be called when service is disabled');
}

class _FakeConversationService implements ConversationService {
  _FakeConversationService(this._handler);

  final ConversationReply Function(ConversationRequest request) _handler;
  final List<ConversationRequest> requests = [];

  @override
  Future<ConversationReply> respond(ConversationRequest request) async {
    requests.add(request);
    return _handler(request);
  }
}

class _ThrowingConversationService implements ConversationService {
  _ThrowingConversationService(this._error);
  final Object _error;

  @override
  Future<ConversationReply> respond(ConversationRequest request) async {
    throw _error;
  }
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  ProviderContainer buildContainer(ConversationService service) {
    final container = ProviderContainer(
      overrides: [
        conversationServiceProvider.overrideWithValue(service),
        appDatabaseProvider.overrideWithValue(database),
        transientPositionReaderProvider.overrideWithValue(
          TransientPositionReader(gateway: _NoPositionGateway()),
        ),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('sends the initial prompt and appends the assistant reply', () async {
    final fake = _FakeConversationService(
      (request) => ConversationReply(text: 'Sushi is a Japanese dish.'),
    );
    final container = buildContainer(fake);
    final provider = conversationControllerProvider('What is sushi?');

    // The initial send happens in a microtask scheduled from build() —
    // wait for the state to leave "loading" rather than guessing a delay.
    container.read(provider);
    final completer = Completer<void>();
    late final ProviderSubscription<ConversationState> subscription;
    subscription = container.listen(provider, (previous, next) {
      if (next.status != ConversationStatus.loading && !completer.isCompleted) {
        completer.complete();
      }
    });
    addTearDown(subscription.close);
    await completer.future.timeout(const Duration(seconds: 5));

    final state = container.read(provider);
    expect(state.status, ConversationStatus.idle);
    expect(state.messages.length, 2);
    expect(state.messages.first.author, ConversationAuthor.user);
    expect(state.messages.last.author, ConversationAuthor.miz);
    expect(state.messages.last.text, 'Sushi is a Japanese dish.');
  });

  test('a second send while a request is in flight is ignored', () async {
    var callCount = 0;
    final fake = _FakeConversationService((request) {
      callCount++;
      return const ConversationReply(text: 'ok');
    });
    final container = buildContainer(fake);
    final provider = conversationControllerProvider('');
    final notifier = container.read(provider.notifier);

    final first = notifier.send('Find sushi near me');
    final second = notifier.send('Find sushi near me again');
    await Future.wait([first, second]);

    expect(callCount, 1);
  });

  test('requiresLocation surfaces onto the controller state', () async {
    final fake = _FakeConversationService(
      (request) => const ConversationReply(text: '', requiresLocation: true),
    );
    final container = buildContainer(fake);
    final provider = conversationControllerProvider('');
    final notifier = container.read(provider.notifier);

    await notifier.send('Find a café near me');

    final state = container.read(provider);
    expect(state.requiresLocation, isTrue);
    // A requiresLocation reply has no text and no places — nothing to
    // render — so it must not become an empty message bubble. See the
    // regression test below for why this specifically matters.
    expect(state.messages, hasLength(1));
    expect(state.messages.single.author, ConversationAuthor.user);
  });

  test(
    'retrying after requiresLocation never resends an empty-text history '
    'turn (regression: this exact case caused a live INVALID_REQUEST — '
    'see docs/DECISIONS.md and supabase/functions/miz-ai/request_schema.ts)',
    () async {
      final fake = _FakeConversationService(
        (request) => const ConversationReply(text: '', requiresLocation: true),
      );
      final container = buildContainer(fake);
      final provider = conversationControllerProvider('');
      final notifier = container.read(provider.notifier);

      await notifier.send('Find sushi near me');
      await notifier.retry();

      expect(fake.requests.length, 2);
      expect(fake.requests.last.history, isEmpty);
    },
  );

  test(
    'a reply with places but empty text still becomes a message bubble '
    '(cards need somewhere to render, unlike the pure requiresLocation case)',
    () async {
      final fake = _FakeConversationService(
        (request) => const ConversationReply(
          text: '',
          places: [
            AiPlace(
              id: 'p1',
              name: 'Café Central',
              address: '',
              latitude: 1,
              longitude: 1,
            ),
          ],
        ),
      );
      final container = buildContainer(fake);
      final provider = conversationControllerProvider('');
      final notifier = container.read(provider.notifier);

      await notifier.send('Find a café near me');

      final state = container.read(provider);
      expect(state.messages, hasLength(2));
      expect(state.messages.last.places, hasLength(1));
    },
  );

  test(
    'sending a new message after requiresLocation clears the flag',
    () async {
      var shouldRequireLocation = true;
      final fake = _FakeConversationService((request) {
        final result = ConversationReply(
          text: 'ok',
          requiresLocation: shouldRequireLocation,
        );
        shouldRequireLocation = false;
        return result;
      });
      final container = buildContainer(fake);
      final provider = conversationControllerProvider('');
      final notifier = container.read(provider.notifier);

      await notifier.send('Find a café near me');
      expect(container.read(provider).requiresLocation, isTrue);

      await notifier.send('Try again with Trier selected');
      expect(container.read(provider).requiresLocation, isFalse);
    },
  );

  test('retry resends the last user message', () async {
    final fake = _FakeConversationService(
      (request) => const ConversationReply(text: 'ok'),
    );
    final container = buildContainer(fake);
    final provider = conversationControllerProvider('');
    final notifier = container.read(provider.notifier);

    await notifier.send('Find sushi near me');
    await notifier.retry();

    expect(fake.requests.length, 2);
    expect(
      fake.requests.every((r) => r.message == 'Find sushi near me'),
      isTrue,
    );
  });

  test('ConversationUnavailableException sets status to unavailable', () async {
    final throwing = _ThrowingConversationService(
      const ConversationUnavailableException(),
    );
    final container = buildContainer(throwing);
    final provider = conversationControllerProvider('');
    final notifier = container.read(provider.notifier);

    await notifier.send('Find sushi near me');

    expect(container.read(provider).status, ConversationStatus.unavailable);
  });

  test('an unexpected exception sets status to error', () async {
    final throwing = _ThrowingConversationService(Exception('boom'));
    final container = buildContainer(throwing);
    final provider = conversationControllerProvider('');
    final notifier = container.read(provider.notifier);

    await notifier.send('Find sushi near me');

    expect(container.read(provider).status, ConversationStatus.error);
  });

  test(
    'an unexpected exception (e.g. a response-parsing bug) is preserved '
    'on the state for debug-mode display instead of being discarded',
    () async {
      final throwing = _ThrowingConversationService(
        TypeError(), // stands in for a real cast failure
      );
      final container = buildContainer(throwing);
      final provider = conversationControllerProvider('');

      await container.read(provider.notifier).send('Find sushi near me');

      final state = container.read(provider);
      expect(state.status, ConversationStatus.error);
      expect(state.debugErrorCode, 'TypeError');
      expect(state.debugErrorDetail, isNotNull);
    },
  );

  test(
    'a ConversationAiException preserves its code/message for debug-mode display',
    () async {
      final throwing = _ThrowingConversationService(
        const ConversationAiException('AI_TIMEOUT', 'timed out'),
      );
      final container = buildContainer(throwing);
      final provider = conversationControllerProvider('');

      await container.read(provider.notifier).send('Find sushi near me');

      final state = container.read(provider);
      expect(state.debugErrorCode, 'AI_TIMEOUT');
      expect(state.debugErrorDetail, 'timed out');
    },
  );

  test(
    'a successful backend response that the client failed to parse '
    '(AiResponseFormatException) is never silently reported as '
    'ConversationUnavailableException, and its debug detail says why',
    () async {
      final throwing = _ThrowingConversationService(
        const AiResponseFormatException('List<dynamic>', '[1, 2, 3]'),
      );
      final container = buildContainer(throwing);
      final provider = conversationControllerProvider('');

      await container.read(provider.notifier).send('Find sushi near me');

      final state = container.read(provider);
      expect(state.status, isNot(ConversationStatus.unavailable));
      expect(state.debugErrorCode, 'AiResponseFormatException');
      expect(state.debugErrorDetail, contains('List<dynamic>'));
    },
  );

  test('ConversationUnavailableException.toString() carries its reason instead '
      'of the default "Instance of" message', () {
    const withReason = ConversationUnavailableException('network error: x');
    expect(
      withReason.toString(),
      'ConversationUnavailableException: network error: x',
    );
    expect(withReason.toString(), isNot(contains('Instance of')));
  });

  test(
    'a successful reply after a failure clears the debug error detail',
    () async {
      var shouldThrow = true;
      final fake = _FakeConversationService((request) {
        if (shouldThrow) throw const ConversationAiException('AI_TIMEOUT', 'x');
        return const ConversationReply(text: 'ok');
      });
      final container = buildContainer(fake);
      final provider = conversationControllerProvider('');
      final notifier = container.read(provider.notifier);

      try {
        await notifier.send('Find sushi near me');
      } catch (_) {}
      expect(container.read(provider).debugErrorCode, isNotNull);

      shouldThrow = false;
      await notifier.send('Find sushi near me again');

      expect(container.read(provider).debugErrorCode, isNull);
      expect(container.read(provider).debugErrorDetail, isNull);
    },
  );

  const errorStatusCases = <String, ConversationStatus>{
    'AI_TIMEOUT': ConversationStatus.timeout,
    'AI_RATE_LIMIT': ConversationStatus.rateLimited,
    'PLACES_TIMEOUT': ConversationStatus.placesUnavailable,
    'NO_RESULTS': ConversationStatus.noResults,
    'AI_UNAVAILABLE': ConversationStatus.unavailable,
    'INVALID_TOOL_ARGUMENTS': ConversationStatus.error,
  };
  for (final entry in errorStatusCases.entries) {
    test('${entry.key} maps to ${entry.value.name}', () async {
      final throwing = _ThrowingConversationService(
        ConversationAiException(entry.key, 'safe message'),
      );
      final container = buildContainer(throwing);
      final provider = conversationControllerProvider('');

      await container.read(provider.notifier).send('Find dinner');

      expect(container.read(provider).status, entry.value);
    });
  }

  test('LOCATION_REQUIRED maps to the location flow', () async {
    final throwing = _ThrowingConversationService(
      const ConversationAiException('LOCATION_REQUIRED', 'Location needed'),
    );
    final container = buildContainer(throwing);
    final provider = conversationControllerProvider('');

    await container.read(provider.notifier).send('Find pizza near me');

    expect(container.read(provider).status, ConversationStatus.idle);
    expect(container.read(provider).requiresLocation, isTrue);
  });

  test('non-retryable structured errors hide retry availability', () async {
    final throwing = _ThrowingConversationService(
      const ConversationAiException(
        'INVALID_TOOL_ARGUMENTS',
        'Invalid filters',
        retryAvailable: false,
      ),
    );
    final container = buildContainer(throwing);
    final provider = conversationControllerProvider('');

    await container.read(provider.notifier).send('Find dinner');

    expect(container.read(provider).retryAvailable, isFalse);
  });

  test(
    'history sent to the service is bounded and excludes the current message',
    () async {
      final fake = _FakeConversationService(
        (request) => const ConversationReply(text: 'ok'),
      );
      final container = buildContainer(fake);
      final provider = conversationControllerProvider('');
      final notifier = container.read(provider.notifier);

      for (var i = 0; i < 8; i++) {
        await notifier.send('message $i');
      }

      final lastRequest = fake.requests.last;
      expect(lastRequest.message, 'message 7');
      expect(lastRequest.history.any((m) => m.text == 'message 7'), isFalse);
      expect(lastRequest.history.length <= 12, isTrue);
    },
  );

  test('startNewSearch resets the conversation', () async {
    final fake = _FakeConversationService(
      (request) => const ConversationReply(text: 'ok'),
    );
    final container = buildContainer(fake);
    final provider = conversationControllerProvider('');
    final notifier = container.read(provider.notifier);

    await notifier.send('Find sushi near me');
    expect(container.read(provider).messages, isNotEmpty);

    notifier.startNewSearch();
    expect(container.read(provider).messages, isEmpty);
    expect(container.read(provider).status, ConversationStatus.idle);
  });

  test('new chat archives the current thread before resetting it', () async {
    final fake = _FakeConversationService(
      (request) => const ConversationReply(text: 'Two good options.'),
    );
    final container = buildContainer(fake);
    final provider = conversationControllerProvider('');
    final notifier = container.read(provider.notifier);

    await notifier.send('Find ramen');
    await notifier.archiveAndStartNewSearch();

    expect(container.read(provider).messages, isEmpty);
    final rows = await database.select(database.conversationArchives).get();
    expect(rows, hasLength(1));
    expect(rows.single.title, 'Find ramen');
    expect(rows.single.messagesJson, contains('Two good options.'));
  });
}
