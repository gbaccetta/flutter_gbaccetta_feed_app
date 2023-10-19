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
  void onInitState() {
    // In the onInitwState the widget tree is not built yet hence the call to 
    // notifyListener() is not needed
    vmState.isLoading = true;
    _refreshArticleList();
  }

  @override
  Future<void> requestArticleList() async {
    startLoadingState();
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
      vmState.articleVisibilityList.clear();
      vmState.articleList.addAll(articles);
      vmState.articleVisibilityList.addAll(articles.map((e) => true));
    } catch (e) {
      vmState.hasError = true;
      if (e is ApiError) {
      } else {}
    }
    stopLoadingState();
  }

  @override
  void tapOnHideArticle(int index) {
    vmState.articleVisibilityList[index] = false;
    notifyListeners();
  }
}
