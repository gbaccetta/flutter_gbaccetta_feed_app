import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';

abstract class ArticleUseCases {
  Future<List<Article>> getArticles();
}
