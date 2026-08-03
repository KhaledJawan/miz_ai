import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/device_location_service.dart';
import '../../domain/city_selection.dart';
import '../../domain/location_service.dart';

part 'city_controller.g.dart';

const supportedCities = [
  'Trier',
  'Berlin',
  'Hamburg',
  'Munich',
  'Frankfurt',
  'Cologne',
  'Düsseldorf',
];

const _selectedCityKey = 'spatial.selected_city';
const _defaultCityKey = 'spatial.default_city';
const _recentCitiesKey = 'spatial.recent_cities';

@riverpod
LocationService locationService(LocationServiceRef ref) =>
    const DeviceLocationService();

@Riverpod(keepAlive: true)
class CityController extends _$CityController {
  late final SharedPreferences _preferences;

  @override
  Future<CitySelection> build() async {
    _preferences = await SharedPreferences.getInstance();
    final selected = _preferences.getString(_selectedCityKey);
    final defaultCity = _preferences.getString(_defaultCityKey);
    final recent = _preferences.getStringList(_recentCitiesKey) ?? const [];
    return CitySelection(
      selectedCity: selected ?? defaultCity,
      defaultCity: defaultCity,
      recentCities: recent.where(supportedCities.contains).take(5).toList(),
    );
  }

  Future<void> selectCity(String city) async {
    if (!supportedCities.contains(city)) return;
    final current = state.valueOrNull ?? const CitySelection();
    final recent = [
      city,
      ...current.recentCities.where((item) => item != city),
    ].take(5).toList();
    state = AsyncData(
      current.copyWith(
        selectedCity: city,
        recentCities: recent,
        capabilityState: LocationCapabilityState.idle,
      ),
    );
    await _preferences.setString(_selectedCityKey, city);
    await _preferences.setStringList(_recentCitiesKey, recent);
  }

  Future<void> useCurrentLocation() async {
    final current = state.valueOrNull ?? const CitySelection();
    state = AsyncData(
      current.copyWith(capabilityState: LocationCapabilityState.requesting),
    );
    final result = await ref
        .read(locationServiceProvider)
        .resolveApproximateCity();
    switch (result.status) {
      case LocationLookupStatus.resolved:
        final city = result.city;
        if (city != null && supportedCities.contains(city)) {
          await selectCity(city);
        } else {
          state = AsyncData(
            current.copyWith(
              capabilityState: LocationCapabilityState.unavailable,
            ),
          );
        }
        return;
      case LocationLookupStatus.denied:
        state = AsyncData(
          current.copyWith(capabilityState: LocationCapabilityState.denied),
        );
        return;
      case LocationLookupStatus.unavailable:
        state = AsyncData(
          current.copyWith(
            capabilityState: LocationCapabilityState.unavailable,
          ),
        );
        return;
    }
  }

  Future<void> setSelectedAsDefault(bool value) async {
    final current = state.valueOrNull ?? const CitySelection();
    if (!value) {
      state = AsyncData(current.copyWith(clearDefaultCity: true));
      await _preferences.remove(_defaultCityKey);
      return;
    }
    final selected = current.selectedCity;
    if (selected == null) return;
    state = AsyncData(current.copyWith(defaultCity: selected));
    await _preferences.setString(_defaultCityKey, selected);
  }

  Future<void> clearSelection() async {
    final current = state.valueOrNull ?? const CitySelection();
    state = AsyncData(
      current.copyWith(
        clearSelectedCity: true,
        clearDefaultCity: true,
        capabilityState: LocationCapabilityState.idle,
      ),
    );
    await _preferences.remove(_selectedCityKey);
    await _preferences.remove(_defaultCityKey);
  }
}
