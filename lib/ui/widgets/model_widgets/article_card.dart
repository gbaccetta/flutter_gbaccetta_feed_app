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
              clipBehavior: Clip.antiAlias,
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
            height: 295,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 105, 20, 8),
              child: Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
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
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: article.keywords
                            .map((k) => Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Chip(label: Text(k)),
                                ))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 28,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: onHideTap,
                              iconSize: 24,
                              icon: const Icon(Icons.remove_red_eye),
                            ),
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
      color: Theme.of(context).colorScheme.primary,
      child: Icon(
        Icons.article_rounded,
        size: 130,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
