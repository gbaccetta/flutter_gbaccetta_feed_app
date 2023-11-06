import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/article_list.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/user.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/app_router.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/routes.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_home/home_view.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_view.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../utils/test_utils.dart';

class _FakeView extends StatefulWidget {
  const _FakeView({super.key});
  @override
  State<StatefulWidget> createState() => _FakeViewState();
}

class _FakeViewState extends State<_FakeView> {
  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}

abstract class MockView<T extends StatefulWidget> extends Mock {
  @override
  String toString({DiagnosticLevel? minLevel}) => super.toString();
  StatefulElement createElement() => StatefulElement(_FakeView(
        key: Key(runtimeType.toString()),
      ));
  State<T> createState() => _EmptyState();
}

class _EmptyState<T extends StatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}

class MockArticleListView extends MockView<ArticleListView>
    implements ArticleListView {}

class MockHomeView extends MockView implements HomeView {}

class MockArticleDetailsView extends MockView<ArticleDetailsView>
    implements ArticleDetailsView {}

void main() {
  setUpAll(() {
    serviceLocatorForTestInitialization();
    getIt.unregister<ArticleListView>();
    getIt.unregister<ArticleDetailsView>();
    getIt.registerFactory<ArticleListView>(() => MockArticleListView());
    getIt.registerFactory<ArticleDetailsView>(() => MockArticleDetailsView());
  });

  final homeView = find.byType(HomeView);
  final articleListView = find.byKey(const Key('MockArticleListView'));
  final articleDetailsView = find.byKey(const Key('MockArticleDetailsView'));
  final userView = find.text('User');

  Future<void> init(
    WidgetTester tester, {
    List<ChangeNotifierProvider>? testProviders,
  }) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: testProviders ?? defaultTestProviders,
        child: MaterialApp.router(
          routerConfig: AppRouter.simpleRouter,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('init - home should be articleListView', (tester) async {
    await init(tester);
    expect(homeView, findsOneWidget);
    expect(articleListView, findsOneWidget);
    expect(articleDetailsView, findsNothing);
  });

  testWidgets('navigate to user view and back', (tester) async {
    await init(tester);
    final BuildContext context = tester.element(homeView);
    context.go(Routes.user());
    await tester.pumpAndSettle();

    expect(articleListView, findsNothing);
    expect(userView, findsOneWidget);

    context.go(Routes.articles());
    await tester.pumpAndSettle();

    expect(articleListView, findsOneWidget);
  });

  testWidgets(
      'navigate to article details should redirect to articleList if articleListProvider is empty',
      (tester) async {
    await init(tester);
    final BuildContext context = tester.element(homeView);
    context.go(Routes.article(anyArticle.id));
    await tester.pumpAndSettle();
    expect(articleListView, findsOneWidget);
    expect(articleDetailsView, findsNothing);
  });

  testWidgets(
      'navigate to article details should open article if present in articleListProvider',
      (tester) async {
    final testProviders = [
      ChangeNotifierProvider<ArticleListProvider>(
        create: (_) => ArticleListProvider(articleList: [anyArticle]),
      ),
      ChangeNotifierProvider<User>(create: (_) => User(id: 'id', name: 'name')),
    ];

    await init(tester, testProviders: testProviders);
    final BuildContext context = tester.element(homeView);
    context.go(Routes.article(anyArticle.id));
    await tester.pumpAndSettle();
    expect(articleDetailsView, findsOneWidget);
    expect(articleListView, findsNothing);
  });
}
