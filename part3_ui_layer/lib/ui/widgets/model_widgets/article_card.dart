import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    return Card(
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 140,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      // without at least a host cached network image throw
                      imageUrl: article.coverImage ?? 'https://',
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const _CoverPlaceholder(),
                      errorWidget: (_, __, ___) => const _CoverPlaceholder(),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                        alignment: Alignment.bottomLeft,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.white38,
                              Colors.white,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child:
                              Text(article.title, style: textTheme.titleLarge),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: article.keywords
                    .map((k) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Chip(label: Text(k)),
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
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.bottomLeft,
      color: const Color.fromARGB(255, 160, 255, 225),
      child: const Icon(Icons.article_rounded, size: 130, color: Colors.white),
    );
  }
}