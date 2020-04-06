import 'package:flutter/widgets.dart' hide ActionDispatcher;

import 'package:built_redux/built_redux.dart';
import 'package:skill_branch_flutter/redux/actions/user_actions.dart';

part 'actions.g.dart';

abstract class AppActions extends ReduxActions {
  AppActions._();

  factory AppActions() = _$AppActions;

  ActionDispatcher<GlobalKey<NavigatorState>> setNavigatorKey;
  // ActionDispatcher<AppRoute> routeTo;
  // ActionDispatcher<DialogBundle> dialog;
  // ActionDispatcher<BottomSheetBundle> bottomSheet;
  // ActionDispatcher<AppTab> get updateTabAction;

  UserActions userActions;
}
