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
  //static const ValueKey<String> _homeRouter = ValueKey<String>('Home router');

  static final GoRouter simpleRouter = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: RoutesNames.home,
        path: '/',
        redirect: (_, __) => Routes.articles(),
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => FadeTransitionPage(
          key: state.pageKey,
          child: HomeView(navigationShell: navigationShell),
        ),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <GoRoute>[
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
