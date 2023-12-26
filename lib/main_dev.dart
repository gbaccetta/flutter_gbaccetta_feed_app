import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/config/flavor_config.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/services/shared_prefs_service.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_theme_mode.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/article_list_provider.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/app_settings_provider.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/user.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/app_router.dart';
import 'package:flutter_gbaccetta_feed_app/ui/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  FlavorConfig.initDevEnvironment();
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocatorInitialization();
  await getIt<SharedPrefsService>().configure();
  runApp(const GBAccettaApp());
}

class GBAccettaApp extends StatelessWidget {
  const GBAccettaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppSettingsProvider()),
        ChangeNotifierProvider(create: (_) => User(id: 'id', name: 'name')),
        ChangeNotifierProvider(create: (_) => ArticleListProvider())
      ],
      child: Selector<AppSettingsProvider, ThemeSettings>(
        selector: (_, settings) => settings.themeSettings,
        builder: (_, themeSettings, __) {
          final appTheme = AppTheme(seedColor: themeSettings.appColor.color);
          return MaterialApp.router(
            title: FlavorConfig.appName,
            theme: appTheme.getTheme(Brightness.light),
            darkTheme: appTheme.getTheme(Brightness.dark),
            themeMode: themeSettings.appThemeMode.themeMode,
            routerConfig: AppRouter.simpleRouter,
          );
        },
      ),
    );
  }
}
