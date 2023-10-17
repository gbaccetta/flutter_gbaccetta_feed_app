import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/data/interactors/article_interactor.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_contract.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_view_model.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_contract.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_view_model.dart';

void initializeScreens() {
  // ArticleListView
  getIt.registerFactory<ArticleListVMContract>(
    () => ArticleListViewModel(articleInteractor: getIt<ArticleInteractor>()),
  );
  getIt.registerFactory<ArticleListVMState>(
    () => ArticleListVMState(),
  );

  // ArticleDetailsView
  getIt.registerFactory<ArticleDetailsVMContract>(
    () => ArticleDetailsViewModel(),
  );
  getIt.registerFactory<ArticleDetailsVMState>(
    () => ArticleDetailsVMState(),
  );
}
