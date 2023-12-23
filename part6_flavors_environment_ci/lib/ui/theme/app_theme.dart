import 'package:flutter/material.dart';

/// The [AppTheme] class is responsible for defining the app's theme based on a
/// [seedColor] provided during app startup. The [seedColor] is used to initialize
/// the app color scheme dynamically for both light and dark themes when calling
/// the [getTheme] method with [Brightness.light] or [Brightness.dark].
class AppTheme {
  final MaterialColor seedColor;

  /// Initializes the [AppTheme] with an optional [seedColor], defaulting to
  /// [Colors.green].
  AppTheme({this.seedColor = Colors.green});

  /// Generates a [ColorScheme] based on the specified [brightness].
  ColorScheme _colorScheme(Brightness brightness) => ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
      );

  /// Returns a [ThemeData] instance tailored to the chosen [brightness].
  ThemeData getTheme(Brightness brightness) {
    final colorScheme = _colorScheme(brightness);
    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      // Use Material 3 typography, not yet the default in Flutter 3.16
      typography: Typography.material2021(
        colorScheme: colorScheme,
        platform: TargetPlatform.iOS,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.w500),
      ),
      appBarTheme: AppBarTheme(
        // Remove colored overlay when content scroll below the app bar
        scrolledUnderElevation: 0,
        // We will use surfaceVariant as background for all navigation component
        color: colorScheme.surfaceVariant,
        // Adds a bottomRight rounded corner to the appBar
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.elliptical(120, 50),
          ),
        ),
      ),
      cardTheme: const CardTheme(
        // Provides a nice customized shape for all cards in the app
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(20, 32),
            bottomLeft: Radius.elliptical(20, 120),
            topRight: Radius.elliptical(20, 32),
            bottomRight: Radius.elliptical(20, 120),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        // Colors the chips and makes them more prominent
        backgroundColor: colorScheme.primaryContainer,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.secondary,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        // Assigns [surfaceVariant] as the background color
        backgroundColor: colorScheme.surfaceVariant,
        // Assigns [onSurfaceVariant] to the unselectedItemColor
        unselectedItemColor: colorScheme.onSurfaceVariant,
        // Assigns [inverseSurface] to the selectedIcon for more contrast
        selectedIconTheme: IconThemeData(color: colorScheme.inverseSurface),
      ),
      navigationRailTheme: NavigationRailThemeData(
        // Uses [surfaceVariant] as the background color
        backgroundColor: colorScheme.surfaceVariant,
        // Uses [onSurfaceVariant] for the unselected icon and indicator
        indicatorColor: colorScheme.onSurfaceVariant,
        unselectedIconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
        // Uses [surfaceVariant] for the selected icon as this will be inside
        // the indicator and will give a nice hole in the indicator effect
        selectedIconTheme: IconThemeData(color: colorScheme.surfaceVariant),
      ),
    );
  }
}
