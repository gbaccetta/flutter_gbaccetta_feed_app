import 'package:flutter_gbaccetta_feed_app/data/modules/api/api_service.dart';
import 'package:flutter_gbaccetta_feed_app/domain/use_cases/article_use_cases.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/nested_navigator.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

class MockArticleInteractor extends Mock implements ArticleUseCases {}

class MockNestedNavigator extends Mock implements NestedNavigator {}
