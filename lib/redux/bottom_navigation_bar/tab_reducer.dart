
import 'tab_bar_action.dart';
import 'tab_state.dart';

TabState tabReducer(TabState state, dynamic action) {
  if (action is UpdateTabAction) {
    return state.copyWith(currentTab: action.tabIndex);
  }

  return state;
}
