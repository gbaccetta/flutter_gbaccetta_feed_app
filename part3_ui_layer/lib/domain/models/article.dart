
import 'package:webfeed_plus/webfeed_plus.dart';

class Article {
  final String title;
  final String description;
  final String content;
  final List<String> keywords;
  final String url;
  final DateTime date;
  final String? coverImage;

  Article({
    required this.title,
    required this.description,
    required this.content,
    required this.keywords,
    required this.url,
    required this.date,
    this.coverImage,
  });

  factory Article.fromRssItem(RssItem item) {
    return Article(
      title: item.title ?? '',
      description: item.description ?? '',
      content: item.content?.value ?? '',
      keywords: item.categories?.map((e) => e.value).toList() ?? [],
      url: item.link ?? '',
      date: item.pubDate ?? DateTime.now(),
      coverImage: item.content?.images.firstOrNull,
    );
  }
}

