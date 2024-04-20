import 'package:flutter/material.dart';
import 'package:app/expenses.dart';

ColorScheme colorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 9, 188, 152));
ColorScheme darkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 10, 83, 68));

void main() {
  // *** LOCK PHONE ORIENTATION *** //
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      cardTheme: const CardTheme().copyWith(
          color: darkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: darkColorScheme.primaryContainer,
              foregroundColor: darkColorScheme.onPrimaryContainer)),
    ),
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: colorScheme.onPrimaryContainer,
        foregroundColor: colorScheme.primaryContainer,
      ),
      cardTheme: const CardTheme().copyWith(
          color: colorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
      )),
      textTheme: ThemeData().textTheme.copyWith(
          bodyMedium: ThemeData().textTheme.bodyMedium?.copyWith(height: 2),
          titleMedium: ThemeData()
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold)),
    ),
    // themeMode: ThemeMode.dark,
    home: const Expenses(),
  ));
  // });
}
