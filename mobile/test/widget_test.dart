import 'package:flutter_test/flutter_test.dart';
import 'package:case_boom/main.dart';

void main() {
  testWidgets('CASE BOOM app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const CaseBoomApp());
    expect(find.byType(CaseBoomApp), findsOneWidget);
  });
}
