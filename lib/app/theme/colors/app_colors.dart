import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color brandPrimary = Color(0xFF0057D9);
  static const Color brandSecondary = Color(0xFF3A6EA5);
  static const Color accent = Color(0xFF1A8FDD);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);
  static const Color danger = Color(0xFFD32F2F);

  static const Color lightBackground = Color(0xFFF7F9FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF1B1F24);
  static const Color lightOutline = Color(0xFFD9E0EA);

  static const Color darkBackground = Color(0xFF111418);
  static const Color darkSurface = Color(0xFF1A1F26);
  static const Color darkOnSurface = Color(0xFFF3F6FA);
  static const Color darkOutline = Color(0xFF3B4653);

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: brandPrimary,
    onPrimary: Colors.white,
    secondary: brandSecondary,
    onSecondary: Colors.white,
    error: danger,
    onError: Colors.white,
    surface: lightSurface,
    onSurface: lightOnSurface,
    primaryContainer: Color(0xFFD8E5FF),
    onPrimaryContainer: Color(0xFF001B3F),
    secondaryContainer: Color(0xFFD3E4FF),
    onSecondaryContainer: Color(0xFF0D1F33),
    tertiary: accent,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFD0ECFF),
    onTertiaryContainer: Color(0xFF001E31),
    outline: lightOutline,
    shadow: Color(0x1F000000),
    scrim: Color(0x66000000),
    inverseSurface: Color(0xFF2F3640),
    onInverseSurface: Colors.white,
    inversePrimary: Color(0xFFA9C7FF),
    surfaceTint: brandPrimary,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA9C7FF),
    onPrimary: Color(0xFF002E68),
    secondary: Color(0xFFB0C9EA),
    onSecondary: Color(0xFF073258),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    surface: darkSurface,
    onSurface: darkOnSurface,
    primaryContainer: Color(0xFF1C4481),
    onPrimaryContainer: Color(0xFFD8E5FF),
    secondaryContainer: Color(0xFF254B73),
    onSecondaryContainer: Color(0xFFD3E4FF),
    tertiary: Color(0xFF84D1FF),
    onTertiary: Color(0xFF00344F),
    tertiaryContainer: Color(0xFF004B70),
    onTertiaryContainer: Color(0xFFD0ECFF),
    outline: darkOutline,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFFF3F6FA),
    onInverseSurface: Color(0xFF1B1F24),
    inversePrimary: brandPrimary,
    surfaceTint: Color(0xFFA9C7FF),
  );
}
