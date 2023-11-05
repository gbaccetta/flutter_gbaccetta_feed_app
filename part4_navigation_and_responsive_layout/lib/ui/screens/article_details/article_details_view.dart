import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_view_widget_state.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_contract.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  /// While this page is largely static, it contains an artificial loader. To showcase
  /// updating only a specific part of the UI, we've overridden this behavior.
  @override
  bool get autoSubscribeToVmStateChanges => false;

  @override
  void onInitState() {
    vmState.article = widget.article;
  }

  late double maxHeight;
  late double maxWidth;

  bool get _isPremiumStory => vmState.article.content.isEmpty;
  String get _improvedDescription => maxWidth > maxHeight
      ? vmState.article.description
          .replaceAll(RegExp('(width=".*?")'), 'height="${maxHeight * 0.95}"')
      : vmState.article.description
          .replaceAll(RegExp('(width=".*?")'), 'width="${maxWidth * 0.95}"');
  String get _improvedContent => maxWidth > maxHeight
      ? vmState.article.content
          .replaceAll('<img alt=', '<img height="${maxHeight * 0.6}" alt=')
      : vmState.article.content
          .replaceAll('<img alt=', '<img width="${maxWidth * 0.6}" alt=');
  String get _bodyHtml =>
      !_isPremiumStory ? _improvedContent : _improvedDescription;

  @override
  Widget contentBuilder(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      maxHeight = constraints.maxHeight;
      maxWidth = constraints.maxWidth;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Content',
            style: textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
        ),
        body: SizedBox.expand(
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Html(
                        data: _bodyHtml,
                        onLinkTap: (url, _, __) => vmContract.tapOnLink(url),
                        style: {
                          'html': Style(textAlign: TextAlign.center),
                        },
                      ),
                      if (_isPremiumStory)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Chip(label: Text('PREMIUM STORY')),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // We've included this selector widget here for demonstration purposes,
              // in contrast to the default implementation that uses viewConsumerWidget.
              viewSelectorWidget(
                selector: (vmState) => vmState.isLoading,
                builder: (_) => vmState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: vmContract.tapOnRefreshPage,
          child: const Icon(Icons.refresh),
        ),
      );
    });
  }

  @override
  void goToExternalLink(String url) {
    launchUrlString(url);
  }
}
