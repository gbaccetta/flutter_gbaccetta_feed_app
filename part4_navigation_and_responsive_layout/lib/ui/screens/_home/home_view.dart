import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_view_widget_state.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_home/home_contract.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {  
  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  const HomeView({super.key, required this.navigationShell});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState
    extends BaseViewWidgetState<HomeView, HomeVMContract, HomeVMState>
    implements HomeViewContract {
  final destinations = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.article_outlined),
      activeIcon: Icon(Icons.article),
      label: 'Articles',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_2_outlined),
      activeIcon: Icon(Icons.person_2),
      label: 'User',
    ),
  ];

  @override
  void onInitState() {}

  @override
  Widget contentBuilder(BuildContext context) {
    return AdaptiveLayout(
      internalAnimations: false,
      // Primary navigation config has nothing from 0 to 600 dp screen width,
      // then an unextended NavigationRail with no labels and just icons then an
      // extended NavigationRail with both icons and labels.
      primaryNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.medium: SlotLayout.from(
            key: const Key('Primary Navigation Medium'),
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              padding: EdgeInsets.zero,
              selectedIndex: widget.navigationShell.currentIndex,
              onDestinationSelected: vmContract.onSelectedIndexChange,
              destinations: destinations
                  .map((item) => _toRailDestination(item))
                  .toList(),
            ),
          ),
          Breakpoints.large: SlotLayout.from(
            key: const Key('Primary Navigation Large'),
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              padding: EdgeInsets.zero,
              selectedIndex: widget.navigationShell.currentIndex,
              onDestinationSelected: vmContract.onSelectedIndexChange,
              extended: true,
              destinations: destinations
                  .map((item) => _toRailDestination(item))
                  .toList(),
            ),
          ),
        },
      ),
      // BottomNavigation is only active in small views defined as under 600 dp
      // width.
      bottomNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('Bottom Navigation Small'),
            builder: (_) => BottomNavigationBar(
              items: destinations,
              currentIndex: widget.navigationShell.currentIndex,
              onTap: vmContract.onSelectedIndexChange,
            ),
          )
        },
      ),
      // Body switches between a ListView and a GridView from small to medium
      // breakpoints and onwards.
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.smallAndUp: SlotLayout.from(
            key: const Key('Nested navigator'),
            builder: (_) => widget.navigationShell,
          ),
        },
      ),
    );
  }

  @override
  void goToTab(int index) => widget.navigationShell.goBranch(index);


  NavigationRailDestination _toRailDestination(
    BottomNavigationBarItem item,
  ) {
    return NavigationRailDestination(
      label: Text(item.label!),
      icon: item.icon,
      selectedIcon: item.activeIcon,
    );
  }
}
