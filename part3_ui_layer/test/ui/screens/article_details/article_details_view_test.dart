import 'package:flutter/material.dart';
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

  Future<void> init(WidgetTester tester) async {
    view = ArticleDetailsView(article: anyArticle);
    await tester.pumpWidget(makeTestableWidget(child: view));
  }

  testWidgets('init', (tester) async {
    await init(tester);
    await tester.pump();

    expect(content, findsOneWidget);
    expect(fab, findsOneWidget);
    expect(loader, findsNothing);
  });

  testWidgets('tap On Fab should show loader for 1 second', (tester) async {
    await init(tester);
    await tester.pump();
    await tester.tap(fab);
    await tester.pump();

    expect(loader, findsOneWidget);
    await tester.pump(milliseconds1000);
    expect(loader, findsNothing);
  });
}
