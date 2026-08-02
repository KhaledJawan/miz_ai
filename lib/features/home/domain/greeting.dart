/// Time-of-day bands for the "alive" Home screen. See docs/DESIGN.md §5 —
/// mirrors the approved prototype's `renderVals()` time logic exactly.
enum DayPeriod { morning, lunch, evening, late }

class Greeting {
  const Greeting({
    required this.period,
    required this.greeting,
    required this.contextLabel,
    required this.contextChipLabels,
  });

  final DayPeriod period;
  final String greeting;
  final String contextLabel;
  final List<String> contextChipLabels;
}

/// Pure function of the hour (0–23) so it's testable without mocking a
/// clock — see docs/TESTING.md.
Greeting greetingForHour(int hour) {
  if (hour < 11) {
    return const Greeting(
      period: DayPeriod.morning,
      greeting: 'Good morning',
      contextLabel: 'Good for breakfast',
      contextChipLabels: ['Breakfast', 'Coffee', 'Bakery'],
    );
  }
  if (hour < 15) {
    return const Greeting(
      period: DayPeriod.lunch,
      greeting: 'Good afternoon',
      contextLabel: 'Good for lunch',
      contextChipLabels: ['Lunch', 'Nearby', 'Quick Meals'],
    );
  }
  if (hour < 21) {
    return const Greeting(
      period: DayPeriod.evening,
      greeting: 'Good evening',
      contextLabel: 'Good for dinner',
      contextChipLabels: ['Dinner', 'Reservations', 'Wine'],
    );
  }
  return const Greeting(
    period: DayPeriod.late,
    greeting: 'Good night',
    contextLabel: 'Open late',
    contextChipLabels: ['Open Restaurants', 'Delivery', 'Snacks'],
  );
}
