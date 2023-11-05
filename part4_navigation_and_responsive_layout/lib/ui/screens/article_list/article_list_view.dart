import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/article_list.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/routes.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_view_widget_state.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_contract.dart';
import 'package:flutter_gbaccetta_feed_app/ui/widgets/generic_widgets/screen_error_widget.dart';
import 'package:flutter_gbaccetta_feed_app/ui/widgets/generic_widgets/screen_loader_widget.dart';
import 'package:flutter_gbaccetta_feed_app/ui/widgets/model_widgets/article_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ArticleListView extends StatefulWidget {
  final String? initialArticleId;
  const ArticleListView({super.key, this.initialArticleId});

  @override
  State<ArticleListView> createState() => _ArticleListViewWidgetState();
}

class _ArticleListViewWidgetState extends BaseViewWidgetState<
    ArticleListView,
    ArticleListVMContract,
    ArticleListVMState> implements ArticleListViewContract {
  late double maxCardWidth;
  bool get _showList => vmState.articleList.isNotEmpty;
  bool get _showError => vmState.hasError && vmState.articleList.isEmpty;
  bool get _showPlaceholder =>
      !vmState.hasError &&
      !vmState.isLoading &&
      !vmState.articleVisibilityList.contains(true);
  @override
  void onInitState() {
    vmState.articleListProvider = context.read<ArticleListProvider>();
    vmState.initialArticleId = widget.initialArticleId;
  }

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(builder: (context, constraints) {
                maxCardWidth =
                    constraints.maxWidth / (constraints.maxWidth ~/ 300);
                return SingleChildScrollView(
                  child: Wrap(
                    children: List.generate(
                      vmState.articleList.length,
                      (index) => _articleListItem(index),
                    ),
                  ),
                );
              }),
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

  Widget _articleListItem(int index) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxCardWidth),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: vmState.articleVisibilityList[index]
              ? _article(index)
              : TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 1, end: 0),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, animatedValue, child) {
                    if (animatedValue == 0) {
                      return const SizedBox();
                    }
                    return Opacity(
                      opacity: animatedValue,
                      child: _article(index),
                    );
                  },
                ),
        ));
  }

  ArticleCard _article(int index) {
    return ArticleCard(
      key: Key(index.toString()),
      article: vmState.articleList[index],
      onTap: () => vmContract.tapOnArticle(index),
      onHideTap: () => vmContract.tapOnHideArticle(index),
    );
  }

  @override
  void goToArticleDetailsScreen(int index) {
    context.goNamed(
      RoutesNames.articleDetails,
      pathParameters: {PathParams.articleId: vmState.articleList[index].id},
    );
  }

  @override
  void showErrorRetrievingArticlesSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ouch 🚨! There was an error... 🤦‍♂️')),
    );
  }
}
