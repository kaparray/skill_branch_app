import 'package:skill_branch_flutter/redux/bottom_navigation_bar/tab_reducer.dart';
import 'package:skill_branch_flutter/redux/connectivity/connectivity_reducer.dart';
import 'package:skill_branch_flutter/redux/user/user_reducer.dart';

import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    userState: userReducer(state.userState, action),
    tabState: tabReducer(state.tabState, action),
    connectivityState: connectivityReducer(state.connectivityState, action),
  );
}
