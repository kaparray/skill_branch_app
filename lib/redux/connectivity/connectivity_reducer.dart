import 'connectivity_actions.dart';
import 'connectivity_state.dart';

ConnectivityState connectivityReducer(ConnectivityState state, dynamic action) {
  if (action is ConnectivityAction) {
    return state.copyWith(connectivityResult: action.connectivityResult);
  }

  return state;
}
