import 'package:kiwi/kiwi.dart';
import 'package:skill_branch_flutter/di/injector.dart';
import 'package:skill_branch_flutter/network/api/auth_api.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/app/app_state.dart';
import 'package:skill_branch_flutter/redux/bottom_navigation_bar/tab_bar_action.dart';
import 'package:skill_branch_flutter/redux/navigation/navigation_actions.dart';
import 'package:skill_branch_flutter/redux/navigation/routes.dart';
import 'package:skill_branch_flutter/redux/user/user_actions.dart';
import 'package:redux/redux.dart';

import 'package:flutter_web_auth/flutter_web_auth.dart';

class UserMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    if (action is AuthUserAction) {
      authenticate(store, action, next);
    }

    return null;
  }

  void authenticate(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    
    var container = Container();

    store.dispatch(DialogAction(Dialogs.progress));

    final baseAuthUrl = 'https://unsplash.com/oauth/authorize';
    final callbackUrlScheme = 'photoapp';
    final redirectUrl =  Uri.parse('photoapp://callback');
    final scope = 'public+read_user+write_collections+write_likes';

    final url ='$baseAuthUrl?client_id=${container<BaseConfig>().baseAccessKey}&redirect_uri=$redirectUrl&response_type=code&scope=$scope';
    final result = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: callbackUrlScheme);
    
    
    String code = Uri.parse(result).queryParameters['code'];
    UserNetworkModel myAccountData;

    try {
      myAccountData = await AuthApi().auth(code);
      store.dispatch(DialogAction(Dialogs.close));

      final bool isAuth = store.state.userState.isAuth;

      if (isAuth) {
        store.dispatch(UpdateUserInfo(myAccountData));
        store.dispatch(UpdateTabAction(2));
      } else {}

    } catch (ex, trace) {
      print(ex);
      print(trace);

      store.dispatch(DialogAction(Dialogs.close));
      store.dispatch(DialogAction(Dialogs.error));

      await Future.delayed(Duration(milliseconds: 1500)).then((_) {
          store.dispatch(DialogAction(Dialogs.close));
       });
    }
  }
}
