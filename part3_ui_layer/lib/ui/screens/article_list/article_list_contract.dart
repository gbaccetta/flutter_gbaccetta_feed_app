import 'dart:ffi';

import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_contract.dart';

class ArticleListVMState extends BaseViewModelState {
  final List<Article> articleList = [];
  final List<bool> articleVisibilityList = [];
}

abstract class ArticleListViewContract extends BaseViewContract {
  void goToArticleDetailsScreen(int index);
}

abstract class ArticleListVMContract
    extends BaseViewModelContract<ArticleListVMState, ArticleListViewContract> {
  void tapOnArticle(int index);
  void tapOnHideArticle(int index);
  void requestArticleList();
}
