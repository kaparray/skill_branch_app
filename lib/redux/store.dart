import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_reducer.dart';
import 'app/app_state.dart';
import 'navigation/navigation_middleware.dart';
import 'user/user_middleware.dart';
import 'user/user_state.dart';

String kUserStateKey = 'user_state_key';

Store<AppState> _store;

Store<AppState> get store => _store;

Future<void> createStore([ConnectivityResult connectivity]) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String crudeUserState = sharedPreferences.getString(kUserStateKey);
  UserState userState;

  try {
    if (crudeUserState != null) {
      Map<String, Object> crudeUserData = json.decode(crudeUserState);
      userState = UserState.fromJson(crudeUserData);
    }
  } catch (ex, trace) {
    print(ex);
    print(trace);
  }

  ConnectivityResult connectivity = await Connectivity().checkConnectivity();

  _store = Store(
    appReducer,
    initialState: AppState.initial(userState, connectivity),
    distinct: true,
    middleware: [
      UserMiddleware(),
      NavigationMiddleware(),
    ],
  );
}
