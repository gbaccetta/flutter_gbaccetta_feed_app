import 'package:flutter_gbaccetta_feed_app/domain/failures/api_error.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/article_list.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_contract.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_mocks/mocked_components/generic_mocks.dart';
import '../../../utils/test_utils.dart';

class MockArticleListView extends Mock implements ArticleListViewContract {}

void main() {
  // create an instance of the viewModel and the viewModelState
  late ArticleListViewModel viewModel;
  late ArticleListVMState vmState;

  // create a mocked instance of the component surrounding the viewModel
  late MockArticleListView mockView;
  late MockArticleInteractor mockArticleInteractor;

  // this will run before each test, to setup our environment anew
  setUp(() {
    mockView = MockArticleListView();
    vmState = ArticleListVMState();
    mockArticleInteractor = MockArticleInteractor();
    viewModel = ArticleListViewModel(articleInteractor: mockArticleInteractor);
    viewModel.viewContract = mockView;
    viewModel.vmState = vmState;

    /// we initialize the provider as normally done by the view when binding.
    viewModel.vmState.articleListProvider = ArticleListProvider();
  });

  group('onInitState -', () {
    group('no initial list -', () {
      group('successfully get articles -', () {
        test('populate list and set visibility to true', () async {
          vmState.initialArticleId = null;
          // set initial state and define mock behavior
          when(() => mockArticleInteractor.getArticles()).thenAnswer(
            (_) => Future.value([anyArticle]),
          );

          // invoke method
          viewModel.onInitState();

          // check result
          expect(vmState.isLoading, isTrue);
          verify(() => mockArticleInteractor.getArticles());

          // check async result
          await Future.delayed(milliseconds10);
          expect(vmState.isLoading, isFalse);
          expect(vmState.hasError, isFalse);
          expect(vmState.articleList.length, 1);
          expect(vmState.articleList.first, anyArticle);
          expect(vmState.articleVisibilityList.length, 1);
          expect(vmState.articleVisibilityList.first, isTrue);
        });
        test('navigate to initial requested article if found', () async {
          vmState.initialArticleId = anyPremiumArticle.id;
          // set initial state and define mock behavior
          when(() => mockArticleInteractor.getArticles()).thenAnswer(
            (_) => Future.value([anyArticle, anyPremiumArticle]),
          );

          // invoke method
          await viewModel.onInitState();

          // check result
          verifyNever(() => mockView.goToArticleDetailsScreen(0));
          verify(() => mockView.goToArticleDetailsScreen(1));
        });
      });
      test('fail with ApiError', () async {
        // set initial state and define mock behavior
        when(() => mockArticleInteractor.getArticles()).thenAnswer(
          (_) => Future.error([ApiError(message: 'error')]),
        );

        // invoke method
        viewModel.onInitState();

        // check result
        expect(vmState.isLoading, isTrue);
        verify(() => mockArticleInteractor.getArticles());

        // check async result
        await Future.delayed(milliseconds10);
        expect(vmState.isLoading, isFalse);
        expect(vmState.hasError, isTrue);
        expect(vmState.articleList.length, 0);
        expect(vmState.articleVisibilityList.length, 0);
      });

      test('fail with another exception', () {
        // set initial state and define mock behavior
        when(() => mockArticleInteractor.getArticles()).thenThrow(Exception());

        // invoke method
        viewModel.onInitState();

        // check result
        verify(() => mockArticleInteractor.getArticles());
        expect(vmState.isLoading, isFalse);
        expect(vmState.hasError, isTrue);
        expect(vmState.articleList.length, 0);
        expect(vmState.articleVisibilityList.length, 0);
      });
    });

    group('with initial list should not fetch again the list -', () {
      test('load and set visibility to true', () async {
        vmState.articleList.addAll([anyArticle]);
        vmState.initialArticleId = null;

        // invoke method
        await viewModel.onInitState();

        // check result
        verifyNever(() => mockArticleInteractor.getArticles());
        expect(vmState.isLoading, isFalse);
        expect(vmState.hasError, isFalse);
        expect(vmState.articleList.length, 1);
        expect(vmState.articleList.first, anyArticle);
        expect(vmState.articleVisibilityList.length, 1);
        expect(vmState.articleVisibilityList.first, isTrue);
      });
      test('load and navigate to initial article if present', () async {
        vmState.articleList.addAll([anyArticle]);
        vmState.initialArticleId = anyArticle.id;

        // invoke method
        await viewModel.onInitState();

        // check result
        verifyNever(() => mockArticleInteractor.getArticles());
        verify(() => mockView.goToArticleDetailsScreen(0));
      });
      test('load and do not navigate to initial article if absent', () async {
        vmState.articleList.addAll([anyArticle]);
        vmState.initialArticleId = anyPremiumArticle.id;

        // invoke method
        await viewModel.onInitState();

        // check result
        verifyNever(() => mockArticleInteractor.getArticles());
        verifyNever(() => mockView.goToArticleDetailsScreen(0));
      });
    });
  });

  group('tapOnRefreshArticleList -', () {
    test('successful, lists in state should be replaced', () async {
      // set initial state and define mock behavior
      vmState.articleList.addAll([anyArticle, anyArticle]);
      vmState.articleVisibilityList.addAll([false, false]);
      when(() => mockArticleInteractor.getArticles()).thenAnswer(
        (_) => Future.value([anyArticle]),
      );

      // invoke method
      viewModel.tapOnRefreshArticleList();

      // check result
      expect(vmState.isLoading, isTrue);
      verify(() => mockArticleInteractor.getArticles());

      // check async result
      await Future.delayed(milliseconds10);
      expect(vmState.isLoading, isFalse);
      expect(vmState.hasError, isFalse);
      expect(vmState.articleList.length, 1);
      expect(vmState.articleVisibilityList.length, 1);
      expect(vmState.articleVisibilityList.first, isTrue);
    });
    test('fail with ApiError, keep existing list, show snackbar', () async {
      // set initial state and define mock behavior
      vmState.articleList.addAll([anyArticle, anyArticle]);
      vmState.articleVisibilityList.addAll([false, false]);
      when(() => mockArticleInteractor.getArticles()).thenAnswer(
        (_) => Future.error([ApiError(message: 'error')]),
      );

      // invoke method
      viewModel.tapOnRefreshArticleList();

      // check result
      expect(vmState.isLoading, isTrue);
      verify(() => mockArticleInteractor.getArticles());

      // check async result
      await Future.delayed(milliseconds10);
      expect(vmState.isLoading, isFalse);
      expect(vmState.hasError, isTrue);
      expect(vmState.articleList.length, 2);
      expect(vmState.articleVisibilityList.length, 2);
      verify(mockView.showErrorRetrievingArticlesSnackbar);
    });

    test('fail with another exception, keep lists, show snackbar', () {
      // set initial state and define mock behavior
      vmState.articleList.addAll([anyArticle, anyArticle]);
      vmState.articleVisibilityList.addAll([false, false]);
      when(() => mockArticleInteractor.getArticles()).thenThrow(Exception());

      // invoke method
      viewModel.tapOnRefreshArticleList();

      // check result
      verify(() => mockArticleInteractor.getArticles());
      expect(vmState.isLoading, isFalse);
      expect(vmState.hasError, isTrue);
      expect(vmState.articleList.length, 2);
      expect(vmState.articleVisibilityList.length, 2);
      verify(mockView.showErrorRetrievingArticlesSnackbar);
    });
  });

  test('tapOnArticle', () {
    // invoke method
    viewModel.tapOnArticle(1);
    // check result
    verify(() => mockView.goToArticleDetailsScreen(1));
  });

  test('tapOnHideArticle', () {
    // set initial state
    vmState.articleVisibilityList.addAll([true]);
    // invoke method
    viewModel.tapOnHideArticle(0);
    // check result
    expect(vmState.articleVisibilityList[0], isFalse);
  });
}
