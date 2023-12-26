import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/services/shared_prefs_service.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_theme_mode.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/app_settings_provider.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/user_settings/user_settings_contract.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/user_settings/user_settings_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_mocks/mocked_components/generic_mocks.dart';
import '../../../utils/test_utils.dart';

class MockUserSettingsView extends Mock implements UserSettingsViewContract {}

void main() {
  late UserSettingsViewModel viewModel;
  late UserSettingsVMState vmState;

  late MockUserSettingsView mockView;
  late MockSettingsInteractor mockSettingsInteractor;

  /// when testing view models we usually do not any service mocked values.
  /// Although since this viewModel uses and update AppSettingsProvider. This is
  /// needed to ensure correct initialization of the provider.
  setUpAll(() {
    serviceLocatorForTestInitialization();
    final mockSharedPrefsService = getIt<SharedPrefsService>();
    when(mockSharedPrefsService.getAppColor).thenReturn(AppColor.blue);
    when(mockSharedPrefsService.getAppThemeMode).thenReturn(AppThemeMode.dark);
  });

  setUp(() {
    mockView = MockUserSettingsView();
    mockSettingsInteractor = MockSettingsInteractor();
    vmState = UserSettingsVMState();
    viewModel =
        UserSettingsViewModel(settingsInteractor: mockSettingsInteractor);
    viewModel.viewContract = mockView;
    viewModel.vmState = vmState;
    vmState.appSettings = AppSettingsProvider();
  });

  test('onAppColorChanged', () async {
    expect(vmState.appSettings.themeSettings.appColor, AppColor.blue);
    viewModel.onAppColorChanged(AppColor.deepPurple);
    verify(() => mockSettingsInteractor.saveAppColor(AppColor.deepPurple));
    expect(vmState.appSettings.themeSettings.appColor, AppColor.deepPurple);
  });

  test('onThemeModeChanged', () async {
    expect(vmState.appSettings.themeSettings.appThemeMode, AppThemeMode.dark);
    viewModel.onThemeModeChanged(AppThemeMode.light);
    verify(() => mockSettingsInteractor.saveAppThemeMode(AppThemeMode.light));
    expect(vmState.appSettings.themeSettings.appThemeMode, AppThemeMode.light);
  });
}
