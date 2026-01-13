import 'package:flutter/material.dart';

class AppTheme {
  // ============================================
  // COLORI APP - Sicurezza sul Lavoro
  // ============================================

  // PRIMARY - Giallo Safety (Attenzione/Azioni principali)
  static const Color primary = Color(0xFFFFB800);
  static const Color onPrimary = Color(0xFF000000);
  static const Color primaryContainer = Color(0xFFFFF3CC);
  static const Color onPrimaryContainer = Color(0xFF2D2400);

  // SECONDARY - Verde Safety (Sicurezza/OK/Conferme)
  static const Color secondary = Color(0xFF2E7D32);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFC8E6C9);
  static const Color onSecondaryContainer = Color(0xFF002204);

  // TERTIARY - Blu Safety (Informazioni/Obbligatorio)
  static const Color tertiary = Color(0xFF1565C0);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFBBDEFB);
  static const Color onTertiaryContainer = Color(0xFF001D3D);

  // WARNING - Arancione (Avvisi)
  static const Color warning = Color(0xFFFF6D00);
  static const Color onWarning = Color(0xFF000000);
  static const Color warningContainer = Color(0xFFFFE0B2);
  static const Color onWarningContainer = Color(0xFF331400);

  // DANGER - Rosso Safety (Pericolo/SOS/Divieto)
  static const Color danger = Color(0xFFD32F2F);
  static const Color onDanger = Color(0xFFFFFFFF);
  static const Color dangerContainer = Color(0xFFFFCDD2);
  static const Color onDangerContainer = Color(0xFF410002);

  // NEUTRAL - Grigio (Disabilitato/Secondario)
  static const Color neutral = Color(0xFF757575);
  static const Color onNeutral = Color(0xFFFFFFFF);
  static const Color neutralContainer = Color(0xFFE0E0E0);
  static const Color onNeutralContainer = Color(0xFF1C1C1C);

  // SURFACE - Sfondi
  static const Color surface = Color(0xFFFAFAFA);
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color surfaceVariant = Color(0xFFE8E8E8);
  static const Color onSurfaceVariant = Color(0xFF49454F);

  // OUTLINE - Bordi
  static const Color outline = Color(0xFF79747E);
  static const Color outlineVariant = Color(0xFFCAC4D0);

  // ============================================
  // DARK MODE VARIANTS
  // ============================================
  static const Color primaryDark = Color(0xFFFFD54F);
  static const Color onPrimaryDark = Color(0xFF3A3000);
  static const Color primaryContainerDark = Color(0xFF544600);
  static const Color onPrimaryContainerDark = Color(0xFFFFF0B5);

  static const Color secondaryDark = Color(0xFF81C784);
  static const Color onSecondaryDark = Color(0xFF00390D);
  static const Color secondaryContainerDark = Color(0xFF1B5E20);
  static const Color onSecondaryContainerDark = Color(0xFFA8F596);

  static const Color tertiaryDark = Color(0xFF64B5F6);
  static const Color onTertiaryDark = Color(0xFF003258);
  static const Color tertiaryContainerDark = Color(0xFF0D47A1);
  static const Color onTertiaryContainerDark = Color(0xFFD1E4FF);

  static const Color warningDark = Color(0xFFFFAB40);
  static const Color onWarningDark = Color(0xFF000000);

  static const Color dangerDark = Color(0xFFEF9A9A);
  static const Color onDangerDark = Color(0xFF690005);
  static const Color dangerContainerDark = Color(0xFFC62828);
  static const Color onDangerContainerDark = Color(0xFFFFDAD6);

  static const Color surfaceDark = Color(0xFF1C1B1F);
  static const Color onSurfaceDark = Color(0xFFE6E1E5);
  static const Color surfaceVariantDark = Color(0xFF49454F);
  static const Color onSurfaceVariantDark = Color(0xFFCAC4D0);

  static const Color outlineDark = Color(0xFF938F99);
  static const Color outlineVariantDark = Color(0xFF49454F);

  // ============================================
  // COLOR SCHEMES
  // ============================================
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    error: danger,
    onError: onDanger,
    errorContainer: dangerContainer,
    onErrorContainer: onDangerContainer,
    surface: surface,
    onSurface: onSurface,
    surfaceContainerHighest: surfaceVariant,
    onSurfaceVariant: onSurfaceVariant,
    outline: outline,
    outlineVariant: outlineVariant,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryDark,
    onPrimary: onPrimaryDark,
    primaryContainer: primaryContainerDark,
    onPrimaryContainer: onPrimaryContainerDark,
    secondary: secondaryDark,
    onSecondary: onSecondaryDark,
    secondaryContainer: secondaryContainerDark,
    onSecondaryContainer: onSecondaryContainerDark,
    tertiary: tertiaryDark,
    onTertiary: onTertiaryDark,
    tertiaryContainer: tertiaryContainerDark,
    onTertiaryContainer: onTertiaryContainerDark,
    error: dangerDark,
    onError: onDangerDark,
    errorContainer: dangerContainerDark,
    onErrorContainer: onDangerContainerDark,
    surface: surfaceDark,
    onSurface: onSurfaceDark,
    surfaceContainerHighest: surfaceVariantDark,
    onSurfaceVariant: onSurfaceVariantDark,
    outline: outlineDark,
    outlineVariant: outlineVariantDark,
  );

  // ============================================
  // THEMES
  // ============================================
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: surface,
    appBarTheme: const AppBarTheme(
      backgroundColor: surface,
      foregroundColor: onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: surface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondary,
      foregroundColor: onSecondary,
      elevation: 2,
      shape: CircleBorder(),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: danger),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surface,
      selectedItemColor: primary,
      unselectedItemColor: onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: surface,
      indicatorColor: primaryContainer,
      elevation: 0,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: onPrimaryContainer);
        }
        return const IconThemeData(color: onSurfaceVariant);
      }),
    ),
    dividerTheme: const DividerThemeData(
      color: outlineVariant,
      thickness: 1,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceVariant,
      selectedColor: primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: surfaceDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: onSurfaceDark,
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: surfaceVariantDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryDark,
        foregroundColor: onPrimaryDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryDark,
      foregroundColor: onSecondaryDark,
      elevation: 2,
      shape: CircleBorder(),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceVariantDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryDark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: dangerDark),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryDark,
      unselectedItemColor: onSurfaceVariantDark,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: surfaceDark,
      indicatorColor: primaryContainerDark,
      elevation: 0,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: onPrimaryContainerDark);
        }
        return const IconThemeData(color: onSurfaceVariantDark);
      }),
    ),
    dividerTheme: const DividerThemeData(
      color: outlineVariantDark,
      thickness: 1,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceVariantDark,
      selectedColor: primaryContainerDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
