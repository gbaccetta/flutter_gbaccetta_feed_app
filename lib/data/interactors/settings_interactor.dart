import 'package:flutter_gbaccetta_feed_app/data/modules/services/shared_prefs_service.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_theme_mode.dart';
import 'package:flutter_gbaccetta_feed_app/domain/use_cases/settings_use_cases.dart';

class SettingsInteractor implements SettingsUseCases {
  final SharedPrefsService sharedPrefsService;

  SettingsInteractor({required this.sharedPrefsService});

  @override
  void saveAppColor(AppColor appColor) =>
      sharedPrefsService.setAppColor(appColor);

  @override
  void saveAppThemeMode(AppThemeMode mode) =>
      sharedPrefsService.setAppThemeMode(mode);

  @override
  AppColor get currentAppColor => sharedPrefsService.getAppColor();

  @override
  AppThemeMode get currentAppThemeMode => sharedPrefsService.getAppThemeMode();
}
