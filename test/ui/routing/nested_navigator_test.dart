import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/nested_navigator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

/// We declare this mock here as we will not be using this anywhere else apart
/// from the NestedNavigator wrapper class
class _MockStatefulNavigationShell extends Mock
    implements StatefulNavigationShell {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

void main() {
  test('current index', () {
    final statefulNavigationShell = _MockStatefulNavigationShell();
    final nestedNavigator = NestedNavigator(statefulNavigationShell);

    when(() => statefulNavigationShell.currentIndex).thenReturn(1);

    expect(nestedNavigator.currentIndex, 1);
  });

  test('navigatorContainer', () {
    final statefulNavigationShell = _MockStatefulNavigationShell();
    final nestedNavigator = NestedNavigator(statefulNavigationShell);

    expect(nestedNavigator.navigatorContainer, statefulNavigationShell);
  });

  test('goToBranch', () {
    final statefulNavigationShell = _MockStatefulNavigationShell();
    final nestedNavigator = NestedNavigator(statefulNavigationShell);

    nestedNavigator.goBranch(1);

    verify(() => statefulNavigationShell.goBranch(1));
  });
}
