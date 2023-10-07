import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/api/api_service.dart';

void initializeModules() {
  getIt.registerSingleton<ApiService>(
    ApiService(),
  );
}
