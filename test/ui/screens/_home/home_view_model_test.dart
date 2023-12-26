import 'package:flutter_gbaccetta_feed_app/ui/screens/_home/home_contract.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_home/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeView extends Mock implements HomeViewContract {}

void main() {
  // create an instance of the viewModel and the viewModelState
  late HomeViewModel viewModel;
  late HomeVMState vmState;

  // create a mocked instance of the component surrounding the viewModel
  late MockHomeView mockView;

  // this will run before each test, to setup our environment anew
  setUp(() {
    mockView = MockHomeView();
    vmState = HomeVMState();
    viewModel = HomeViewModel();
    viewModel.viewContract = mockView;
    viewModel.vmState = vmState;
  });

  test('tap on a destination should tell the view to change tab', () async {
    // invoke method
    viewModel.onSelectedIndexChange(1);
    verify(() => mockView.goToTab(1));
  });
}
