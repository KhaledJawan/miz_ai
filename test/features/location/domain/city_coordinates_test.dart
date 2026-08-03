import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/features/location/domain/city_coordinates.dart';
import 'package:miz_ai/features/location/presentation/providers/city_controller.dart'
    show supportedCities;

void main() {
  group('coordinatesForCity', () {
    test('resolves every currently supported city name', () {
      for (final city in supportedCities) {
        expect(
          coordinatesForCity(city),
          isNotNull,
          reason: 'missing coordinates for $city',
        );
      }
    });

    test('returns the expected coordinates for Trier', () {
      final trier = coordinatesForCity('Trier');
      expect(trier?.latitude, closeTo(49.74999, 0.0001));
      expect(trier?.longitude, closeTo(6.63714, 0.0001));
    });

    test('returns null for an unsupported city name', () {
      expect(coordinatesForCity('Paris'), isNull);
    });

    test('kSupportedCityCoordinates has no duplicate names', () {
      final names = kSupportedCityCoordinates.map((c) => c.name).toList();
      expect(names.toSet().length, names.length);
    });
  });
}
