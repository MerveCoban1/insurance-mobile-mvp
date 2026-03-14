import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color brandPrimary = Color(0xFF2563EB);
  static const Color brandSecondary = Color(0xFF0EA5A4);
  static const Color success = Color(0xFF15803D);
  static const Color warning = Color(0xFFD97706);
  static const Color danger = Color(0xFFDC2626);

  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF0F172A);
  static const Color lightOnSurfaceVariant = Color(0xFF64748B);
  static const Color lightOutline = Color(0xFFE2E8F0);

  static const Color darkBackground = Color(0xFF020617);
  static const Color darkSurface = Color(0xFF0F172A);
  static const Color darkOnSurface = Color(0xFFF8FAFC);
  static const Color darkOnSurfaceVariant = Color(0xFFCBD5E1);
  static const Color darkOutline = Color(0xFF334155);

  static ColorScheme get lightColorScheme {
    final base = ColorScheme.fromSeed(
      seedColor: brandPrimary,
      brightness: Brightness.light,
    );

    return base.copyWith(
      primary: brandPrimary,
      onPrimary: Colors.white,
      secondary: brandSecondary,
      onSecondary: Colors.white,
      error: danger,
      onError: Colors.white,
      surface: lightSurface,
      onSurface: lightOnSurface,
      onSurfaceVariant: lightOnSurfaceVariant,
      outline: lightOutline,
      primaryContainer: const Color(0xFFDBEAFE),
      onPrimaryContainer: lightOnSurface,
      secondaryContainer: const Color(0xFFCCFBF1),
      onSecondaryContainer: lightOnSurface,
      tertiary: const Color(0xFF38BDF8),
      onTertiary: Colors.white,
      tertiaryContainer: const Color(0xFFE0F2FE),
      onTertiaryContainer: lightOnSurface,
      errorContainer: const Color(0xFFFEE2E2),
      onErrorContainer: danger,
      surfaceTint: brandPrimary,
      shadow: const Color(0x140F172A),
      scrim: const Color(0x660F172A),
      inverseSurface: darkSurface,
      onInverseSurface: lightBackground,
      inversePrimary: const Color(0xFF93C5FD),
    );
  }

  static ColorScheme get darkColorScheme {
    final base = ColorScheme.fromSeed(
      seedColor: brandPrimary,
      brightness: Brightness.dark,
    );

    return base.copyWith(
      primary: const Color(0xFF93C5FD),
      onPrimary: const Color(0xFF0B3BAA),
      secondary: const Color(0xFF5EEAD4),
      onSecondary: const Color(0xFF083344),
      error: const Color(0xFFFCA5A5),
      onError: const Color(0xFF450A0A),
      surface: darkSurface,
      onSurface: darkOnSurface,
      onSurfaceVariant: darkOnSurfaceVariant,
      outline: darkOutline,
      primaryContainer: const Color(0xFF1D4ED8),
      onPrimaryContainer: darkOnSurface,
      secondaryContainer: const Color(0xFF134E4A),
      onSecondaryContainer: darkOnSurface,
      tertiary: const Color(0xFF7DD3FC),
      onTertiary: const Color(0xFF082F49),
      tertiaryContainer: const Color(0xFF0C4A6E),
      onTertiaryContainer: darkOnSurface,
      errorContainer: const Color(0xFF7F1D1D),
      onErrorContainer: const Color(0xFFFEE2E2),
      surfaceTint: const Color(0xFF93C5FD),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: lightSurface,
      onInverseSurface: lightOnSurface,
      inversePrimary: brandPrimary,
    );
  }
}
