import 'package:flutter_gbaccetta_feed_app/data/interactors/settings_interactor.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_theme_mode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../_mocks/mocked_components/generic_mocks.dart';

void main() {
  late SettingsInteractor settingsInteractor;
  final mockSharedPrefsService = MockSharedPrefsService();

  setUp(() {
    settingsInteractor = SettingsInteractor(
      sharedPrefsService: mockSharedPrefsService,
    );
  });

  test('saveAppColor', () async {
    settingsInteractor.saveAppColor(AppColor.blue);
    verify(() => mockSharedPrefsService.setAppColor(AppColor.blue));
  });

  test('saveAppThemeMode', () async {
    settingsInteractor.saveAppThemeMode(AppThemeMode.system);
    verify(() => mockSharedPrefsService.setAppThemeMode(AppThemeMode.system));
  });

  test('currentAppColor', () async {
    when(mockSharedPrefsService.getAppColor).thenReturn(AppColor.blue);
    expect(settingsInteractor.currentAppColor, AppColor.blue);
  });

  test('currentAppThemeMode', () async {
    when(mockSharedPrefsService.getAppThemeMode)
        .thenReturn(AppThemeMode.system);
    expect(settingsInteractor.currentAppThemeMode, AppThemeMode.system);
  });
}
