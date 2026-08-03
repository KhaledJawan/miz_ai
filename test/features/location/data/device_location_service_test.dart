import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/features/location/data/device_location_gateway.dart';
import 'package:miz_ai/features/location/data/device_location_service.dart';
import 'package:miz_ai/features/location/domain/location_service.dart';

void main() {
  group('DeviceLocationService', () {
    test(
      'requests permission and resolves the nearest supported city',
      () async {
        final gateway = _FakeGateway(
          checkedPermission: DeviceLocationPermission.denied,
          requestedPermission: DeviceLocationPermission.allowed,
          position: const DevicePosition(latitude: 49.756, longitude: 6.641),
        );

        final result = await DeviceLocationService(
          gateway: gateway,
        ).resolveApproximateCity();

        expect(result.status, LocationLookupStatus.resolved);
        expect(result.city, 'Trier');
        expect(gateway.didRequestPermission, isTrue);
      },
    );

    test('returns denied when permission is permanently denied', () async {
      final gateway = _FakeGateway(
        checkedPermission: DeviceLocationPermission.deniedForever,
      );

      final result = await DeviceLocationService(
        gateway: gateway,
      ).resolveApproximateCity();

      expect(result.status, LocationLookupStatus.denied);
      expect(gateway.didReadPosition, isFalse);
    });

    test('returns unavailable when device location is disabled', () async {
      final gateway = _FakeGateway(serviceEnabled: false);

      final result = await DeviceLocationService(
        gateway: gateway,
      ).resolveApproximateCity();

      expect(result.status, LocationLookupStatus.unavailable);
      expect(gateway.didRequestPermission, isFalse);
    });

    test('does not select a distant unsupported service area', () async {
      final gateway = _FakeGateway(
        position: const DevicePosition(latitude: 48.7758, longitude: 9.1829),
      );

      final result = await DeviceLocationService(
        gateway: gateway,
      ).resolveApproximateCity();

      expect(result.status, LocationLookupStatus.unavailable);
    });
  });
}

class _FakeGateway implements DeviceLocationGateway {
  _FakeGateway({
    this.serviceEnabled = true,
    this.checkedPermission = DeviceLocationPermission.allowed,
    this.requestedPermission = DeviceLocationPermission.allowed,
    this.position = const DevicePosition(latitude: 52.52, longitude: 13.405),
  });

  final bool serviceEnabled;
  final DeviceLocationPermission checkedPermission;
  final DeviceLocationPermission requestedPermission;
  final DevicePosition position;
  bool didRequestPermission = false;
  bool didReadPosition = false;

  @override
  Future<DeviceLocationPermission> checkPermission() async => checkedPermission;

  @override
  Future<DevicePosition> currentPosition() async {
    didReadPosition = true;
    return position;
  }

  @override
  Future<bool> isServiceEnabled() async => serviceEnabled;

  @override
  Future<DeviceLocationPermission> requestPermission() async {
    didRequestPermission = true;
    return requestedPermission;
  }
}
