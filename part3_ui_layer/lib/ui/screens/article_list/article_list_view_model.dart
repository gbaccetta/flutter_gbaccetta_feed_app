import 'package:flutter_gbaccetta_feed_app/data/interactors/article_interactor.dart';
import 'package:flutter_gbaccetta_feed_app/domain/failures/api_error.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_view_model.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_contract.dart';

class ArticleListViewModel
    extends BaseViewModel<ArticleListVMState, ArticleListViewContract>
    implements ArticleListVMContract {
  final ArticleInteractor _articleInteractor;

  ArticleListViewModel({
    required ArticleInteractor articleInteractor,
  }) : _articleInteractor = articleInteractor;

  @override
  void onInitViewState() {
    // Since in the onInitViewState the widget tree is not built yet there is
    // no need to call notifyListener to update the view
    vmState.isLoading = true;
    _refreshArticleList();
  }

  @override
  Future<void> requestArticleList() async {
    // Start loading and notifyListeners to update view during the refresh
    vmState.isLoading = true;
    notifyListeners();
    await _refreshArticleList();
  }

  @override
  void tapOnArticle(int index) {
    viewContract.goToArticleDetailsScreen(index);
  }

  Future<void> _refreshArticleList() async {
    try {
      final articles = await _articleInteractor.getArticles();
      vmState.articleList.clear();
      vmState.articleVisibility.clear();
      vmState.articleList.addAll(articles);
      vmState.articleVisibility.addAll(articles.map((e) => true));
    } catch (e) {
      vmState.hasError = true;
      if (e is ApiError) {
      } else {}
    }
    vmState.isLoading = false;
    notifyListeners();
  }

  @override
  void tapOnHideArticle(int index) {
    vmState.articleVisibility[index] = false;
    notifyListeners();
  }
}
