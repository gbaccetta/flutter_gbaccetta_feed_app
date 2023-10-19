import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_contract.dart';
import 'package:provider/provider.dart';

/// Abstract BaseViewWidgetState: This forms the foundation for the state of any view.
///
/// This stateful widget serves several critical purposes:
/// 1. Maintains a constant instance of the viewModelState and viewModelContract that survives any rebuild.
/// 2. Provides constant access to the BuildContext in which the view is created.
/// 3. Allows observation of the view's lifecycle, including initState and dispose events.
abstract class BaseViewWidgetState<SW extends StatefulWidget,
        VMC extends BaseViewModelContract, VMS extends BaseViewModelState>
    extends State<SW> implements BaseViewContract {
  /// By default, autoSubscribeToVmStateChanges is set to true. This means the entire view will
  /// rebuild whenever the viewModel's state changes. For resource-intensive views, you can override it to
  /// false and use viewConsumerWidget or viewSelectorWidget for targeted rebuilds.
  final autoSubscribeToVmStateChanges = true;

  /// Initializes the binding with the ViewModel and its state.
  ///
  /// The [ViewModelContract] acts as an event sink, enabling the dispatch
  /// of UI events to the ViewModel. This constructor retrieves the ViewModel
  /// instance and initializes a ViewModelState, binding it to this ViewState.
  /// 
  /// Note: we use again the getIt service locator. This simplify
  /// the binding process are we are using abstract classes and dynamic types
  BaseViewWidgetState() {
    vmContract = getIt<VMC>();
    vmContract.vmState = getIt<VMS>();
    vmContract.viewContract = this;
  }

  late final VMC vmContract;
  VMS get vmState => vmContract.vmState as VMS;
  ThemeData get theme => Theme.of(context);
  TextTheme get textTheme => theme.textTheme;

  /// Ensuring @[mustCallSuper] to guarantee [onInitState] is always called.
  /// Dispatching this event to the viewModel signals that the UI is ready for initialization.
  /// Overriding [onInitState] in a viewState allows additional initialization from the view,
  /// executed before the viewModel's init.
  @override
  @mustCallSuper
  void initState() {
    onInitState();
    vmContract.onInitState();
    super.initState();
  }

  /// Adding @mustCallSuper to ensure the presence of changeNotifierProvider.
  /// By default, this automatically includes a viewConsumerWidget for whole view updates
  /// when the viewModel state changes. For resource-intensive views, set
  /// [vmState.autoSubscribeToVmStateChanges] to false, and use
  /// [viewConsumerWidget] or [viewSelectorWidget] to target rebuilds.
  @override
  @mustCallSuper
  Widget build(BuildContext context) => ChangeNotifierProvider<VMC>(
        create: (_) => vmContract,
        child: autoSubscribeToVmStateChanges
            ? viewConsumerWidget(builder: contentBuilder())
            : contentBuilder().call(context),
      );

  /// Override this method to build the view using the [viewModelState].
  /// Ensure you don't directly override the build method to include the Provider in the widget tree.
  Widget Function(BuildContext context) contentBuilder();

  /// Use this method for view initialization tasks, such as retrieving information from
  /// top-level providers (e.g., User) using `context.read<ProviderObject>())`,
  /// or for loading view parameters into the state (e.g., details of an Article
  /// when the view is launched after tapping an article card in a list of articles).
  void onInitState();

  /// We add @mustCallSuper to ensure that the event is dispatched to the ViewModel.
  ///
  /// Dispatching the event to the ViewModel ensures the ability to trigger any
  /// necessary work in the data layer when the user closes the view.
  @override
  @mustCallSuper
  void dispose() {
    vmContract.onDisposeView();
    super.dispose();
  }

  /// Use this widget only if [vmState.autoSubscribeToVmStateChanges] is set to false.
  ///
  /// This creates a Consumer Widget that listens to changes in the [viewModelState].
  Widget viewConsumerWidget({
    required Widget Function(BuildContext context) builder,
  }) =>
      _ViewConsumer<VMC>(
        vmContract: vmContract,
        builder: builder,
      );

  /// Use this widget only if [vmState.autoSubscribeToVmStateChanges] is set to false.
  ///
  /// This creates a Selector Widget that listens to specific changes in the [viewModelState].
  /// Provide the object [T] from the [viewModelState] using the [selector] parameter.
  Widget viewSelectorWidget<T>({
    required T Function(VMS) selector,
    required Widget Function(BuildContext) builder,
  }) =>
      _ViewSelector<VMC, VMS, T>(
        vmContract: vmContract,
        selector: selector,
        builder: builder,
      );
}

class _ViewConsumer<VMC extends BaseViewModelContract> extends StatelessWidget {
  final VMC vmContract;
  final Widget Function(BuildContext context) builder;

  const _ViewConsumer({
    required this.vmContract,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) => Consumer<VMC>(
        builder: (context, vmContract, _) => builder(context),
      );
}

class _ViewSelector<VMC extends BaseViewModelContract,
    VMS extends BaseViewModelState, T> extends StatelessWidget {
  final VMC vmContract;
  final T Function(VMS) selector;
  final Widget Function(BuildContext context) builder;

  const _ViewSelector({
    required this.vmContract,
    required this.selector,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) => Selector<VMC, T>(
        selector: (context, vmContract) => selector(vmContract.vmState as VMS),
        builder: (context, vmContract, _) => builder(context),
      );
}
