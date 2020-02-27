import 'package:skill_branch_flutter/redux/user/user_actions.dart';
import 'package:skill_branch_flutter/redux/user/user_state.dart';

UserState userReducer(UserState state, dynamic action) {
  if (action is UpdateUserName) {
    return state.copyWith(userData: state.userData..name = action.name);
  } else if (action is UpdateAccessToken) {
    return state.copyWith(userAccessToken: action.accessToken);
  } else if  (action is UpdateUserInfo) {
    return state.copyWith(userData: action.userModel);
  } else if  (action is UpdateIsAuth) {
    return state.copyWith(isAuth: action.isAuth, userAccessToken: action.userAccessToken);
  }

  return state;
}