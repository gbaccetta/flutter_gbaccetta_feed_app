import 'package:flutter/foundation.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/user.dart';

/// In the BaseViewModelState we can add all properties that are used by most of
/// the views such as knowing if data isLoading, if an error occurred or get
/// the current user
abstract class BaseViewModelState {
  late User user;
  bool isLoading = false;
  bool hasError = false;
}

/// In the BaseViewContract we could have all generic view event such as a 
/// goToErrorScreen() method
abstract class BaseViewContract {}

/// In the BaseViewModelContract we can immediately notice a difference. 
/// The contract extends ChangeNotifier and hold an instance of the state. 
/// This is because every time the ViewModel will change the state we want to be
/// able to use notifyListeners() to update the view.
/// The reference to the viewContract allows the view to bind itself to the 
/// viewModel
abstract class BaseViewModelContract<VMS extends BaseViewModelState,
    VC extends BaseViewContract> extends ChangeNotifier {
  late final VMS vmState;
  late final VC viewContract;

  void onInitViewState();
  void onDisposeView();
}

