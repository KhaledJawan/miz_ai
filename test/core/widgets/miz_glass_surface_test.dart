import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/core/theme/app_theme.dart';
import 'package:miz_ai/core/widgets/miz_glass_surface.dart';

void main() {
  testWidgets(
    'prominent surface is solid white, zero blur, and dark-readable',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: Center(
              child: MizGlassSurface(prominent: true, child: Text('Readable')),
            ),
          ),
        ),
      );

      final surface = find.byType(MizGlassSurface);
      expect(
        find.descendant(of: surface, matching: find.byType(BackdropFilter)),
        findsNothing,
      );

      final decorations = tester
          .widgetList<DecoratedBox>(
            find.descendant(of: surface, matching: find.byType(DecoratedBox)),
          )
          .map((widget) => widget.decoration)
          .whereType<BoxDecoration>();
      expect(
        decorations.any((decoration) => decoration.color == Colors.white),
        isTrue,
      );

      final textContext = tester.element(find.text('Readable'));
      expect(DefaultTextStyle.of(textContext).style.color, Colors.black);
    },
  );
}
