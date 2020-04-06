import 'package:built_redux/built_redux.dart';
import 'package:skill_branch_flutter/redux/states/user_sub_state/user_state.dart';

part 'user_actions.g.dart';

abstract class UserActions extends ReduxActions {
  UserActions._();

  factory UserActions() = _$UserActions;

  // Reducers
  ActionDispatcher<UserState> get setUserState;
  ActionDispatcher<String> get updateUserCredentials;

  // Middlewares
  ActionDispatcher<void> get authenticate;
}
