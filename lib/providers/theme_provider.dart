import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences? prefs;
  late ThemeMode savedThemeMode;

  ThemeProvider(this.prefs) {
    loadTheme();
  }

  ThemeMode get themeMode => savedThemeMode;

  void loadTheme() {
    final savedTheme = prefs?.getString('theme_mode');
    if (savedTheme == 'light') {
      savedThemeMode = ThemeMode.light;
    } else if (savedTheme == 'dark') {
      savedThemeMode = ThemeMode.dark;
    } else {
      savedThemeMode = ThemeMode.system;
    }
  }

  void changeTheme(ThemeMode mode) {
    savedThemeMode = mode;
    notifyListeners();

    if (mode == ThemeMode.light) {
      prefs?.setString('theme_mode', 'light');
    } else if (mode == ThemeMode.dark) {
      prefs?.setString('theme_mode', 'dark');
    } else {
      prefs?.setString('theme_mode', 'system');
    }
  }
}
