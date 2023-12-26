import 'package:flutter_gbaccetta_feed_app/data/modules/services/shared_prefs_service.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_theme_mode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPrefsService sharedPrefsService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPrefsService = SharedPrefsService();
    await sharedPrefsService.configure();
  });

  test('set and get AppColor', () async {
    expect(sharedPrefsService.getAppColor(), AppColor.deepPurple);
    sharedPrefsService.setAppColor(AppColor.blue);
    expect(sharedPrefsService.getAppColor(), AppColor.blue);
  });

  test('set and get AppThemeMode', () async {
    expect(sharedPrefsService.getAppThemeMode(), AppThemeMode.system);
    sharedPrefsService.setAppThemeMode(AppThemeMode.dark);
    expect(sharedPrefsService.getAppThemeMode(), AppThemeMode.dark);
  });
}
