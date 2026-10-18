import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_explorer/core/theme/theme_app.dart';
import 'package:food_explorer/pages/splash/splash_page.dart';
import 'package:food_explorer/providers/auth_provider.dart';
import 'package:food_explorer/providers/meal_provider.dart';
import 'package:food_explorer/providers/theme_provider.dart';
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
        ChangeNotifierProvider(
          create: (context) => AuthProvider()..checkCurrentUser(),
        ),
        ChangeNotifierProvider(
          create: (context) => MealProvider()..getMeals(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(prefs),
        ),
      ],
      child: MyApp(prefs: prefs),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp({
    super.key,
    required this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: SplashPage(prefs: prefs),
        );
      },
    );
  }
}
