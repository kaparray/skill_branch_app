import 'package:flutter/widgets.dart';
import 'package:skill_branch_flutter/base/base_vm.dart';

abstract class BaseState<ViewType extends StatefulWidget, ViewModelType extends BaseVM> extends State<ViewType>
    with AutomaticKeepAliveClientMixin<ViewType> {
  ViewModelType viewModel;

  void buildBefore(BuildContext context) {}
  @mustCallSuper
  Widget buildView(BuildContext context);
  void buildAfter(BuildContext context) {}
  void executeOnStart() {}

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((value) {
      executeOnStart();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.initBuildContext(context);

    buildBefore(context);
    var _ = buildView(context);
    buildAfter(context);
    return _;
  }

  @override
  @mustCallSuper
  void dispose() {
    viewModel.dispose();

    super.dispose();
  }

  @override
  bool get wantKeepAlive => false;
}
