import 'package:flutter_test/flutter_test.dart';
import 'package:food_explorer/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:food_explorer/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(prefs),
        child: MyApp(prefs: prefs),
      ),
    );

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    expect(find.byType(MyApp), findsOneWidget);
  });
}