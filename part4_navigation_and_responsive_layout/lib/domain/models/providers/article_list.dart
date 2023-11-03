import 'package:flutter/foundation.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';

class ArticleList extends ChangeNotifier {
  final List<Article> articleList = List.empty(growable: true);
}
