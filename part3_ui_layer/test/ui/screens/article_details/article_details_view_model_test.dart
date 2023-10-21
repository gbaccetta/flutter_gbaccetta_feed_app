import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_contract.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_details/article_details_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/test_utils.dart';

class MockArticleDetailsView extends Mock
    implements ArticleDetailsViewContract {}

void main() {
  // create an instance of the viewModel and the viewModelState
  late ArticleDetailsViewModel viewModel;
  late ArticleDetailsVMState vmState;

  // create a mocked instance of the component surrounding the viewModel
  late MockArticleDetailsView mockView;

  // this will run before each test, to setup our environment anew
  setUp(() {
    mockView = MockArticleDetailsView();
    vmState = ArticleDetailsVMState();
    viewModel = ArticleDetailsViewModel();
    viewModel.viewContract = mockView;
    viewModel.vmState = vmState;
  });

  test('tapOnHideArticle', () async {
    // invoke method
    viewModel.tapOnRefreshPage();
    expect(vmState.isLoading, isTrue);
    await Future.delayed(milliseconds1000);
    expect(vmState.isLoading, isFalse);
  });
}
