import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/article_list_provider.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/user.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/app_router.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/nested_navigator.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/routes.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/views.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../utils/test_utils.dart';

/// This abstract class represents a mocked view intended for testing navigation
/// in the app without concerning the actual logic in each page. This allows
/// testing URL-based navigation, deeplinks, and redirection without the need to
/// mock all the dependencies required by each page.
abstract class _MockView<T extends StatefulWidget> extends Mock {
  final NestedNavigator? nestedNavigator;
  _MockView({this.nestedNavigator});
  @override
  String toString({DiagnosticLevel? minLevel}) => super.toString();

  /// This method creates the actual widget. It's overridden in the mocked class
  /// to provide a fakeGoRouterPage, potentially containing a nestedNavigator.
  /// Here I user a trick including a key based on the mocked class name to easily
  /// test if the actual route has been correctly built by GoRouter
    StatefulElement createElement() => StatefulElement(_FakeGoRouterPage(
        key: Key(runtimeType.toString()),
        nestedNavigator: nestedNavigator,
      ));
}

/// Represents the Fake View containing only SizedBox or the nested navigator container.
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

/// We need to mock our views. Note that for the Mocked HomeView, 
/// the constructor mimics the real HomeView to enable
/// go_router to pass the nested navigator information.
class _MockHomeView extends _MockView implements HomeView {
  _MockHomeView({super.nestedNavigator});
  @override
  NestedNavigator get nestedNavigator => super.nestedNavigator!;
}

class _MockArticleListView extends _MockView<ArticleListView>
    implements ArticleListView {}

class _MockArticleDetailsView extends _MockView<ArticleDetailsView>
    implements ArticleDetailsView {}

class _MockUserSettingsView extends _MockView<UserSettingsView>
    implements UserSettingsView {}

void main() {
  setUpAll(() {
    getIt.registerFactoryParam<HomeView, NestedNavigator, void>(
        (nestedNav, _) => _MockHomeView(nestedNavigator: nestedNav));
    getIt.registerFactory<ArticleListView>(() => _MockArticleListView());
    getIt.registerFactory<ArticleDetailsView>(() => _MockArticleDetailsView());
    getIt.registerFactory<UserSettingsView>(() => _MockUserSettingsView());
  });

  final homeView = find.byKey(const Key('_MockHomeView'));
  final articleListView = find.byKey(const Key('_MockArticleListView'));
  final articleDetailsView = find.byKey(const Key('_MockArticleDetailsView'));
  final userView = find.byKey(const Key('_MockUserSettingsView'));

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
