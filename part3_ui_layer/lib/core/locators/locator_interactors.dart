import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/data/interactors/article_interactor.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/api/api_service.dart';
import 'package:flutter_gbaccetta_feed_app/domain/use_cases/article_use_cases.dart';

void initializeInteractors() {
  getIt.registerFactory<ArticleUseCases>(
    () => ArticleInteractor(apiService: getIt<ApiService>()),
  );
}