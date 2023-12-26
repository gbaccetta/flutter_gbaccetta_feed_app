import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_theme_mode.dart';

abstract class SettingsUseCases {
  void saveAppThemeMode(AppThemeMode mode);
  void saveAppColor(AppColor appColor);
  AppThemeMode get currentAppThemeMode;
  AppColor get currentAppColor;
}
