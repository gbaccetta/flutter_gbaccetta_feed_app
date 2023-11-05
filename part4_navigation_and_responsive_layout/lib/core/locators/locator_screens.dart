import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/domain/use_cases/article_use_cases.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_home/home_contract.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_home/home_view_model.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_contract.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_view_model.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_contract.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_view_model.dart';

void initializeScreens() {

  // HomeView
  getIt.registerFactory<HomeVMContract>(
    () => HomeViewModel(),
  );
  getIt.registerFactory<HomeVMState>(
    () => HomeVMState(),
  );
  
  // ArticleListView
  getIt.registerFactory<ArticleListVMContract>(
    () => ArticleListViewModel(articleInteractor: getIt<ArticleUseCases>()),
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
