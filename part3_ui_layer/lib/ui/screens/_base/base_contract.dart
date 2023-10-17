import 'package:flutter/foundation.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/user.dart';

abstract class BaseViewContract {}

abstract class BaseViewModelContract<VMS extends BaseViewModelState,
    VC extends BaseViewContract> extends ChangeNotifier {
  late final VMS vmState;
  late final VC viewContract;

  void onInitViewState();
  void onDisposeView();
}

abstract class BaseViewModelState {
  late User user;
  bool isLoading = false;
  bool hasError = false;
}
