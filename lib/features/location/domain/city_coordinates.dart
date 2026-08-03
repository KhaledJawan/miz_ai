/// The fixed set of cities Miz currently serves, with their center
/// coordinates. This is the single source of truth `DeviceLocationService`
/// uses to snap a device position to the nearest supported city, and that
/// the AI chat feature uses to attach a `selectedCity` (name + coordinates)
/// to a request — see `docs/API.md`. `CitySelection`/`LocationService`
/// remain string-only in their own public contract; this lookup is
/// additive and does not change either.
class CityCoordinates {
  const CityCoordinates({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final double latitude;
  final double longitude;
}

const List<CityCoordinates> kSupportedCityCoordinates = [
  CityCoordinates(name: 'Trier', latitude: 49.74999, longitude: 6.63714),
  CityCoordinates(name: 'Berlin', latitude: 52.52, longitude: 13.405),
  CityCoordinates(name: 'Hamburg', latitude: 53.5511, longitude: 9.9937),
  CityCoordinates(name: 'Munich', latitude: 48.1351, longitude: 11.582),
  CityCoordinates(name: 'Frankfurt', latitude: 50.1109, longitude: 8.6821),
  CityCoordinates(name: 'Cologne', latitude: 50.9375, longitude: 6.9603),
  CityCoordinates(name: 'Düsseldorf', latitude: 51.2277, longitude: 6.7735),
];

/// Looks up known coordinates for a city name (case-sensitive, matching
/// the exact labels in [kSupportedCityCoordinates]). Returns `null` for a
/// name outside the currently supported set.
CityCoordinates? coordinatesForCity(String name) {
  for (final city in kSupportedCityCoordinates) {
    if (city.name == name) return city;
  }
  return null;
}
