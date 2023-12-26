import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_contract.dart';

class HomeVMState extends BaseViewModelState {
  int selectedTab = 0;
}

abstract class HomeViewContract extends BaseViewContract {
  void goToTab(int index);
}

abstract class HomeVMContract
    extends BaseViewModelContract<HomeVMState, HomeViewContract> {
  void onSelectedIndexChange(int index);
}
