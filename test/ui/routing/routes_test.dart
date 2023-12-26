import 'package:flutter_gbaccetta_feed_app/ui/routing/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('articles route', () {
    expect(Routes.articles(), '/articles');
  });

  test('article route', () {
    const id = 'id';
    expect(Routes.article(id), '/articles/id');
  });

  test('user route', () {
    expect(Routes.user(), '/user');
  });
}
