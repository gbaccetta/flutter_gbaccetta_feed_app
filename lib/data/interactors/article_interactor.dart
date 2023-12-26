import 'package:flutter_gbaccetta_feed_app/data/modules/api/api_service.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_gbaccetta_feed_app/domain/use_cases/article_use_cases.dart';
import 'package:webfeed_plus/webfeed_plus.dart';

class ArticleInteractor implements ArticleUseCases {
  final ApiService apiService;

  ArticleInteractor({required this.apiService});

  @override
  Future<List<Article>> getArticles() async {
    final response = await apiService.getMediumRssFeed();
    final rssFeed = RssFeed.parse(response.data);
    return rssFeed.items?.map((e) => Article.fromRssItem(e)).toList() ?? [];
  }
}
