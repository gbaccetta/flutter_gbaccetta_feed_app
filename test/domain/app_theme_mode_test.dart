import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_theme_mode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppThemeModeExtension - themeMode', () {
    expect(AppThemeMode.dark.themeMode, ThemeMode.dark);
    expect(AppThemeMode.light.themeMode, ThemeMode.light);
    expect(AppThemeMode.system.themeMode, ThemeMode.system);
  });
}
