/// Build-time configuration supplied with `--dart-define` or
/// `--dart-define-from-file`.
final class AppConfig {
  const AppConfig._({this.supabase});

  final SupabaseConfig? supabase;

  factory AppConfig.fromEnvironment() {
    const url = String.fromEnvironment('SUPABASE_URL');
    const publishableKey = String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');
    const legacyAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

    return AppConfig.fromValues(
      supabaseUrl: url,
      supabasePublishableKey: publishableKey.isNotEmpty
          ? publishableKey
          : legacyAnonKey,
    );
  }

  factory AppConfig.fromValues({
    required String supabaseUrl,
    required String supabasePublishableKey,
  }) {
    final hasUrl = supabaseUrl.trim().isNotEmpty;
    final hasKey = supabasePublishableKey.trim().isNotEmpty;

    if (!hasUrl && !hasKey) {
      return const AppConfig._();
    }
    if (!hasUrl || !hasKey) {
      throw const FormatException(
        'SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY must be provided together.',
      );
    }

    final uri = Uri.tryParse(supabaseUrl.trim());
    if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
      throw const FormatException('SUPABASE_URL must be a valid HTTPS URL.');
    }

    return AppConfig._(
      supabase: SupabaseConfig(
        url: uri,
        publishableKey: supabasePublishableKey.trim(),
      ),
    );
  }
}

final class SupabaseConfig {
  const SupabaseConfig({required this.url, required this.publishableKey});

  final Uri url;
  final String publishableKey;
}
