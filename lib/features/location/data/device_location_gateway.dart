import 'package:geolocator/geolocator.dart';

enum DeviceLocationPermission { denied, deniedForever, allowed }

class DevicePosition {
  const DevicePosition({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}

abstract interface class DeviceLocationGateway {
  Future<bool> isServiceEnabled();

  Future<DeviceLocationPermission> checkPermission();

  Future<DeviceLocationPermission> requestPermission();

  Future<DevicePosition> currentPosition();
}

class GeolocatorDeviceLocationGateway implements DeviceLocationGateway {
  const GeolocatorDeviceLocationGateway();

  @override
  Future<bool> isServiceEnabled() => Geolocator.isLocationServiceEnabled();

  @override
  Future<DeviceLocationPermission> checkPermission() async =>
      _mapPermission(await Geolocator.checkPermission());

  @override
  Future<DeviceLocationPermission> requestPermission() async =>
      _mapPermission(await Geolocator.requestPermission());

  @override
  Future<DevicePosition> currentPosition() async {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.low,
        timeLimit: Duration(seconds: 15),
      ),
    );
    return DevicePosition(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  DeviceLocationPermission _mapPermission(LocationPermission permission) {
    return switch (permission) {
      LocationPermission.denied => DeviceLocationPermission.denied,
      LocationPermission.deniedForever =>
        DeviceLocationPermission.deniedForever,
      LocationPermission.whileInUse ||
      LocationPermission.always => DeviceLocationPermission.allowed,
      LocationPermission.unableToDetermine => DeviceLocationPermission.denied,
    };
  }
}
