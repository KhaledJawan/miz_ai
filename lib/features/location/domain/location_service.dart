enum LocationLookupStatus { resolved, denied, unavailable }

class LocationLookupResult {
  const LocationLookupResult._(this.status, this.city);

  const LocationLookupResult.resolved(String city)
    : this._(LocationLookupStatus.resolved, city);
  const LocationLookupResult.denied()
    : this._(LocationLookupStatus.denied, null);
  const LocationLookupResult.unavailable()
    : this._(LocationLookupStatus.unavailable, null);

  final LocationLookupStatus status;
  final String? city;
}

abstract interface class LocationService {
  Future<LocationLookupResult> resolveApproximateCity();
}
