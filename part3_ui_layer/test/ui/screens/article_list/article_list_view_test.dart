import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/api/endpoints.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_view.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_view.dart';
import 'package:flutter_gbaccetta_feed_app/ui/widgets/generic_widgets/screen_error_widget.dart';
import 'package:flutter_gbaccetta_feed_app/ui/widgets/model_widgets/article_card.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../_mocks/mocked_components/mock_client_adapter.dart';
import '../../../_mocks/mocked_data/endpoint/medium_rss_feed_mocked.dart';
import '../../../utils/test_utils.dart';

void main() {
  /// we start by defining the components that we will need to test and/or mock
  /// in functional test we should test end to end scenarios. Hence we need
  /// the entry point, the view itself and the what is on the other end of
  /// the architecture: the modules (whose we will be obviously mocking)
  late ArticleListView view;
  late MockClientAdapter mockClientAdapter;

  setUpAll(() {
    serviceLocatorForTestInitialization();
  });

  /// we define the finder we will be using to test our views
  final articleListView = find.byType(ArticleListView);
  final articleDetailsView = find.byType(ArticleDetailsView);
  final fab = find.byType(FloatingActionButton);
  final articleCard = find.byType(ArticleCard);
  final hideIconButton = find.byType(IconButton);
  final loader = find.byType(CircularProgressIndicator);
  final error = find.byType(ScreenErrorWidget);
  final coverPlaceholder = find.byType(CoverPlaceholder);
  final emptyListMessage = find.text('WOW!\n🚨\nNo articles in the list');

  Future<void> init(
    WidgetTester tester, {
    int apiResponseCodeMediumRssFeed = 200,
    String? apiResponseDataMediumRssFeed,
  }) async {
    view = const ArticleListView();
    mockClientAdapter = getIt<MockClientAdapter>();

    mockClientAdapter
        .onApiCall(ApiMethod.get, Endpoints.mediumRssFeed)
        .thenAnswer(
          apiResponseCodeMediumRssFeed,
          response:
              apiResponseDataMediumRssFeed ?? MediumRssFeedMocked().string_200,
        );

    await tester.pumpWidget(makeTestableWidget(child: view));
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
      await init(tester, apiResponseCodeMediumRssFeed: 400);
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
        apiResponseDataMediumRssFeed: MediumRssFeedMocked().string_200_2,
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
        // this mock value has an image without url
        apiResponseDataMediumRssFeed: MediumRssFeedMocked().string_200_3,
      );
      await tester.pumpAndSettle();
      await tester.runAsync(() => Future.delayed(milliseconds1));
      await tester.pumpAndSettle();

      expect(articleCard, findsNWidgets(2));
      expect(coverPlaceholder, findsOneWidget);
    });
  });

  testWidgets('tap On Article should open ArticleDetailsView', (tester) async {
    await init(tester);
    await tester.pumpAndSettle();
    await tester.tap(articleCard);
    await tester.pumpAndSettle();

    expect(articleDetailsView, findsOneWidget);
    expect(articleListView, findsNothing);
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
    testWidgets('should clear error than load 2 articles list', (tester) async {
      await init(
        tester,
        apiResponseCodeMediumRssFeed: 400,
      );
      await tester.pumpAndSettle();

      expect(articleCard, findsNothing);
      expect(emptyListMessage, findsNothing);
      expect(error, findsOneWidget);

      mockClientAdapter
          .onApiCall(ApiMethod.get, Endpoints.mediumRssFeed)
          .thenAnswer(200, response: MediumRssFeedMocked().string_200_3);

      await tester.tap(fab);
      await tester.pumpAndSettle();

      expect(articleCard, findsNWidgets(2));
      expect(error, findsNothing);
      expect(emptyListMessage, findsNothing);
    });

    testWidgets('from empty list to an error', (tester) async {
      await init(
        tester,
        apiResponseDataMediumRssFeed: MediumRssFeedMocked().string_200_2,
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
    });
  });
}
