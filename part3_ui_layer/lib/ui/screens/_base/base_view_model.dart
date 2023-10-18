import 'package:flutter/foundation.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_contract.dart';

abstract class BaseViewModel<VMS extends BaseViewModelState,
        VC extends BaseViewContract> extends ChangeNotifier
    implements BaseViewModelContract<VMS, VC> {
  @override
  late final VMS vmState;

  @override
  late final VC viewContract;

  /// this provide an handle to any data layer work or data
  /// processing to be performed when the view is initialized
  @override
  void onInitState() {}

  /// same for when the view is disposed
  @override
  void onDisposeView() {}

  /// update the state and notify listeners when loading starts
  void startLoadingState() {
    vmState.isLoading = true;
    notifyListeners();
  }

  /// update the state and notify listeners when loading finishes
  void stopLoadingState() {
    vmState.isLoading = false;
    notifyListeners();
  }
}
