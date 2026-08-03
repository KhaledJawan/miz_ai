import 'device_location_gateway.dart';

/// Reads the device's current coordinates for a single AI chat request,
/// only when location is already enabled and permission already granted.
/// Never prompts for permission and never persists the result — see
/// docs/SECURITY.md's existing commitment that precise coordinates are
/// used transiently and discarded, extended here to the AI feature rather
/// than relaxed for it.
class TransientPositionReader {
  const TransientPositionReader({
    this.gateway = const GeolocatorDeviceLocationGateway(),
  });

  final DeviceLocationGateway gateway;

  Future<DevicePosition?> currentPositionIfAlreadyGranted() async {
    try {
      if (!await gateway.isServiceEnabled()) return null;
      final permission = await gateway.checkPermission();
      if (permission != DeviceLocationPermission.allowed) return null;
      return await gateway.currentPosition();
    } on Exception {
      return null;
    }
  }
}
