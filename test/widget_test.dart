import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:food_explorer/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      MyApp(prefs: prefs),
    );

    await tester.pumpAndSettle();

    expect(find.byType(MyApp), findsOneWidget);
  });
}