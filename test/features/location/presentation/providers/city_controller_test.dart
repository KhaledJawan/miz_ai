import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/features/location/domain/city_selection.dart';
import 'package:miz_ai/features/location/domain/location_service.dart';
import 'package:miz_ai/features/location/presentation/providers/city_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test(
    'does not assume a city and persists manual/default selection',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      expect(
        (await container.read(cityControllerProvider.future)).selectedCity,
        isNull,
      );

      final notifier = container.read(cityControllerProvider.notifier);
      await notifier.selectCity('Trier');
      await notifier.setSelectedAsDefault(true);

      final state = container.read(cityControllerProvider).requireValue;
      expect(state.selectedCity, 'Trier');
      expect(state.defaultCity, 'Trier');
      expect(state.recentCities, ['Trier']);
    },
  );

  test(
    'location denial is explicit and manual selection still works',
    () async {
      final container = ProviderContainer(
        overrides: [
          locationServiceProvider.overrideWithValue(
            const _DeniedLocationService(),
          ),
        ],
      );
      addTearDown(container.dispose);
      await container.read(cityControllerProvider.future);

      final notifier = container.read(cityControllerProvider.notifier);
      await notifier.useCurrentLocation();
      expect(
        container.read(cityControllerProvider).requireValue.capabilityState,
        LocationCapabilityState.denied,
      );

      await notifier.selectCity('Berlin');
      expect(
        container.read(cityControllerProvider).requireValue.selectedCity,
        'Berlin',
      );
    },
  );
}

class _DeniedLocationService implements LocationService {
  const _DeniedLocationService();

  @override
  Future<LocationLookupResult> resolveApproximateCity() async =>
      const LocationLookupResult.denied();
}
