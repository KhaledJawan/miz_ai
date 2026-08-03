enum LocationCapabilityState { idle, requesting, denied, unavailable }

class CitySelection {
  const CitySelection({
    this.selectedCity,
    this.defaultCity,
    this.recentCities = const [],
    this.capabilityState = LocationCapabilityState.idle,
  });

  final String? selectedCity;
  final String? defaultCity;
  final List<String> recentCities;
  final LocationCapabilityState capabilityState;

  CitySelection copyWith({
    String? selectedCity,
    bool clearSelectedCity = false,
    String? defaultCity,
    bool clearDefaultCity = false,
    List<String>? recentCities,
    LocationCapabilityState? capabilityState,
  }) {
    return CitySelection(
      selectedCity: clearSelectedCity
          ? null
          : selectedCity ?? this.selectedCity,
      defaultCity: clearDefaultCity ? null : defaultCity ?? this.defaultCity,
      recentCities: recentCities ?? this.recentCities,
      capabilityState: capabilityState ?? this.capabilityState,
    );
  }
}
