import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/api/api_service.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/services/shared_prefs_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await serviceLocatorInitialization();
  });

  test('ApiService get initialized', () {
    expect(getIt<ApiService>(), isA<ApiService>());
  });

  test('SharedPrefsService get initialized', () {
    expect(getIt<SharedPrefsService>(), isA<SharedPrefsService>());
  });

  test('CacheManager get initialized', () {
    expect(getIt<BaseCacheManager>(), isA<DefaultCacheManager>());
  });
}
