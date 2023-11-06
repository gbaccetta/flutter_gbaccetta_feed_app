import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/api/endpoints.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/article_list.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/user.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/routes.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_view.dart';
import 'package:flutter_gbaccetta_feed_app/ui/widgets/generic_widgets/screen_error_widget.dart';
import 'package:flutter_gbaccetta_feed_app/ui/widgets/model_widgets/article_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../_mocks/mocked_components/mock_client_adapter.dart';
import '../../../_mocks/mocked_components/mock_go_router.dart';
import '../../../_mocks/mocked_data/endpoint/medium_rss_feed_mocked.dart';
import '../../../utils/test_utils.dart';

void main() {
  /// we start by defining the components that we will need to test and/or mock
  /// in functional test we should test end to end scenarios. Hence we need
  /// the entry point, the view itself and the what is on the other end of
  /// the architecture: the modules (whose we will be obviously mocking)
  late ArticleListView view;
  late MockClientAdapter mockClientAdapter;
  late MockGoRouter mockGoRouter;

  setUpAll(() {
    serviceLocatorForTestInitialization();
  });

  /// we define the finder we will be using to test our views
  final fab = find.byType(FloatingActionButton);
  final articleCard = find.byType(ArticleCard);
  final hideIconButton = find.byType(IconButton);
  final loader = find.byType(CircularProgressIndicator);
  final error = find.byType(ScreenErrorWidget);
  final coverPlaceholder = find.byType(CoverPlaceholder);
  final emptyListMessage = find.text('WOW!\n🚨\nNo articles in the list');
  final errorSnackBar = find.text('Ouch 🚨! There was an error... 🤦‍♂️');
  const articleId = 'https://medium.com/p/e1131f7c0355';

  Future<void> init(
    WidgetTester tester, {
    String? initialArticleId,
    List<Article>? initialArticleList,
    int? apiMediumRssFeedCode,
    String? apiMediumRssFeedData,
  }) async {
    view = getIt<ArticleListView>(param1: initialArticleId);
    mockClientAdapter = getIt<MockClientAdapter>();

    /// since mockGoRouter does not required any injected dependency, we
    /// do not need to use getIt as for the ClientAdapter requiring ApiService
    mockGoRouter = MockGoRouter();

    mockClientAdapter
        .onApiCall(ApiMethod.get, Endpoints.mediumRssFeed)
        .thenAnswer(
          apiMediumRssFeedCode ?? 200,
          response:
              apiMediumRssFeedData ?? MediumRssFeedMocked.string200OneArticle,
        );

    await tester.pumpWidget(
      makeTestableWidget(
        child: view,
        mockGoRouter: mockGoRouter,
        testProviders: [
          ChangeNotifierProvider<User>(
              create: (_) => User(id: 'id', name: 'name')),
          ChangeNotifierProvider<ArticleListProvider>(
              create: (_) =>
                  ArticleListProvider(articleList: initialArticleList)),
        ],
      ),
    );
  }

  group('init -', () {
    testWidgets('successful initialization', (tester) async {
      await init(tester);
      await tester.pump();

      expect(loader, findsOneWidget);
      expect(error, findsNothing);
      expect(articleCard, findsNothing);

      await tester.pumpAndSettle();

      expect(loader, findsNothing);
      expect(error, findsNothing);
      expect(articleCard, findsOneWidget);
    });

    testWidgets('fail with api error', (tester) async {
      await init(tester, apiMediumRssFeedCode: 400);
      await tester.pump();

      expect(loader, findsOneWidget);
      expect(error, findsNothing);
      expect(articleCard, findsNothing);

      await tester.pumpAndSettle();

      expect(loader, findsNothing);
      expect(error, findsOneWidget);
      expect(articleCard, findsNothing);
      expect(emptyListMessage, findsNothing);
    });

    testWidgets('return an empty list', (tester) async {
      await init(
        tester,
        apiMediumRssFeedData: MediumRssFeedMocked.string200EmptyList,
      );
      await tester.pump();

      expect(loader, findsOneWidget);
      expect(error, findsNothing);
      expect(articleCard, findsNothing);

      await tester.pumpAndSettle();

      expect(loader, findsNothing);
      expect(error, findsOneWidget);
      expect(articleCard, findsNothing);
      expect(emptyListMessage, findsOneWidget);
    });

    testWidgets('render error placeholder for the cover', (tester) async {
      await init(
        tester,
        // this mock value has two articles, one with a valid image url and
        // one with an invalid url, hence we expect only one placeholder
        apiMediumRssFeedData: MediumRssFeedMocked.string200TwoArticles,
      );
      await tester.pumpAndSettle();
      // this is a trick to have the cached_network_image actually process the
      // mocked cache manager values
      await tester.runAsync(() => Future.delayed(milliseconds10));
      await tester.pumpAndSettle();

      expect(articleCard, findsNWidgets(2));
      expect(coverPlaceholder, findsOneWidget);
    });
  });

  group('navigation -', () {
    testWidgets('tap On Article should open ArticleDetailsView',
        (tester) async {
      await init(tester);
      await tester.pumpAndSettle();
      await tester.tap(articleCard);
      await tester.pumpAndSettle();

      verify(
        () => mockGoRouter.goNamed(
          RoutesNames.articleDetails,
          pathParameters: {PathParams.articleId: articleId},
        ),
      );
    });

    group('deep link with initialArticleId -', () {
      group('articles already fetched -', () {
        testWidgets('navigate if in articleList', (tester) async {
          await init(
            tester,
            initialArticleId: anyArticle.id,
            initialArticleList: [anyArticle],
          );
          await tester.pumpAndSettle();

          verify(
            () => mockGoRouter.goNamed(
              RoutesNames.articleDetails,
              pathParameters: {PathParams.articleId: anyArticle.id},
            ),
          );
        });

        testWidgets('do not navigate if not in articleList', (tester) async {
          await init(
            tester,
            initialArticleId: 'anyOtherId',
            initialArticleList: [anyArticle],
          );
          await tester.pumpAndSettle();

          verifyNever(
            () => mockGoRouter.goNamed(
              RoutesNames.articleDetails,
              pathParameters: {PathParams.articleId: articleId},
            ),
          );
        });
      });
      group('articles fetched on opening -', () {
        testWidgets('navigate to it if in the api result', (tester) async {
          await init(
            tester,
            initialArticleId: articleId,
            initialArticleList: [],
          );
          await tester.pumpAndSettle();

          verify(
            () => mockGoRouter.goNamed(
              RoutesNames.articleDetails,
              pathParameters: {PathParams.articleId: articleId},
            ),
          );
        });

        testWidgets('do not navigate if not in the api result', (tester) async {
          await init(
            tester,
            initialArticleId: 'anyOtherId',
            initialArticleList: [],
          );
          await tester.pumpAndSettle();

          verifyNever(
            () => mockGoRouter.goNamed(
              RoutesNames.articleDetails,
              pathParameters: {PathParams.articleId: articleId},
            ),
          );
        });
      });
    });
  });

  testWidgets('tap On Hide Article should leave an empty list', (tester) async {
    await init(tester);
    await tester.pumpAndSettle();
    await tester.tap(hideIconButton);
    await tester.pumpAndSettle();

    expect(articleCard, findsNothing);
    expect(emptyListMessage, findsOneWidget);
  });

  group('tap on fab -', () {
    group('successful refresh -', () {
      testWidgets('from existing list - load new list', (tester) async {
        // init the view with a one article list
        await init(
          tester,
          apiMediumRssFeedData: MediumRssFeedMocked.string200OneArticle,
        );
        await tester.pumpAndSettle();

        expect(articleCard, findsOneWidget);

        // tell our mocked client adaptor that next request should succeed
        mockClientAdapter
            .onApiCall(ApiMethod.get, Endpoints.mediumRssFeed)
            .thenAnswer(200,
                response: MediumRssFeedMocked.string200TwoArticles);

        await tester.tap(fab);
        await tester.pumpAndSettle();

        expect(articleCard, findsNWidgets(2));
      });
      testWidgets('clear initial error - load new list', (tester) async {
        // init the view with an error code 400 on the api call
        await init(
          tester,
          apiMediumRssFeedCode: 400,
        );
        await tester.pumpAndSettle();

        expect(articleCard, findsNothing);
        expect(emptyListMessage, findsNothing);
        expect(error, findsOneWidget);

        // tell our mocked client adaptor that next request should succeed
        mockClientAdapter
            .onApiCall(ApiMethod.get, Endpoints.mediumRssFeed)
            .thenAnswer(200,
                response: MediumRssFeedMocked.string200TwoArticles);

        await tester.tap(fab);
        await tester.pumpAndSettle();

        expect(articleCard, findsNWidgets(2));
        expect(error, findsNothing);
        expect(emptyListMessage, findsNothing);
      });
    });
    group('get api error -', () {
      testWidgets('from empty list - show error and snackbar', (tester) async {
        await init(
          tester,
          apiMediumRssFeedData: MediumRssFeedMocked.string200EmptyList,
        );
        await tester.pumpAndSettle();

        expect(articleCard, findsNothing);
        expect(emptyListMessage, findsOneWidget);

        mockClientAdapter
            .onApiCall(ApiMethod.get, Endpoints.mediumRssFeed)
            .thenAnswer(400);

        await tester.tap(fab);
        await tester.pumpAndSettle();

        expect(articleCard, findsNothing);
        expect(error, findsOneWidget);
        expect(emptyListMessage, findsNothing);
        expect(errorSnackBar, findsOneWidget);

        //wait for snackbar to disappear
        await tester.pumpAndSettle(seconds10);

        expect(errorSnackBar, findsNothing);
      });

      testWidgets('from full list - keep list but show snackbar',
          (tester) async {
        await init(
          tester,
          apiMediumRssFeedData: MediumRssFeedMocked.string200TwoArticles,
        );
        await tester.pumpAndSettle();

        expect(articleCard, findsNWidgets(2));

        mockClientAdapter
            .onApiCall(ApiMethod.get, Endpoints.mediumRssFeed)
            .thenAnswer(400);

        await tester.tap(fab);
        await tester.pumpAndSettle();

        expect(articleCard, findsNWidgets(2));
        expect(error, findsNothing);
        expect(errorSnackBar, findsOneWidget);

        //wait for snackbar to disappear
        await tester.pumpAndSettle(seconds10);

        expect(errorSnackBar, findsNothing);
      });
    });
  });
}
