import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/features/conversation/data/miz_ai_service.dart';
import 'package:miz_ai/features/conversation/domain/conversation_models.dart';
import 'package:miz_ai/features/conversation/domain/conversation_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockFunctionsClient extends Mock implements FunctionsClient {}

void main() {
  late MockFunctionsClient functionsClient;
  late MizAiService service;

  setUpAll(() {
    registerFallbackValue(HttpMethod.post);
  });

  setUp(() {
    functionsClient = MockFunctionsClient();
    service = MizAiService(functionsClient: functionsClient);
  });

  ConversationRequest baseRequest({
    List<ConversationMessage> history = const [],
    ConversationLocation? location,
    ConversationCity? selectedCity,
    Map<String, dynamic>? foodProfileContext,
    String? conversationId,
  }) => ConversationRequest(
    message: 'Find a quiet café',
    locale: 'en',
    conversationId: conversationId,
    history: history,
    location: location,
    selectedCity: selectedCity,
    foodProfileContext: foodProfileContext,
  );

  void stubInvoke(Object? data, {int status = 200}) {
    when(
      () => functionsClient.invoke(any(), body: any(named: 'body')),
    ).thenAnswer((_) async => FunctionResponse(data: data, status: status));
  }

  test(
    'sends message, locale, and omits optional fields when absent',
    () async {
      Map<String, dynamic>? capturedBody;
      when(
        () => functionsClient.invoke(any(), body: any(named: 'body')),
      ).thenAnswer((invocation) async {
        capturedBody = invocation.namedArguments[#body] as Map<String, dynamic>;
        return const FunctionResponse(
          data: {'message': 'ok', 'places': [], 'toolExecutions': []},
          status: 200,
        );
      });

      await service.respond(baseRequest());

      expect(capturedBody!['message'], 'Find a quiet café');
      expect(capturedBody!['locale'], 'en');
      expect(capturedBody!['history'], isEmpty);
      expect(capturedBody!.containsKey('location'), isFalse);
      expect(capturedBody!.containsKey('selectedCity'), isFalse);
      expect(capturedBody!.containsKey('foodProfileContext'), isFalse);
    },
  );

  test('maps ConversationAuthor to role strings in history', () async {
    Map<String, dynamic>? capturedBody;
    when(
      () => functionsClient.invoke(any(), body: any(named: 'body')),
    ).thenAnswer((invocation) async {
      capturedBody = invocation.namedArguments[#body] as Map<String, dynamic>;
      return const FunctionResponse(data: {'message': 'ok'}, status: 200);
    });

    await service.respond(
      baseRequest(
        history: const [
          ConversationMessage(
            id: '1',
            author: ConversationAuthor.user,
            text: 'hi',
          ),
          ConversationMessage(
            id: '2',
            author: ConversationAuthor.miz,
            text: 'hello',
          ),
        ],
      ),
    );

    expect(capturedBody!['history'], [
      {'role': 'user', 'text': 'hi'},
      {'role': 'assistant', 'text': 'hello'},
    ]);
  });

  test(
    'includes location, selectedCity, and foodProfileContext when present',
    () async {
      Map<String, dynamic>? capturedBody;
      when(
        () => functionsClient.invoke(any(), body: any(named: 'body')),
      ).thenAnswer((invocation) async {
        capturedBody = invocation.namedArguments[#body] as Map<String, dynamic>;
        return const FunctionResponse(data: {'message': 'ok'}, status: 200);
      });

      await service.respond(
        baseRequest(
          location: const ConversationLocation(
            latitude: 49.75,
            longitude: 6.64,
            accuracyMeters: 50,
          ),
          selectedCity: const ConversationCity(
            name: 'Trier',
            latitude: 49.75,
            longitude: 6.64,
          ),
          foodProfileContext: const {'dietType': 'vegan'},
        ),
      );

      expect(capturedBody!['location'], {
        'latitude': 49.75,
        'longitude': 6.64,
        'accuracyMeters': 50,
      });
      expect(capturedBody!['selectedCity'], {
        'name': 'Trier',
        'latitude': 49.75,
        'longitude': 6.64,
      });
      expect(capturedBody!['foodProfileContext'], {'dietType': 'vegan'});
    },
  );

  test(
    'parses a successful reply including places and toolExecutions',
    () async {
      stubInvoke({
        'message': 'Here are some cafés.',
        'conversationId': 'conv-1',
        'places': [
          {
            'id': 'places/1',
            'name': 'Café Central',
            'address': 'Hauptstraße 1',
            'latitude': 49.75,
            'longitude': 6.64,
            'rating': 4.5,
            'reviewCount': 100,
            'openNow': true,
            'primaryType': 'cafe',
            'types': ['cafe'],
            'distanceMeters': 250,
          },
        ],
        'toolExecutions': [
          {'name': 'search_nearby_places', 'status': 'success'},
        ],
        'requiresLocation': false,
        'requiresClarification': false,
        'clarificationQuestion': null,
      });

      final reply = await service.respond(baseRequest());

      expect(reply.text, 'Here are some cafés.');
      expect(reply.conversationId, 'conv-1');
      expect(reply.places, hasLength(1));
      expect(reply.places.first.name, 'Café Central');
      expect(reply.places.first.rating, 4.5);
      expect(reply.toolExecutions, hasLength(1));
      expect(reply.toolExecutions.first.name, 'search_nearby_places');
      expect(reply.toolExecutions.first.status, 'success');
      expect(reply.requiresLocation, isFalse);
    },
  );

  test('parses requiresLocation without needing places', () async {
    stubInvoke({'message': '', 'requiresLocation': true});
    final reply = await service.respond(baseRequest());
    expect(reply.requiresLocation, isTrue);
    expect(reply.places, isEmpty);
  });

  test(
    'throws AiResponseFormatException when the response body is unparseable text',
    () async {
      stubInvoke('not-a-map');
      await expectLater(
        () => service.respond(baseRequest()),
        throwsA(isA<AiResponseFormatException>()),
      );
    },
  );

  test(
    'throws AiResponseFormatException (not ConversationUnavailableException) '
    'for a non-map, non-string body',
    () async {
      stubInvoke(<int>[1, 2, 3]);
      await expectLater(
        () => service.respond(baseRequest()),
        throwsA(isA<AiResponseFormatException>()),
      );
    },
  );

  test(
    'recovers a JSON body delivered as a raw string (e.g. a proxy rewrote '
    'Content-Type away from application/json) instead of discarding it',
    () async {
      stubInvoke(
        '{"message": "Here you go.", "places": [], "toolExecutions": []}',
      );
      final reply = await service.respond(baseRequest());
      expect(reply.text, 'Here you go.');
    },
  );

  test('a network-level SocketException carries its detail on '
      'ConversationUnavailableException.reason', () async {
    when(
      () => functionsClient.invoke(any(), body: any(named: 'body')),
    ).thenThrow(const SocketException('connection reset'));

    try {
      await service.respond(baseRequest());
      fail('expected ConversationUnavailableException');
    } on ConversationUnavailableException catch (error) {
      expect(error.reason, contains('connection reset'));
      expect(error.toString(), contains('connection reset'));
    }
  });

  test(
    'maps a FunctionException with a structured error body to ConversationAiException',
    () async {
      when(
        () => functionsClient.invoke(any(), body: any(named: 'body')),
      ).thenThrow(
        const FunctionException(
          status: 429,
          details: {
            'error': {
              'code': 'AI_QUOTA_EXCEEDED',
              'message': 'The assistant is busy right now.',
            },
          },
        ),
      );

      try {
        await service.respond(baseRequest());
        fail('expected ConversationAiException');
      } on ConversationAiException catch (error) {
        expect(error.code, 'AI_QUOTA_EXCEEDED');
        expect(error.message, 'The assistant is busy right now.');
      }
    },
  );

  test(
    'maps a FunctionException with an unparseable body to a generic SERVER_ERROR',
    () async {
      when(
        () => functionsClient.invoke(any(), body: any(named: 'body')),
      ).thenThrow(
        const FunctionException(status: 500, details: 'raw text, not json'),
      );

      try {
        await service.respond(baseRequest());
        fail('expected ConversationAiException');
      } on ConversationAiException catch (error) {
        expect(error.code, 'SERVER_ERROR');
      }
    },
  );

  test('maps a TimeoutException to AI_TIMEOUT', () async {
    when(
      () => functionsClient.invoke(any(), body: any(named: 'body')),
    ).thenThrow(TimeoutException('too slow'));

    try {
      await service.respond(baseRequest());
      fail('expected ConversationAiException');
    } on ConversationAiException catch (error) {
      expect(error.code, 'AI_TIMEOUT');
    }
  });

  test('maps the production structured error contract', () async {
    stubInvoke({
      'success': false,
      'errorCode': 'PLACES_TIMEOUT',
      'userMessage': 'Place search took too long. Please try again.',
      'retryAvailable': false,
      'technicalMessage': null,
    });

    try {
      await service.respond(baseRequest());
      fail('expected ConversationAiException');
    } on ConversationAiException catch (error) {
      expect(error.code, 'PLACES_TIMEOUT');
      expect(error.message, 'Place search took too long. Please try again.');
      expect(error.retryAvailable, isFalse);
    }
  });
}
