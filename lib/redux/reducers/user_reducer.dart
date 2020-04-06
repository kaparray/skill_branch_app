import 'package:built_redux/built_redux.dart';
import 'package:skill_branch_flutter/redux/actions/user_actions.dart';
import 'package:skill_branch_flutter/redux/states/app_state.dart';
import 'package:skill_branch_flutter/redux/states/user_sub_state/user_state.dart';


NestedReducerBuilder<AppState, AppStateBuilder, UserState, UserStateBuilder> createUserReducer() {
  return NestedReducerBuilder<AppState, AppStateBuilder, UserState, UserStateBuilder>(
    (state) => state.userState,
    (builder) => builder.userState,
  )..add<UserState>(
      UserActionsNames.setUserState,
      _setUserState,
    );
}


void _setUserState(UserState state, Action<void> action, UserStateBuilder builder) {

}
