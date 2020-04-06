import 'package:built_redux/built_redux.dart';
import 'package:skill_branch_flutter/redux/actions/actions.dart';
import 'package:skill_branch_flutter/redux/middleware/middlewares.dart';
import 'package:skill_branch_flutter/redux/reducers/reducer_builder.dart';
import 'package:skill_branch_flutter/redux/states/app_state.dart';
import 'package:skill_branch_flutter/globals.dart';

Store<AppState, AppStateBuilder, AppActions> _store;

Store<AppState, AppStateBuilder, AppActions> get store => _store;

void initStore() {
  _store = Store<AppState, AppStateBuilder, AppActions>(
    reducers,
    AppState(),
    AppActions(),
    middleware: middlewares,
  );

  _store.actions.setNavigatorKey(navigatorKey);
}
