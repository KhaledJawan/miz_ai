import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/features/home/domain/greeting.dart';

void main() {
  group('greetingForHour', () {
    test('returns morning band before 11:00', () {
      for (final hour in [0, 6, 10]) {
        final greeting = greetingForHour(hour);
        expect(greeting.period, DayPeriod.morning, reason: 'hour $hour');
        expect(greeting.greeting, 'Good morning');
        expect(greeting.contextChipLabels, ['Breakfast', 'Coffee', 'Bakery']);
      }
    });

    test('returns lunch band from 11:00 to 14:59', () {
      for (final hour in [11, 13, 14]) {
        final greeting = greetingForHour(hour);
        expect(greeting.period, DayPeriod.lunch, reason: 'hour $hour');
        expect(greeting.greeting, 'Good afternoon');
        expect(greeting.contextChipLabels, ['Lunch', 'Nearby', 'Quick Meals']);
      }
    });

    test('returns evening band from 15:00 to 20:59', () {
      for (final hour in [15, 18, 20]) {
        final greeting = greetingForHour(hour);
        expect(greeting.period, DayPeriod.evening, reason: 'hour $hour');
        expect(greeting.greeting, 'Good evening');
        expect(greeting.contextChipLabels, ['Dinner', 'Reservations', 'Wine']);
      }
    });

    test('returns late band from 21:00 onward', () {
      for (final hour in [21, 22, 23]) {
        final greeting = greetingForHour(hour);
        expect(greeting.period, DayPeriod.late, reason: 'hour $hour');
        expect(greeting.greeting, 'Good night');
        expect(greeting.contextChipLabels, [
          'Open Restaurants',
          'Delivery',
          'Snacks',
        ]);
      }
    });
  });
}
