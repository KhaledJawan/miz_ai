import 'dart:math' as math;

import '../domain/city_coordinates.dart';
import '../domain/location_service.dart';
import 'device_location_gateway.dart';

/// Resolves the device position to the nearest city Miz currently supports.
/// Coordinates are used only for this in-memory calculation and are discarded.
class DeviceLocationService implements LocationService {
  const DeviceLocationService({
    this.gateway = const GeolocatorDeviceLocationGateway(),
  });

  final DeviceLocationGateway gateway;

  static const _maximumServiceDistanceKm = 120.0;

  @override
  Future<LocationLookupResult> resolveApproximateCity() async {
    try {
      if (!await gateway.isServiceEnabled()) {
        return const LocationLookupResult.unavailable();
      }

      var permission = await gateway.checkPermission();
      if (permission == DeviceLocationPermission.denied) {
        permission = await gateway.requestPermission();
      }
      if (permission != DeviceLocationPermission.allowed) {
        return const LocationLookupResult.denied();
      }

      final position = await gateway.currentPosition();
      String? nearestCity;
      var nearestDistanceKm = double.infinity;
      for (final city in kSupportedCityCoordinates) {
        final distance = _distanceKm(
          position,
          DevicePosition(latitude: city.latitude, longitude: city.longitude),
        );
        if (distance < nearestDistanceKm) {
          nearestDistanceKm = distance;
          nearestCity = city.name;
        }
      }

      if (nearestCity == null ||
          nearestDistanceKm > _maximumServiceDistanceKm) {
        return const LocationLookupResult.unavailable();
      }
      return LocationLookupResult.resolved(nearestCity);
    } on Exception {
      return const LocationLookupResult.unavailable();
    }
  }

  double _distanceKm(DevicePosition first, DevicePosition second) {
    const earthRadiusKm = 6371.0;
    final latitudeDelta = _radians(second.latitude - first.latitude);
    final longitudeDelta = _radians(second.longitude - first.longitude);
    final firstLatitude = _radians(first.latitude);
    final secondLatitude = _radians(second.latitude);
    final haversine =
        math.sin(latitudeDelta / 2) * math.sin(latitudeDelta / 2) +
        math.cos(firstLatitude) *
            math.cos(secondLatitude) *
            math.sin(longitudeDelta / 2) *
            math.sin(longitudeDelta / 2);
    return earthRadiusKm *
        2 *
        math.atan2(math.sqrt(haversine), math.sqrt(1 - haversine));
  }

  double _radians(double degrees) => degrees * math.pi / 180;
}
