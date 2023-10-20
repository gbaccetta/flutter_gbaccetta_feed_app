import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/api/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    serviceLocatorInitialization();
    await getIt.allReady();
  });

  test('ApiService get initialized', () {
    // ignore: unnecessary_type_check
    expect(getIt<ApiService>() is ApiService, isTrue);
  });

  test('CacheManager get initialized', () {
    expect(getIt<BaseCacheManager>() is DefaultCacheManager, isTrue);
  });
}
