import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/api/api_service.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/services/shared_prefs_service.dart';

void initializeModules() {
  getIt.registerSingleton<ApiService>(
    ApiService(),
  );
  getIt.registerSingleton<SharedPrefsService>(
    SharedPrefsService(),
  );
  getIt.registerLazySingleton<BaseCacheManager>(
    () => DefaultCacheManager(),
  );
}
