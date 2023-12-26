import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_view_model.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_home/home_contract.dart';

class HomeViewModel extends BaseViewModel<HomeVMState, HomeViewContract>
    implements HomeVMContract {
  @override
  void onSelectedIndexChange(int index) {
    if (vmState.selectedTab == index) return;
    vmState.selectedTab = index;
    notifyListeners();
    viewContract.goToTab(index);
  }
}
