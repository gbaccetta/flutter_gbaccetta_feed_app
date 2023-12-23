import 'package:flutter_gbaccetta_feed_app/data/modules/api/api_service.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/services/shared_prefs_service.dart';
import 'package:flutter_gbaccetta_feed_app/domain/use_cases/article_use_cases.dart';
import 'package:flutter_gbaccetta_feed_app/domain/use_cases/settings_use_cases.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/nested_navigator.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

class MockSharedPrefsService extends Mock implements SharedPrefsService {}

class MockArticleInteractor extends Mock implements ArticleUseCases {}

class MockSettingsInteractor extends Mock implements SettingsUseCases {}

class MockNestedNavigator extends Mock implements NestedNavigator {}
