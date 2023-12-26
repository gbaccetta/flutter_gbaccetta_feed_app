import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator_interactors.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator_screens.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/api/api_service.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/services/shared_prefs_service.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/article_list_provider.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/user.dart';
import 'package:provider/provider.dart';

import '../_mocks/mocked_components/generic_mocks.dart';
import '../_mocks/mocked_components/mock_client_adapter.dart';
import '../_mocks/mocked_components/mock_default_cache_manager.dart';
import '../_mocks/mocked_components/mock_go_router.dart';

///
/// Methods to initialize locator for testing
///
void serviceLocatorForTestInitialization() {
  _initializeMockModules();
  initializeInteractors();
  initializeScreens();
}

_initializeMockModules() {
  // For the API Service we will use the actual module but with a mocked http client
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(),
  );
  getIt.registerLazySingleton<MockClientAdapter>(
    () => MockClientAdapter(dio: getIt<ApiService>().dio),
  );
  getIt.registerLazySingleton<SharedPrefsService>(
    () => MockSharedPrefsService(),
  );
  // For other modules we will usually use the mocked version
  getIt.registerLazySingleton<BaseCacheManager>(
    () => MockDefaultCacheManager(),
  );
}

///
/// Creates a testable widget for functional testing of views.
/// It also enables the inclusion of a custom list of providers to initialize
/// the view in a specific state.
///
Widget makeTestableWidget({
  required Widget child,
  List<ChangeNotifierProvider>? testProviders,
  MockGoRouter? mockGoRouter,
  Size? mediaQuerySize,
}) {
  return MultiProvider(
    providers: testProviders ?? defaultTestProviders,
    child: MediaQuery(
      data: MediaQueryData(size: mediaQuerySize ?? portrait),
      child: MaterialApp(
        home: mockGoRouter != null
            ? MockGoRouterProvider(
                goRouter: mockGoRouter,
                child: child,
              )
            : child,
      ),
    ),
  );
}

final defaultTestProviders = [
  ChangeNotifierProvider<ArticleListProvider>(
    create: (_) => ArticleListProvider(),
  ),
  ChangeNotifierProvider<User>(
    create: (_) => User(id: 'id', name: 'name'),
  ),
];

///
/// Frequently used values
///
const landscape = Size(800, 400);
const portrait = Size(400, 800);
const thinPortrait = Size(280, 580);
const mediumScreen = Size(600, 800);
const largeScreen = Size(1200, 800);

const milliseconds10 = Duration(milliseconds: 10);
const milliseconds100 = Duration(milliseconds: 100);
const seconds1 = Duration(seconds: 1);
const seconds10 = Duration(seconds: 10);
final anyArticle = Article(
  id: 'id1',
  title: 'title',
  description: 'description',
  content: '<a href=url>content</a><img alt=""></img>',
  keywords: ['1', '2'],
  url: 'url',
  date: DateTime(2023),
);
final anyPremiumArticle = Article(
  id: 'id2',
  title: 'title',
  description: 'description<img width="100"></img>',
  content: '',
  keywords: ['1', '2'],
  url: 'url',
  date: DateTime(2023),
);
