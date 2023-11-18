import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:intl/intl.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final Function() onTap;
  final Function() onHideTap;
  const ArticleCard({
    super.key,
    required this.article,
    required this.onTap,
    required this.onHideTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          SizedBox(
            height: 160,
            width: double.infinity,
            child: Card(
              elevation: 16,
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: article.coverImage == null
                  ? const CoverPlaceholder()
                  : CachedNetworkImage(
                      imageUrl: article.coverImage!,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const CoverPlaceholder(),
                      errorWidget: (_, __, ___) => const CoverPlaceholder(),
                      cacheManager: getIt<BaseCacheManager>(),
                    ),
            ),
          ),
          SizedBox(
            height: 270,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 95, 20, 8),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                        child: Text(
                          article.title,
                          style: textTheme.titleMedium,
                          maxLines: 3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: article.keywords
                            .map((k) => Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Chip(
                                    label: Text(
                                      k,
                                    ),
                                    backgroundColor: Colors.green.shade100,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: onHideTap,
                            icon: const Icon(Icons.remove_red_eye),
                          ),
                          Text(
                            DateFormat('dd MMMM yyyy').format(article.date),
                            textAlign: TextAlign.end,
                            style: textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// we make this visible for testing to check cached_network_image behavior
@visibleForTesting
class CoverPlaceholder extends StatelessWidget {
  const CoverPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.green,
      child: const Icon(Icons.article_rounded, size: 130, color: Colors.white),
    );
  }
}
