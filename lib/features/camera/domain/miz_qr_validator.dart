import 'camera_services.dart';

class MizQrValidator {
  const MizQrValidator();

  MizQrValidationResult validate(String raw, {DateTime? now}) {
    if (raw.isEmpty || raw.length > 1024) {
      return const MizQrValidationResult(MizQrValidationStatus.invalid);
    }
    final uri = Uri.tryParse(raw);
    if (uri == null ||
        uri.scheme != 'miz' ||
        uri.host != 'v1' ||
        uri.pathSegments.length != 2 ||
        !const {'restaurant', 'table'}.contains(uri.pathSegments.first)) {
      return const MizQrValidationResult(MizQrValidationStatus.invalid);
    }
    final token = uri.pathSegments[1];
    final expiresRaw = uri.queryParameters['exp'];
    final signature = uri.queryParameters['sig'];
    final expiresSeconds = int.tryParse(expiresRaw ?? '');
    final safeToken = RegExp(r'^[A-Za-z0-9_-]{12,128}$');
    final safeSignature = RegExp(r'^[A-Za-z0-9_-]{32,256}$');
    if (!safeToken.hasMatch(token) ||
        expiresSeconds == null ||
        signature == null ||
        !safeSignature.hasMatch(signature)) {
      return const MizQrValidationResult(MizQrValidationStatus.invalid);
    }
    final expiresAt = DateTime.fromMillisecondsSinceEpoch(
      expiresSeconds * 1000,
      isUtc: true,
    );
    if (!expiresAt.isAfter((now ?? DateTime.now()).toUtc())) {
      return const MizQrValidationResult(MizQrValidationStatus.expired);
    }
    return MizQrValidationResult(
      MizQrValidationStatus.requiresNetworkVerification,
      payload: MizQrPayload(
        scope: uri.pathSegments.first,
        publicToken: token,
        expiresAt: expiresAt,
        signature: signature,
      ),
    );
  }
}
