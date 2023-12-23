import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/services/shared_prefs_service.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_theme_mode.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/app_settings_provider.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/user.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/user_settings/user_settings_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import '../../../utils/test_utils.dart';

void main() {
  late UserSettingsView view;
  late SharedPrefsService mockSharedPrefsService;

  setUpAll(() {
    serviceLocatorForTestInitialization();
  });

  /// we define the finder we will be using to test our views
  final themeChooser = find.byType(SegmentedButton<AppThemeMode>);
  final colorChooser = find.byType(SegmentedButton<AppColor>);
  final darkButton = find.byIcon(Icons.dark_mode);
  final darkLabel = find.text('dark');
  final blueButton = find.byIcon(Icons.circle).at(1);

  Future<void> init(WidgetTester tester, {Article? article}) async {
    view = getIt<UserSettingsView>();
    mockSharedPrefsService = getIt<SharedPrefsService>();

    when(mockSharedPrefsService.getAppColor).thenReturn(AppColor.green);
    when(mockSharedPrefsService.getAppThemeMode)
        .thenReturn(AppThemeMode.system);

    await tester.pumpWidget(makeTestableWidget(child: view, testProviders: [
      ChangeNotifierProvider<User>(
        create: (_) => User(id: 'id', name: 'name'),
      ),
      ChangeNotifierProvider<AppSettingsProvider>(
        create: (_) => AppSettingsProvider(),
      ),
    ]));
    await tester.pumpAndSettle();
  }

  testWidgets('change theme and color on normal screen', (tester) async {
    await tester.binding.setSurfaceSize(portrait);
    await init(tester);

    expect(themeChooser, findsOneWidget);
    expect(colorChooser, findsOneWidget);
    expect(darkLabel, findsOneWidget);
    var themeButtons = tester.widget<SegmentedButton>(themeChooser);
    var colorButtons = tester.widget<SegmentedButton>(colorChooser);
    expect(themeButtons.segments.length, 3);
    expect(colorButtons.segments.length, 4);
    expect(themeButtons.selected.first, AppThemeMode.system);
    expect(colorButtons.selected.first, AppColor.green);

    await tester.tap(darkButton);
    await tester.pumpAndSettle();
    await tester.tap(blueButton);

    themeButtons = tester.widget<SegmentedButton>(themeChooser);
    colorButtons = tester.widget<SegmentedButton>(colorChooser);
    expect(themeButtons.selected.first, AppThemeMode.dark);
    expect(colorButtons.selected.first, AppColor.green);
  });

  testWidgets('check theme label hidden on thin screens', (tester) async {
    await tester.binding.setSurfaceSize(thinPortrait);
    await init(tester);

    expect(themeChooser, findsOneWidget);
    expect(colorChooser, findsOneWidget);
    expect(darkLabel, findsNothing);
  });
}
