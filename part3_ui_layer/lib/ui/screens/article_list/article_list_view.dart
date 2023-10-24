import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_view_widget_state.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_view.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_contract.dart';
import 'package:flutter_gbaccetta_feed_app/ui/widgets/generic_widgets/screen_error_widget.dart';
import 'package:flutter_gbaccetta_feed_app/ui/widgets/generic_widgets/screen_loader_widget.dart';
import 'package:flutter_gbaccetta_feed_app/ui/widgets/model_widgets/article_card.dart';

class ArticleListView extends StatefulWidget {
  const ArticleListView({super.key});

  @override
  State<ArticleListView> createState() => _ArticleListViewWidgetState();
}

class _ArticleListViewWidgetState extends BaseViewWidgetState<
    ArticleListView,
    ArticleListVMContract,
    ArticleListVMState> implements ArticleListViewContract {
  bool get _showList => vmState.articleList.isNotEmpty;
  bool get _showError => vmState.hasError && vmState.articleList.isEmpty;
  bool get _showPlaceholder =>
      !vmState.hasError &&
      !vmState.isLoading &&
      !vmState.articleVisibilityList.contains(true);
  @override
  void onInitState() {}

  @override
  Widget contentBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GBAccetta Portfolio',
          style: textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          if (_showList)
            ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: vmState.articleList.length,
              itemBuilder: (context, index) => AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: vmState.articleVisibilityList[index]
                    ? ArticleCard(
                        article: vmState.articleList[index],
                        onTap: () => vmContract.tapOnArticle(index),
                        onHideTap: () => vmContract.tapOnHideArticle(index),
                      )
                    : const SizedBox(),
              ),
            ),
          if (_showPlaceholder)
            const ScreenErrorWidget(
              error: 'WOW!\n🚨\nNo articles in the list',
            ),
          if (_showError)
            ScreenErrorWidget(onButtonTap: vmContract.tapOnRefreshArticleList),
          if (vmState.isLoading) const ScreenLoaderWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: vmContract.tapOnRefreshArticleList,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  @override
  void goToArticleDetailsScreen(int index) {
    // TODO: this is not the ideal way to navigate. We will explore navigation in part4 of our tutorial
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ArticleDetailsView(article: vmState.articleList[index]),
    ));
  }

  @override
  void showErrorRetrievingArticlesSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ouch 🚨! There was an error... 🤦‍♂️')),
    );
  }
}
