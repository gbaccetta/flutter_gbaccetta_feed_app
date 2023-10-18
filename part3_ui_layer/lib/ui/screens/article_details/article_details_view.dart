import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_view_widget_state.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_contract.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticleDetailsView extends StatefulWidget {
  final Article article;
  const ArticleDetailsView({super.key, required this.article});

  @override
  State<ArticleDetailsView> createState() => _ArticleDetailsViewWidgetState();
}

class _ArticleDetailsViewWidgetState extends BaseViewWidgetState<
    ArticleDetailsView,
    ArticleDetailsVMContract,
    ArticleDetailsVMState> implements ArticleDetailsViewContract {
  @override
  void onInitState() {
    vmState.article = widget.article;
  }

  @override
  Widget Function(BuildContext) contentBuilder() {
    return (context) => Scaffold(
          appBar: AppBar(
            title: Text('Content', style: textTheme.titleLarge),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Html(data: vmState.article.content),
          ),
        );
  }
}
