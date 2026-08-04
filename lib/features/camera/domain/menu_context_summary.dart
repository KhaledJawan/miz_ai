import 'camera_models.dart';

/// Bounds how much of the summary is sent — must stay comfortably under
/// the Edge Function's own `MAX_MENU_CONTEXT_LENGTH` (see
/// supabase/functions/miz-ai/request_schema.ts) so it's never rejected.
const _maxSummaryLength = 3800;

/// Builds the compact, deterministic text summary sent as `menuContext`
/// when the user taps "Ask Miz about this menu" — plain facts only (no
/// LLM call happens here), so Stage 4's system prompt has real ground
/// truth to answer from instead of re-deriving anything. See
/// `ChatLaunchArgs`/`ConversationLaunchArgs`.
String buildMenuContextSummary(MenuAnalysisResult result) {
  final buffer = StringBuffer();
  for (final category in result.categories) {
    if (category.dishes.isEmpty) continue;
    buffer.writeln('${category.name}:');
    for (final dish in category.dishes) {
      buffer.writeln('- ${_dishLine(dish)}');
    }
  }
  final summary = buffer.toString().trim();
  if (summary.length <= _maxSummaryLength) return summary;
  return '${summary.substring(0, _maxSummaryLength)}…';
}

String _dishLine(MatchedDish dish) {
  final name = dish.matchedName ?? dish.extractedName;
  final parts = <String>[name];
  if (dish.price != null) parts.add('${dish.price}');
  parts.add(_statusLabel(dish));
  if (dish.safetyReasons.isNotEmpty) {
    parts.add(
      '(${dish.safetyReasons.map((reason) => reason.code).join(', ')})',
    );
  }
  return parts.join(' — ');
}

String _statusLabel(MatchedDish dish) => switch (dish.safetyStatus) {
  DishSafetyStatus.safe => 'safe for the user\'s profile',
  DishSafetyStatus.warning => 'warning for the user\'s profile',
  DishSafetyStatus.restricted => 'restricted for the user\'s profile',
  null => 'not found in Miz\'s food database',
};
