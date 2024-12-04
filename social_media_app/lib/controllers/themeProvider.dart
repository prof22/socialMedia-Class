import 'package:flutter/material.dart';
import 'package:social_media_app/util/colors.dart';

class Themeprovider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
      primaryColor: primaryColorLight,
      scaffoldBackgroundColor: backgroundColorLight,
      textTheme: const TextTheme(bodyLarge: TextStyle(color: textColorLight)),
      appBarTheme: const AppBarTheme(color: primaryColorLight),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColorLight));
  ThemeData get darkTheme => ThemeData(
      primaryColor: primaryColorDark,
      scaffoldBackgroundColor: backgroundColorDark,
      textTheme: const TextTheme(bodyLarge: TextStyle(color: textColorDark)),
      appBarTheme: const AppBarTheme(color: primaryColorDark),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColorDark));
}
