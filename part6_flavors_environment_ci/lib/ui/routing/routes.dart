class PathParams {
  static const articleId = 'id';
}

class PathSegments {
  static const articles = 'articles';
  static const user = 'user';
}

class RoutesNames {
  static const home = 'home';
  static const articles = 'articles';
  static const articleDetails = 'article';
  static const user = 'user';
}

class Routes {
  static articles() => '/${PathSegments.articles}';
  static user() => '/${PathSegments.user}';
  static article(String id) => '/${PathSegments.articles}/$id';
}
