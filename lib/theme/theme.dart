import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData _base({required Brightness brightness}) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorSchemeSeed: const Color(0xFF1E88E5),
      cardTheme: const CardThemeData(
        elevation: 1,
        margin: EdgeInsets.all(8),
        clipBehavior: Clip.antiAlias,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }

  // Asıl isimler
  static ThemeData get light => _base(brightness: Brightness.light);
  static ThemeData get dark => _base(brightness: Brightness.dark);

  // main.dart eski çağrıları için alias’lar
  static ThemeData get lightTheme => light;
  static ThemeData get darkTheme => dark;
}
