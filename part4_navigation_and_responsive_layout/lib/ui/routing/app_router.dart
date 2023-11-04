import 'package:flutter/widgets.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/article_list.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/fade_in_transition_page.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/routes.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_home/home_view.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_view.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {

  static final GoRouter simpleRouter = GoRouter(
    routes: <RouteBase>[
      // home will redirect to the articlesView route where the main content is
      GoRoute(
        name: RoutesNames.home,
        path: '/',
        redirect: (_, __) => Routes.articles(),
      ),
      // at the top level of our router, we will use a StatefulShellRoute
      // an indexed stack will just use an index starting at 0 for the sub branch
      StatefulShellRoute.indexedStack(
        // we will use a fade transition page to better fit all platform navigation
        // pattern. On the web for instance, the default material transition is
        // not ideal compared to the usual standard navigation pattern
        pageBuilder: (context, state, navigationShell) => FadeTransitionPage(
          key: state.pageKey,
          child: HomeView(navigationShell: navigationShell),
        ),
        // The difference between a ShellRoute and a StatefulShellRoute is that
        // the StatefulShellRoute contains a list of branches with its separate
        // navigation stack instead of a list of routes.
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            // our articles tab will correspond to branch with index 0
            routes: <GoRoute>[
              // it will contains a first route for the article list
              GoRoute(
                name: RoutesNames.articles,
                path: '/${PathSegments.articles}',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  final id = state.uri.queryParameters['query']; // may be null
                  return FadeTransitionPage(
                    key: state.pageKey,
                    child: ArticleListView(initialArticleId: id),
                  );
                },
                routes: <GoRoute>[
                  // the article details will be a child of a the article list
                  GoRoute(
                    name: RoutesNames.articleDetails,
                    path: ':${PathParams.articleId}',
                    builder: (BuildContext context, GoRouterState state) {
                      final articleList =
                          context.read<ArticleList>().articleList;
                      final String id =
                          state.pathParameters[PathParams.articleId]!;
                      final article = articleList.firstWhere((e) => e.id == id);
                      return ArticleDetailsView(article: article);
                    },
                    redirect: (BuildContext context, GoRouterState state) {
                      final articleList =
                          context.read<ArticleList>().articleList;
                      final String id =
                          state.pathParameters[PathParams.articleId]!;
                      if (articleList.any((e) => e.id == id)) return null;
                      // if we did not find the id in the list of articles of the
                      // articleList provider (e.g. on app startup)
                      // we will redirect to articleList to refresh the list and query
                      // for this specific article with an optional query parameter
                      return '/${PathSegments.articles}?${PathParams.articleId}=$id';
                    },
                  ),
                ],
              ),
            ],
          ),
          //The user page will correspond to branch with index 1
          // but in our example app it will only contain a dummy page
          StatefulShellBranch(
            routes: <GoRoute>[
              GoRoute(
                name: RoutesNames.user,
                path: '/${PathSegments.user}',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return FadeTransitionPage(
                    key: state.pageKey,
                    child: const Center(child: Text('User page')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
    debugLogDiagnostics: true,
  );
}
