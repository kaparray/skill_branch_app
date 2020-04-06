import 'dart:convert';

import 'package:built_redux/built_redux.dart';
import 'package:kiwi/kiwi.dart';

import 'package:skill_branch_flutter/redux/actions/actions.dart';
import 'package:skill_branch_flutter/redux/actions/user_actions.dart';
import 'package:skill_branch_flutter/redux/states/app_state.dart';

MiddlewareBuilder<AppState, AppStateBuilder, AppActions> createUserMiddleware() {
  return MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
    ..add<void>(
      UserActionsNames.authenticate,
      _authenticate,
    );
}

void _authenticate(
    MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next, Action<void> action) async {
  next(action);

  // var container = Container();

  // // store.dispatch(DialogAction(Dialogs.progress));

  // final baseAuthUrl = 'https://unsplash.com/oauth/authorize';
  // final callbackUrlScheme = 'photoapp';
  // final redirectUrl =  Uri.parse('photoapp://callback');
  // final scope = 'public+read_user+write_collections+write_likes';

  // final url ='$baseAuthUrl?client_id=${container<BaseConfig>().baseAccessKey}&redirect_uri=$redirectUrl&response_type=code&scope=$scope';
  // final result = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: callbackUrlScheme);

  // //print('$url');

  // String code = Uri.parse(result).queryParameters['code'];
  // UserNetworkModel myAccountData;

  // try {
  //   myAccountData = await AuthApi().auth(code);
  //   store.dispatch(DialogAction(Dialogs.close));

  //   final bool isAuth = store.state.userState.isAuth;

  //   if (isAuth) {
  //     store.dispatch(UpdateUserInfo(myAccountData));
  //     store.dispatch(UpdateTabAction(2));
  //   } else {}

  // } catch (ex, trace) {
  //   print(ex);
  //   print(trace);

  //   store.dispatch(DialogAction(Dialogs.close));
  //   store.dispatch(DialogAction(Dialogs.error));

  //   await Future.delayed(Duration(milliseconds: 1500)).then((_) {
  //       store.dispatch(DialogAction(Dialogs.close));
  //    });
  // }
}
