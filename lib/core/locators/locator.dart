import 'package:flutter_gbaccetta_feed_app/core/locators/locator_interactors.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator_modules.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator_screens.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> serviceLocatorInitialization() async {
  await getIt.reset();
  initializeModules();
  initializeInteractors();
  initializeScreens();
  await getIt.allReady();
}
