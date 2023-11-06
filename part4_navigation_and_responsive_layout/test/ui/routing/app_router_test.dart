import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/article_list.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/user.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/app_router.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/nested_navigator.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/routes.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_home/home_view.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_view.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../utils/test_utils.dart';

/// We want to be able to test navigation in the app without caring about the
/// actual logic in each page. This will allow to tests all the url based
/// navigation as well as deeplink and redirection without having to mock all
/// the dependencies required by each page
abstract class _MockView<T extends StatefulWidget> extends Mock {
  final NestedNavigator? nestedNavigator;
  _MockView({this.nestedNavigator});
  @override
  String toString({DiagnosticLevel? minLevel}) => super.toString();

  /// this method is what create the actual widget, hence we override it in our
  /// mocked class to actually provide a fakeGoRouterPage that may contains a
  /// nestedNavigator (such as the StatefulShellRoute that is our HomeView)
  StatefulElement createElement() => StatefulElement(_FakeGoRouterPage(
        key: Key(runtimeType.toString()),
        nestedNavigator: nestedNavigator,
      ));
}

/// This class is our actual Fake View containing only SizedBox or the nested
/// navigatorContainer
class _FakeGoRouterPage extends StatefulWidget {
  final NestedNavigator? nestedNavigator;
  const _FakeGoRouterPage({super.key, this.nestedNavigator});
  @override
  State<StatefulWidget> createState() => _FakeGoRouterPageState();
}

class _FakeGoRouterPageState extends State<_FakeGoRouterPage> {
  @override
  Widget build(BuildContext context) => SizedBox(
        child: widget.nestedNavigator?.navigatorContainer ?? const SizedBox(),
      );
}

/// Finally we need to mock our views. Note that we need to have the constructor
/// of the MockHomeView mimic the real HomeView to let go_router actually pass
/// the nested navigator informations.
class _MockHomeView extends _MockView implements HomeView {
  _MockHomeView({super.nestedNavigator});
  @override
  NestedNavigator get nestedNavigator => super.nestedNavigator!;
}

class _MockArticleListView extends _MockView<ArticleListView>
    implements ArticleListView {}

class _MockArticleDetailsView extends _MockView<ArticleDetailsView>
    implements ArticleDetailsView {}

void main() {
  setUpAll(() {
    getIt.registerFactoryParam<HomeView, NestedNavigator, void>(
        (nestedNav, _) => _MockHomeView(nestedNavigator: nestedNav));
    getIt.registerFactory<ArticleListView>(() => _MockArticleListView());
    getIt.registerFactory<ArticleDetailsView>(() => _MockArticleDetailsView());
  });

  //final homeView = find.byType(HomeView);
  final homeView = find.byKey(const Key('_MockHomeView'));
  final articleListView = find.byKey(const Key('_MockArticleListView'));
  final articleDetailsView = find.byKey(const Key('_MockArticleDetailsView'));
  final userView = find.text('User page');

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
    expect(userView, findsNothing);
  });

  testWidgets('navigate to user view and back', (tester) async {
    await init(tester);
    BuildContext context = tester.element(homeView);
    context.go(Routes.user());
    await tester.pumpAndSettle();

    expect(articleListView, findsNothing);
    expect(userView, findsOneWidget);

    context = tester.element(homeView);
    context.go(Routes.articles());
    await tester.pumpAndSettle();

    expect(articleListView, findsOneWidget);
    expect(userView, findsNothing);
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
