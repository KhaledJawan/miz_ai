import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final configPath = arguments.isEmpty ? '.env.json' : arguments.single;
  final configFile = File(configPath);

  if (!configFile.existsSync()) {
    _fail(
      'Missing $configPath. Copy .env.example.json to .env.json and add '
      'the new project values.',
    );
  }

  final Object? decoded;
  try {
    decoded = jsonDecode(await configFile.readAsString());
  } on FormatException {
    _fail('$configPath is not valid JSON.');
  }

  if (decoded is! Map<String, dynamic>) {
    _fail('$configPath must contain one JSON object.');
  }

  final urlValue = decoded['SUPABASE_URL'];
  final keyValue =
      decoded['SUPABASE_PUBLISHABLE_KEY'] ?? decoded['SUPABASE_ANON_KEY'];
  if (urlValue is! String || urlValue.trim().isEmpty) {
    _fail('SUPABASE_URL is missing.');
  }
  if (keyValue is! String || keyValue.trim().isEmpty) {
    _fail('SUPABASE_PUBLISHABLE_KEY is missing.');
  }

  final projectUri = Uri.tryParse(urlValue.trim());
  if (projectUri == null ||
      projectUri.scheme != 'https' ||
      projectUri.host.isEmpty) {
    _fail('SUPABASE_URL must be a valid HTTPS URL.');
  }

  final client = HttpClient()..connectionTimeout = const Duration(seconds: 10);
  try {
    final settingsUri = projectUri.resolve('/auth/v1/settings');
    final request = await client.getUrl(settingsUri);
    request.headers.set('apikey', keyValue.trim());
    final response = await request.close().timeout(const Duration(seconds: 15));
    await response.drain<void>();

    if (response.statusCode != HttpStatus.ok) {
      _fail(
        'Supabase rejected the configuration with HTTP '
        '${response.statusCode}. Re-copy the Project URL and publishable key.',
      );
    }

    stdout.writeln(
      'Supabase configuration is valid for ${projectUri.host}. '
      'The key value was not printed.',
    );
  } on SocketException catch (error) {
    _fail('Could not reach ${projectUri.host}: ${error.message}');
  } on TimeoutException {
    _fail('Timed out while connecting to ${projectUri.host}.');
  } finally {
    client.close(force: true);
  }
}

Never _fail(String message) {
  stderr.writeln(message);
  exitCode = 1;
  throw const _ConfigurationFailure();
}

final class _ConfigurationFailure implements Exception {
  const _ConfigurationFailure();
}
