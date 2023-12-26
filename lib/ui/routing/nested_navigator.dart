import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// This is a wrapper class just to be able to have an easy mockable class
class NestedNavigator {
  final StatefulNavigationShell statefulNavigationShell;
  NestedNavigator(this.statefulNavigationShell);

  Widget get navigatorContainer => statefulNavigationShell;
  int get currentIndex => statefulNavigationShell.currentIndex;
  void goBranch(int index) => statefulNavigationShell.goBranch(index);
}
