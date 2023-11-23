import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_theme_mode.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/app_settings_provider.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_view_widget_state.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/user_settings/user_settings_contract.dart';
import 'package:provider/provider.dart';

class UserSettingsView extends StatefulWidget {
  const UserSettingsView({super.key});

  @override
  State<UserSettingsView> createState() => _UserSettingsViewWidgetState();
}

class _UserSettingsViewWidgetState extends BaseViewWidgetState<
    UserSettingsView,
    UserSettingsVMContract,
    UserSettingsVMState> implements UserSettingsViewContract {
  @override
  void onInitState() {
    vmState.appSettings = context.read<AppSettingsProvider>();
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Text('User Settings', style: textTheme.titleLarge),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Theme Mode:', style: textTheme.headlineSmall)),
            const SizedBox(height: 16),
            SegmentedButton<AppThemeMode>(
              segments: AppThemeMode.values
                  .map((appThemeMode) => ButtonSegment(
                      value: appThemeMode,
                      label: constraints.maxWidth > 300
                          ? Text(appThemeMode.name)
                          : null,
                      icon: Icon(appThemeMode.icon)))
                  .toList(),
              selected: {vmState.appSettings.themeSettings.appThemeMode},
              onSelectionChanged: (set) =>
                  vmContract.onThemeModeChanged(set.first),
            ),
            const SizedBox(height: 24),
            Center(child: Text('App Color:', style: textTheme.headlineSmall)),
            const SizedBox(height: 16),
            SegmentedButton<AppColor>(
              segments: AppColor.values
                  .map((appColor) => ButtonSegment(
                      value: appColor,
                      icon: Icon(Icons.circle, color: appColor.color)))
                  .toList(),
              selected: {vmState.appSettings.themeSettings.appColor},
              onSelectionChanged: (set) =>
                  vmContract.onAppColorChanged(set.first),
            ),
          ],
        ),
      );
    });
  }
}
