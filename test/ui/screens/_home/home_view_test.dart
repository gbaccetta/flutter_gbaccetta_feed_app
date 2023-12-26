import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_home/home_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../_mocks/mocked_components/generic_mocks.dart';
import '../../../utils/test_utils.dart';

void main() {
  late HomeView view;
  late MockNestedNavigator mockNestedNavigator;

  setUpAll(() {
    serviceLocatorForTestInitialization();
  });

  final bottomNavigationBar = find.byType(BottomNavigationBar);
  final navigationRail = find.byWidgetPredicate(
      (widget) => widget is NavigationRail && widget.extended == false);
  final navigationDrawer = find.byWidgetPredicate(
      (widget) => widget is NavigationRail && widget.extended == true);
  final selectedArticleTab = find.byIcon(Icons.article);
  final unselectedArticleTab = find.byIcon(Icons.article_outlined);
  final selectedUserTab = find.byIcon(Icons.person_2);
  final unselectedUserTab = find.byIcon(Icons.person_2_outlined);

  Future<void> init(
    WidgetTester tester, {
    int initialTab = 0,
    Size size = portrait,
  }) async {
    mockNestedNavigator = MockNestedNavigator();
    view = getIt<HomeView>(param1: mockNestedNavigator);
    when(() => mockNestedNavigator.currentIndex).thenReturn(initialTab);
    when(() => mockNestedNavigator.navigatorContainer).thenReturn(Container());
    await tester
        .pumpWidget(makeTestableWidget(child: view, mediaQuerySize: size));
    await tester.pumpAndSettle();
  }

  group('init -', () {
    testWidgets('on mobile', (tester) async {
      await init(tester, size: portrait);
      expect(bottomNavigationBar, findsOneWidget);
      expect(navigationRail, findsNothing);
      expect(navigationDrawer, findsNothing);
    });
    testWidgets('on medium screen', (tester) async {
      await init(tester, size: mediumScreen);
      expect(bottomNavigationBar, findsNothing);
      expect(navigationRail, findsOneWidget);
      expect(navigationDrawer, findsNothing);
    });
    testWidgets('on large screen', (tester) async {
      await init(tester, size: largeScreen);
      expect(bottomNavigationBar, findsNothing);
      expect(navigationRail, findsNothing);
      expect(navigationDrawer, findsOneWidget);
    });
  });

  group('navigation -', () {
    testWidgets('tap on user tab should navigate to user page', (tester) async {
      await init(tester);
      expect(selectedArticleTab, findsOneWidget);
      expect(selectedUserTab, findsNothing);
      await tester.tap(unselectedUserTab);
      await tester.pumpAndSettle();
      verify(() => mockNestedNavigator.goBranch(1));
    });
    testWidgets('tap on article page navigate to user page', (tester) async {
      await init(tester, initialTab: 1);
      expect(selectedArticleTab, findsNothing);
      expect(selectedUserTab, findsOneWidget);
      await tester.tap(unselectedArticleTab);
      await tester.pumpAndSettle();
      verifyNever(() => mockNestedNavigator.goBranch(0));
    });
  });
}
