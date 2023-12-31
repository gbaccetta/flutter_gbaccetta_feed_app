import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_view.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../utils/test_utils.dart';

void main() {
  /// we start by defining the components that we will need to test and/or mock
  /// in functional test we should test end to end scenarios. Hence we need
  /// the entry point, the view itself and the what is on the other end of
  /// the architecture: the modules (whose we will be obviously mocking)
  late ArticleDetailsView view;

  setUpAll(() {
    serviceLocatorForTestInitialization();
  });

  /// we define the finder we will be using to test our views
  final fab = find.byType(FloatingActionButton);
  final content = find.byType(Html);
  final loader = find.byType(CircularProgressIndicator);
  final link = find.text('content');
  final description = find.text('description');

  Future<void> init(WidgetTester tester, {Article? article}) async {
    view = getIt<ArticleDetailsView>(param1: article ?? anyArticle);
    await tester.pumpWidget(makeTestableWidget(child: view));
    await tester.pumpAndSettle();
  }

  group('init -', () {
    testWidgets('with anyArticle in portrait', (tester) async {
      await tester.binding.setSurfaceSize(portrait);
      await init(tester);

      expect(content, findsOneWidget);
      expect(fab, findsOneWidget);
      expect(loader, findsNothing);
      expect(link, findsOneWidget);
      expect(description, findsNothing);
    });

    // this is added mainly for coverage since we modify img tag differently in
    // landscape than in portrait
    testWidgets('with anyArticle in landscape', (tester) async {
      await tester.binding.setSurfaceSize(landscape);
      await init(tester);

      expect(content, findsOneWidget);
      expect(fab, findsOneWidget);
      expect(loader, findsNothing);
      expect(link, findsOneWidget);
      expect(description, findsNothing);
    });

    testWidgets('with premiumArticle portrait', (tester) async {
      await tester.binding.setSurfaceSize(portrait);
      await init(tester, article: anyPremiumArticle);

      expect(content, findsOneWidget);
      expect(fab, findsOneWidget);
      expect(loader, findsNothing);
      expect(link, findsNothing);
      expect(description, findsOneWidget);
    });

    // this is added mainly for coverage since we modify img tag differently in
    // landscape than in portrait
    testWidgets('with premiumArticle landscape', (tester) async {
      await tester.binding.setSurfaceSize(landscape);
      await init(tester, article: anyPremiumArticle);

      expect(content, findsOneWidget);
      expect(fab, findsOneWidget);
      expect(loader, findsNothing);
      expect(link, findsNothing);
      expect(description, findsOneWidget);
    });
  });

  testWidgets('tap On Fab should show loader for 1 second', (tester) async {
    await init(tester);
    await tester.tap(fab);
    await tester.pump();

    expect(loader, findsOneWidget);
    await tester.pump(seconds1);
    expect(loader, findsNothing);
  });

  testWidgets('tap On link should launch url in browser', (tester) async {
    await init(tester);
    await tester.tap(link);
    await tester.pumpAndSettle();
    // this test does not have any expect or verify method on purpose. In fact
    // launchUrl is managed by the OS, hence we cannot really verify the result
  });
}
