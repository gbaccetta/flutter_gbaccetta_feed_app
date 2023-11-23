import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_gbaccetta_feed_app/domain/use_cases/article_use_cases.dart';
import 'package:flutter_gbaccetta_feed_app/domain/use_cases/settings_use_cases.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/nested_navigator.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/contracts.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/view_models.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/views.dart';

void initializeScreens() {
  // HomeView
  getIt.registerFactory<HomeVMContract>(
    () => HomeViewModel(),
  );
  getIt.registerFactory<HomeVMState>(
    () => HomeVMState(),
  );
  getIt.registerFactoryParam<HomeView, NestedNavigator, void>(
    (nestedNavigator, _) => HomeView(nestedNavigator: nestedNavigator),
  );

  // ArticleListView
  getIt.registerFactory<ArticleListVMContract>(
    () => ArticleListViewModel(articleInteractor: getIt<ArticleUseCases>()),
  );
  getIt.registerFactory<ArticleListVMState>(() => ArticleListVMState());
  getIt.registerFactoryParam<ArticleListView, String?, void>(
    (articleId, _) => ArticleListView(initialArticleId: articleId),
  );

  // ArticleDetailsView
  getIt.registerFactory<ArticleDetailsVMContract>(
      () => ArticleDetailsViewModel());
  getIt.registerFactory<ArticleDetailsVMState>(() => ArticleDetailsVMState());
  getIt.registerFactoryParam<ArticleDetailsView, Article, void>(
    (article, _) => ArticleDetailsView(article: article),
  );

  // UserView
  getIt.registerFactory<UserSettingsVMContract>(() =>
      UserSettingsViewModel(settingsInteractor: getIt<SettingsUseCases>()));
  getIt.registerFactory<UserSettingsVMState>(() => UserSettingsVMState());
  getIt.registerFactory<UserSettingsView>(
    () => const UserSettingsView(),
  );
}
