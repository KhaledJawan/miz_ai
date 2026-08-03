import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/features/camera/domain/camera_services.dart';
import 'package:miz_ai/features/camera/domain/miz_qr_validator.dart';

void main() {
  const validator = MizQrValidator();
  final now = DateTime.utc(2026, 8, 2, 10);

  test('rejects arbitrary and malformed QR content', () {
    expect(
      validator.validate('https://evil.example/table/1', now: now).status,
      MizQrValidationStatus.invalid,
    );
    expect(
      validator.validate('miz://v1/table/short?exp=1&sig=x', now: now).status,
      MizQrValidationStatus.invalid,
    );
  });

  test('rejects expired Miz QR payloads', () {
    const token = 'public_token_12345';
    const signature = 'abcdefghijklmnopqrstuvwxyzABCDEFG_123456';
    final expired = now.subtract(const Duration(minutes: 1));
    final raw =
        'miz://v1/table/$token?exp=${expired.millisecondsSinceEpoch ~/ 1000}&sig=$signature';
    expect(
      validator.validate(raw, now: now).status,
      MizQrValidationStatus.expired,
    );
  });

  test('valid format still requires trusted network verification', () {
    const token = 'public_token_12345';
    const signature = 'abcdefghijklmnopqrstuvwxyzABCDEFG_123456';
    final future = now.add(const Duration(minutes: 10));
    final raw =
        'miz://v1/restaurant/$token?exp=${future.millisecondsSinceEpoch ~/ 1000}&sig=$signature';
    final result = validator.validate(raw, now: now);
    expect(result.status, MizQrValidationStatus.requiresNetworkVerification);
    expect(result.payload?.publicToken, token);
  });
}
