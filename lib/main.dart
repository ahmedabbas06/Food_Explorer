import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_explorer/pages/splash/splash_page.dart';
import 'package:food_explorer/providers/auth_provider.dart';
import 'package:food_explorer/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MealProvider()..getMeals()),
      ],
      child: MyApp(prefs: prefs),
    )
  );
}
class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashPage(prefs: prefs,));
  }
}
