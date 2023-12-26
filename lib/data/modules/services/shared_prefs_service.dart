import 'package:flutter_gbaccetta_feed_app/config/flavor_config.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_theme_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const _appThemeModePref = 'appThemeMode';
  static const _appColorPref = 'appColor';

  late final SharedPreferences _sharedPref;

  Future<void> configure() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  void setAppThemeMode(AppThemeMode mode) =>
      _sharedPref.setInt(_appThemeModePref, mode.index);

  AppThemeMode getAppThemeMode() => AppThemeMode.values[
      _sharedPref.getInt(_appThemeModePref) ?? AppThemeMode.system.index];

  void setAppColor(AppColor appColor) =>
      _sharedPref.setInt(_appColorPref, appColor.index);

  AppColor getAppColor() => AppColor.values[
      _sharedPref.getInt(_appColorPref) ?? FlavorConfig.initialColor.index];
}
