import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/features/camera/data/supabase_camera_analysis_service.dart';
import 'package:miz_ai/features/camera/domain/camera_models.dart';
import 'package:miz_ai/features/camera/domain/camera_services.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class _MockFunctionsClient extends Mock implements FunctionsClient {}

void main() {
  late Directory temporaryDirectory;
  late _MockFunctionsClient functionsClient;
  late SupabaseCameraAnalysisService service;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'miz-menu-analysis-',
    );
    functionsClient = _MockFunctionsClient();
    service = SupabaseCameraAnalysisService(functionsClient: functionsClient);
  });

  tearDown(() => temporaryDirectory.delete(recursive: true));

  test('sends a bounded encoded image and parses typed analysis', () async {
    final image = File('${temporaryDirectory.path}/menu.jpg');
    await image.writeAsBytes([0xff, 0xd8, 0xff, 0xd9]);
    Map<String, dynamic>? capturedBody;
    when(
      () => functionsClient.invoke(any(), body: any(named: 'body')),
    ).thenAnswer((invocation) async {
      capturedBody = invocation.namedArguments[#body] as Map<String, dynamic>;
      return const FunctionResponse(
        data: {
          'success': true,
          'analysis': {
            'readable': true,
            'detectedLanguage': 'German',
            'currency': 'EUR',
            'categories': [
              {
                'name': 'Mains',
                'dishes': [
                  {
                    'extractedName': 'Pasta',
                    'price': 12.0,
                    'priceIndicator': 'good',
                    'matchedFoodId': 'food-1',
                    'matchedName': 'Pasta al Pomodoro',
                    'shortDescription': 'Pasta with tomato sauce.',
                    'imagePath': null,
                    'matchConfidence': 0.9,
                    'safetyStatus': 'safe',
                    'safetyReasons': <Map<String, dynamic>>[],
                    'safetyCertain': true,
                  },
                ],
              },
            ],
            'notes': <String>[],
          },
        },
        status: 200,
      );
    });

    final result = await service.analyzeMenu([
      TemporaryCapture(
        id: '1',
        path: image.path,
        createdAt: DateTime(2026),
        mimeType: 'image/jpeg',
      ),
    ], locale: 'de');

    expect(capturedBody?['locale'], 'de');
    expect(capturedBody?['images'], hasLength(1));
    expect(result.dishCount, 1);
    expect(
      result.categories.single.dishes.single.safetyStatus,
      DishSafetyStatus.safe,
    );
  });

  test('rejects an unavailable image before making a network call', () async {
    await expectLater(
      () => service.analyzeMenu([
        TemporaryCapture(
          id: 'missing',
          path: '${temporaryDirectory.path}/missing.jpg',
          createdAt: DateTime(2026),
          mimeType: 'image/jpeg',
        ),
      ], locale: 'en'),
      throwsA(
        isA<MenuAnalysisException>().having(
          (error) => error.code,
          'code',
          'IMAGE_UNAVAILABLE',
        ),
      ),
    );
    verifyNever(() => functionsClient.invoke(any(), body: any(named: 'body')));
  });

  test('sends one food image and parses typed candidates', () async {
    final image = File('${temporaryDirectory.path}/food.jpg');
    await image.writeAsBytes([0xff, 0xd8, 0xff, 0xd9]);
    Map<String, dynamic>? capturedBody;
    when(
      () => functionsClient.invoke(any(), body: any(named: 'body')),
    ).thenAnswer((invocation) async {
      capturedBody = invocation.namedArguments[#body] as Map<String, dynamic>;
      return const FunctionResponse(
        data: {
          'success': true,
          'analysis': {
            'recognized': true,
            'overview': 'A baked Italian flatbread.',
            'candidates': [
              {
                'name': 'Pizza Margherita',
                'description': 'Pizza with tomato, cheese, and basil.',
                'confidence': 0.9,
              },
            ],
          },
        },
        status: 200,
      );
    });

    final result = await service.recognizeFood(
      TemporaryCapture(
        id: 'food-1',
        path: image.path,
        createdAt: DateTime(2026),
        mimeType: 'image/jpeg',
      ),
      locale: 'en',
    );

    expect(capturedBody?['locale'], 'en');
    expect(capturedBody?['image'], isA<Map>());
    expect(result.recognized, isTrue);
    expect(result.candidates.single.name, 'Pizza Margherita');
  });

  test('classifies a capture and maps the wire kind to CaptureKind', () async {
    final image = File('${temporaryDirectory.path}/capture.jpg');
    await image.writeAsBytes([0xff, 0xd8, 0xff, 0xd9]);
    Map<String, dynamic>? capturedBody;
    String? capturedFunctionName;
    when(
      () => functionsClient.invoke(any(), body: any(named: 'body')),
    ).thenAnswer((invocation) async {
      capturedFunctionName = invocation.positionalArguments.first as String;
      capturedBody = invocation.namedArguments[#body] as Map<String, dynamic>;
      return const FunctionResponse(
        data: {
          'success': true,
          'result': {'kind': 'menu'},
        },
        status: 200,
      );
    });

    final kind = await service.classifyCapture(
      TemporaryCapture(
        id: 'capture-1',
        path: image.path,
        createdAt: DateTime(2026),
        mimeType: 'image/jpeg',
      ),
      locale: 'en',
    );

    expect(capturedFunctionName, 'classify-capture');
    expect(capturedBody?['locale'], 'en');
    expect(kind, CaptureKind.menu);
  });

  test('an unknown classify kind falls back to unrecognized rather than throwing', () async {
    final image = File('${temporaryDirectory.path}/capture2.jpg');
    await image.writeAsBytes([0xff, 0xd8, 0xff, 0xd9]);
    when(
      () => functionsClient.invoke(any(), body: any(named: 'body')),
    ).thenAnswer(
      (_) async => const FunctionResponse(
        data: {
          'success': true,
          'result': {'kind': 'something_new'},
        },
        status: 200,
      ),
    );

    final kind = await service.classifyCapture(
      TemporaryCapture(
        id: 'capture-2',
        path: image.path,
        createdAt: DateTime(2026),
        mimeType: 'image/jpeg',
      ),
      locale: 'en',
    );

    expect(kind, CaptureKind.unrecognized);
  });
}
