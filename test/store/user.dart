import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_branch_flutter/redux/app/app_reducer.dart';
import 'package:skill_branch_flutter/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import 'package:skill_branch_flutter/redux/connectivity/connectivity_actions.dart';
import 'package:skill_branch_flutter/redux/navigation/navigation_middleware.dart';
import 'package:skill_branch_flutter/redux/user/user_middleware.dart';
import 'package:skill_branch_flutter/redux/user/user_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('User store test', () {
    Store<AppState> store;

    setUp(() async {
      UserState userState;
      store = Store(
        appReducer,
        initialState: AppState.initial(userState, ConnectivityResult.none),
        distinct: true,
        middleware: [
          UserMiddleware(),
          NavigationMiddleware(),
        ],
      );
    });

    test('test connectivityState', () {
      expect(store.state.connectivityState.connectivityResult, ConnectivityResult.none);

      store.dispatch(ConnectivityAction(ConnectivityResult.wifi));
      expect(store.state.connectivityState.connectivityResult, ConnectivityResult.wifi);

      store.dispatch(ConnectivityAction(ConnectivityResult.mobile));
      expect(store.state.connectivityState.connectivityResult, ConnectivityResult.mobile);
    });

    tearDown(() {
      store.teardown();
    });
  });
}
