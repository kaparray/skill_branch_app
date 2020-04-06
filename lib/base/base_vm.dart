import 'package:built_redux/built_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:skill_branch_flutter/redux/actions/actions.dart';
import 'package:skill_branch_flutter/redux/states/app_state.dart';

abstract class BaseVM {
  BuildContext context;
  Store<AppState, AppStateBuilder, AppActions> get store => store;

  void initBuildContext(BuildContext context) {
    this.context = context;
  }

  void dispose() {}
}
