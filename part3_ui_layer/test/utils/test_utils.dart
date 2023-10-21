import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator_interactors.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator_screens.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/api/api_service.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/user.dart';
import 'package:provider/provider.dart';

import '../_mocks/mocked_components/mock_client_adapter.dart';
import '../_mocks/mocked_components/mock_default_cache_manager.dart';

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
}) {
  return MultiProvider(
    providers: testProviders ?? _defaultTestProviders,
    child: MaterialApp(
      home: child,
    ),
  );
}

final _defaultTestProviders = [
  ChangeNotifierProvider(
    create: (_) => User(id: 'id', name: 'name'),
  )
];

///
/// Frequently used values
///
const milliseconds1 = Duration(milliseconds: 1);
const milliseconds100 = Duration(milliseconds: 100);
const milliseconds1000 = Duration(milliseconds: 1000);
final anyArticle = Article(
  title: 'title',
  description: 'description',
  content: 'content',
  keywords: ['1', '2'],
  url: 'url',
  date: DateTime(2023),
);
