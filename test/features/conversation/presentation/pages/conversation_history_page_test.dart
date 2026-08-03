import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/core/localization/localization.dart';
import 'package:miz_ai/core/theme/app_theme.dart';
import 'package:miz_ai/features/conversation/domain/conversation_models.dart';
import 'package:miz_ai/features/conversation/presentation/pages/conversation_history_page.dart';
import 'package:miz_ai/features/conversation/presentation/providers/conversation_history_providers.dart';

Widget _wrap(List<ConversationArchive> archives) => ProviderScope(
  overrides: [
    conversationHistoryProvider.overrideWith((ref) => Stream.value(archives)),
  ],
  child: MaterialApp(
    theme: AppTheme.light(),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: const ConversationHistoryPage(),
  ),
);

void main() {
  testWidgets('shows the empty conversation-history state', (tester) async {
    await tester.pumpWidget(_wrap(const []));
    await tester.pumpAndSettle();

    expect(find.text('Chat history'), findsOneWidget);
    expect(find.text('No conversations yet'), findsOneWidget);
  });

  testWidgets('shows and opens a locally archived conversation', (
    tester,
  ) async {
    final now = DateTime.utc(2026, 8, 3, 12);
    final archive = ConversationArchive(
      id: 'chat-1',
      title: 'Find ramen',
      createdAt: now,
      updatedAt: now,
      messages: const [
        ConversationMessage(
          id: 'user-1',
          author: ConversationAuthor.user,
          text: 'Find ramen',
        ),
        ConversationMessage(
          id: 'miz-1',
          author: ConversationAuthor.miz,
          text: 'Here are two good options.',
        ),
      ],
    );

    await tester.pumpWidget(_wrap([archive]));
    await tester.pumpAndSettle();
    expect(find.text('Find ramen'), findsOneWidget);

    await tester.tap(find.text('Find ramen'));
    await tester.pumpAndSettle();

    expect(find.text('Here are two good options.'), findsNWidgets(2));
  });
}
