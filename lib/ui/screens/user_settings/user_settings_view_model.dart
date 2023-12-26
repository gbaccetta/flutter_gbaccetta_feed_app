import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_theme_mode.dart';
import 'package:flutter_gbaccetta_feed_app/domain/use_cases/settings_use_cases.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_view_model.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/user_settings/user_settings_contract.dart';

class UserSettingsViewModel
    extends BaseViewModel<UserSettingsVMState, UserSettingsViewContract>
    implements UserSettingsVMContract {
  final SettingsUseCases settingsInteractor;

  UserSettingsViewModel({required this.settingsInteractor});

  @override
  void onAppColorChanged(AppColor color) {
    settingsInteractor.saveAppColor(color);
    vmState.appSettings.switchColor(color);
    notifyListeners();
  }

  @override
  void onThemeModeChanged(AppThemeMode themeMode) {
    settingsInteractor.saveAppThemeMode(themeMode);
    vmState.appSettings.switchMode(themeMode);
    notifyListeners();
  }
}
