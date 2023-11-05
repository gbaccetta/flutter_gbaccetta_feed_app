import 'package:flutter/foundation.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';

class ArticleListProvider extends ChangeNotifier {
  late final List<Article> articleList;
  /// This constructor allow to initialize the provider with a specific list
  /// during view functional tests 
  ArticleListProvider({List<Article>? articleList}) {
    this.articleList = articleList ?? List.empty(growable: true);
  }
}
