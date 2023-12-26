import 'package:flutter_gbaccetta_feed_app/domain/failures/api_error.dart';
import 'package:flutter_gbaccetta_feed_app/domain/use_cases/article_use_cases.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_view_model.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_contract.dart';

class ArticleListViewModel
    extends BaseViewModel<ArticleListVMState, ArticleListViewContract>
    implements ArticleListVMContract {
  final ArticleUseCases _articleInteractor;

  ArticleListViewModel({
    required ArticleUseCases articleInteractor,
  }) : _articleInteractor = articleInteractor;

  @override
  Future<void> onInitState() async {
    // if the list retrieved from the provider is empty let's refresh it
    if (vmState.articleList.isEmpty) {
      vmState.isLoading = true;
      await _refreshArticleList();
    } else {
      vmState.articleVisibilityList.addAll(
        vmState.articleList.map((e) => true),
      );
    }
    // if there was a query parameter for a given article try to open it
    if (!vmState.hasError && vmState.initialArticleId != null) {
      final initialArticleIndex = vmState.articleList.indexWhere(
        (article) => article.id == vmState.initialArticleId,
      );
      if (initialArticleIndex >= 0) {
        // if we find the article requested we reuse our navigation method
        viewContract.goToArticleDetailsScreen(initialArticleIndex);
      }
    }
  }

  @override
  Future<void> tapOnRefreshArticleList() async {
    startLoadingState();
    await _refreshArticleList();
  }

  @override
  void tapOnArticle(int index) {
    viewContract.goToArticleDetailsScreen(index);
  }

  Future<void> _refreshArticleList() async {
    vmState.hasError = false;
    try {
      final articles = await _articleInteractor.getArticles();
      _clearLists();
      vmState.articleList.addAll(articles);
      vmState.articleVisibilityList.addAll(articles.map((e) => true));
    } catch (e) {
      vmState.hasError = true;
      viewContract.showErrorRetrievingArticlesSnackbar();
      if (e is ApiError) {
      } else {}
    }
    stopLoadingState();
  }

  void _clearLists() {
    vmState.articleList.clear();
    vmState.articleVisibilityList.clear();
  }

  @override
  void tapOnHideArticle(int index) {
    vmState.articleVisibilityList[index] = false;
    notifyListeners();
  }
}
