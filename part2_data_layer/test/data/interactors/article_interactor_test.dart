import 'package:dio/dio.dart';
import 'package:flutter_gbaccetta_feed_app/data/interactors/article_interactor.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../_mocks/mocked_data/endpoint/medium_rss_feed_mocked.dart';
import '../../_mocks/mocked_components/generic_mocks.dart';

void main() {
  ArticleInteractor? articleInteractor;
  final mockApiService = MockApiService();

  setUp(() {
    articleInteractor = ArticleInteractor(apiService: mockApiService);
  });

  test('Successfully get articles from RSS fields', () async {
    when(() => mockApiService.getMediumRssFeed()).thenAnswer(
      (_) => Future.value(
        Response(
          data: MediumRssFeedMocked.string_200,
          requestOptions: RequestOptions(),
        ),
      ),
    );

    final result = await articleInteractor!.getArticles();

    verify(() => mockApiService.getMediumRssFeed());
    expect(result.length, 1);
    expect(result.first, isInstanceOf<Article>());
  });
}
