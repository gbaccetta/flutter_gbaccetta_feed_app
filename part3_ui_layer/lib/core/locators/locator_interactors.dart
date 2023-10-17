import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/data/interactors/article_interactor.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/api/api_service.dart';

void initializeInteractors() {
  getIt.registerFactory<ArticleInteractor>(
    () => ArticleInteractor(apiService: getIt<ApiService>()),
  );
}