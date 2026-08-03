import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/core/config/app_config.dart';

void main() {
  group('AppConfig', () {
    test('keeps Supabase disabled when both values are absent', () {
      final config = AppConfig.fromValues(
        supabaseUrl: '',
        supabasePublishableKey: '',
      );

      expect(config.supabase, isNull);
    });

    test('creates a validated Supabase configuration', () {
      final config = AppConfig.fromValues(
        supabaseUrl: 'https://example.supabase.co',
        supabasePublishableKey: 'public-test-key',
      );

      expect(config.supabase?.url.host, 'example.supabase.co');
      expect(config.supabase?.publishableKey, 'public-test-key');
    });

    test('rejects a partially configured Supabase project', () {
      expect(
        () => AppConfig.fromValues(
          supabaseUrl: 'https://example.supabase.co',
          supabasePublishableKey: '',
        ),
        throwsFormatException,
      );
    });

    test('rejects a non-HTTPS Supabase URL', () {
      expect(
        () => AppConfig.fromValues(
          supabaseUrl: 'http://example.supabase.co',
          supabasePublishableKey: 'public-test-key',
        ),
        throwsFormatException,
      );
    });
  });
}
