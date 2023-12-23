import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_theme_mode.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/app_settings_provider.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_contract.dart';

class UserSettingsVMState extends BaseViewModelState {
  late final AppSettingsProvider appSettings;
}

abstract class UserSettingsViewContract extends BaseViewContract {}

abstract class UserSettingsVMContract extends BaseViewModelContract<
    UserSettingsVMState, UserSettingsViewContract> {
  void onAppColorChanged(AppColor color);
  void onThemeModeChanged(AppThemeMode themeMode);
}
