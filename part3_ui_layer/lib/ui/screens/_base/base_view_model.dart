import 'package:flutter/foundation.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_contract.dart';

abstract class BaseViewModel<VMS extends BaseViewModelState,
        VC extends BaseViewContract> extends ChangeNotifier
    implements BaseViewModelContract<VMS, VC> {
  @override
  late final VMS vmState;

  @override
  late final VC viewContract;

  @override
  void onInitViewState() {}

  @override
  void onDisposeView() {}
}
