import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:skill_branch_flutter/redux/bottom_navigation_bar/tab_state.dart';
import 'package:skill_branch_flutter/redux/connectivity/connectivity_state.dart';
import 'package:skill_branch_flutter/redux/user/user_state.dart';

@immutable
class AppState {
  AppState({
    @required this.userState,
    @required this.tabState,
    @required this.connectivityState,
  });

  final UserState userState;
  final TabState tabState;
  final ConnectivityState connectivityState;

  factory AppState.initial(UserState userState, ConnectivityResult connectivityResult) {
    return AppState(
      userState: UserState.initial(userState),
      tabState: TabState.initial(),
      connectivityState: ConnectivityState.initial(connectivityResult),
    );
  }

  AppState copyWith({UserState userState, TabState tabState}) {
    return AppState(
      userState: userState ?? this.userState,
      tabState: tabState ?? this.tabState,
      connectivityState: connectivityState ?? this.connectivityState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          userState == other.userState &&
          tabState == other.tabState &&
          connectivityState == other.connectivityState;

  @override
  int get hashCode => userState.hashCode ^ tabState.hashCode ^ connectivityState.hashCode;
}
