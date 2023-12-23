import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_theme_mode.dart';
import 'package:flutter_gbaccetta_feed_app/domain/use_cases/settings_use_cases.dart';

class AppSettingsProvider extends ChangeNotifier {
  late ThemeSettings themeSettings;

  AppSettingsProvider() {
    // Typically, following the architecture outlined in Part 1, interactors are exclusively
    // utilized by the view model. While providers may resemble a view model in certain
    // scenarios, they don't have an associated view, given that their consumer spans
    // the entire app. I opted not to include them in the architecture diagram to maintain
    // its general validity across different contexts, as the diagram aims for broader
    // applicability beyond Flutter and provider-specific concepts.
    final settingsInteractor = getIt<SettingsUseCases>();
    // To streamline the exposure of app settings in the provider, we encapsulate
    // theme-related settings within a dedicated property called themeSetting.
    // This approach enhances the usability of selectors for optimizing UI updates
    // based on changes in settings, ensuring more performance-effective rebuilds.
    themeSettings = ThemeSettings(
      appColor: settingsInteractor.currentAppColor,
      appThemeMode: settingsInteractor.currentAppThemeMode,
    );
  }

  void switchColor(AppColor appColor) {
    if (themeSettings.appColor == appColor) return;
    // copying settings to a new themeSettings object ensure provider selector
    // to rebuild when themeSettings changes without having to specify a logic
    // for the rebuild.
    themeSettings = themeSettings.copyWith(appColor: appColor);
    notifyListeners();
  }

  void switchMode(AppThemeMode appThemeMode) {
    if (themeSettings.appThemeMode == appThemeMode) return;
    // copying settings to a new themeSettings object ensure provider selector
    // to rebuild when themeSettings changes without having to specify a logic
    // for the rebuild.
    themeSettings = themeSettings.copyWith(appThemeMode: appThemeMode);
    notifyListeners();
  }
}

class ThemeSettings {
  final AppThemeMode appThemeMode;
  final AppColor appColor;

  ThemeSettings({required this.appThemeMode, required this.appColor});

  ThemeSettings copyWith({AppThemeMode? appThemeMode, AppColor? appColor}) {
    return ThemeSettings(
      appColor: appColor ?? this.appColor,
      appThemeMode: appThemeMode ?? this.appThemeMode,
    );
  }
}
