// Placeholder smoke test. PR C replaces this with feature-level widget +
// golden tests (see code-generation-plan Phase 8).
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('sanity: Text widget renders', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Text('hello'),
      ),
    );
    expect(find.text('hello'), findsOneWidget);
  });
}
