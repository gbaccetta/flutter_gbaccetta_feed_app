import 'package:flutter/foundation.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/user.dart';

/// BaseViewModelState: This abstract class holds properties commonly used by
/// most views. It includes features like tracking data loading status, error
/// occurrence, and accessing the current user.
abstract class BaseViewModelState {
  late User user;
  bool isLoading = false;
  bool hasError = false;
}

/// BaseViewContract: This abstract class can include generic view events that
/// can be used universally across different views. For example, it could define
/// methods like goToErrorScreen().
/// Since this is a list of events, all methods must always be void
abstract class BaseViewContract {}

/// BaseViewModelContract: In this abstract class, we observe a significant
/// distinction. The contract extends ChangeNotifier and maintains an instance
/// of the state. This is crucial because when the ViewModel alters the state,
/// we need to utilize notifyListeners() to update the view. The reference to
/// viewContract enables the view to establish a binding with the ViewModel.
/// Since this is a list of events, all methods must always be void
abstract class BaseViewModelContract<VMS extends BaseViewModelState,
    VC extends BaseViewContract> extends ChangeNotifier {
  late final VMS vmState;
  late final VC viewContract;

  void onInitState();
  void onDisposeView();
}
