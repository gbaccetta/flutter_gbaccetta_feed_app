import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/article_list.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_contract.dart';

class ArticleListVMState extends BaseViewModelState {
  late final ArticleList articleListProvider;
  late final String? initialArticleId;
  final List<bool> articleVisibilityList = [];
  List<Article> get articleList => articleListProvider.articleList;
}

abstract class ArticleListViewContract extends BaseViewContract {
  void goToArticleDetailsScreen(int index);
  void showErrorRetrievingArticlesSnackbar();
}

abstract class ArticleListVMContract
    extends BaseViewModelContract<ArticleListVMState, ArticleListViewContract> {
  void tapOnArticle(int index);
  void tapOnHideArticle(int index);
  void tapOnRefreshArticleList();
}
