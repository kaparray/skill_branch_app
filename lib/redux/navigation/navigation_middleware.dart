import 'dart:io';

import 'package:flutter/material.dart' hide BottomSheet;
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/app/app_state.dart';
import 'package:skill_branch_flutter/redux/navigation/navigation_actions.dart';
import 'package:skill_branch_flutter/redux/navigation/routes.dart';
import 'package:skill_branch_flutter/static.dart';
import 'package:skill_branch_flutter/ui/dialogs/done_dialog.dart';
import 'package:skill_branch_flutter/ui/dialogs/error_dialog.dart';
import 'package:skill_branch_flutter/ui/dialogs/progress_dialog.dart';
import 'package:skill_branch_flutter/ui/lib/bottom_sheet_route.dart';
import 'package:skill_branch_flutter/ui/lib/dialog_route.dart';
import 'package:skill_branch_flutter/ui/screens/collections/collections.dart';
import 'package:skill_branch_flutter/ui/screens/full_screen_image/full_screen_image.dart';
import 'package:skill_branch_flutter/ui/screens/user/user.dart';
import 'package:redux/redux.dart';

class NavigationMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    if (action is RouteTo) {
      routeTo(store, action, next);
    } else if (action is BottomSheetAction) {
      bottomSheet(store, action, next);
    } else if (action is DialogAction) {
      dialog(store, action, next);
    }

    return null;
  }

  void routeTo(Store<AppState> store, RouteTo action, NextDispatcher next) {
    next(action);

    switch (action.route) {
      case Routes.pop:
        navigatorKey.currentState.pop();
        break;

      case Routes.fullScreen:
        navigatorKey.currentState.push(
          MaterialPageRoute(
            builder: (BuildContext context) => FullScreenImage(
                ((action.payload as Map)['photo'] as FeedNetworkModel),
                (action.payload as Map)['heroTag']),
          ),
        );
        break;

      case Routes.profile:
        navigatorKey.currentState.push(
          MaterialPageRoute(
            builder: (BuildContext context) => UserProfile(
              user: action.payload,
              isMyProfile: (action.payload as UserNetworkModel).username ==
                  action.payload,
            ),
          ),
        );
        break;
      case Routes.webView:
        break;

      case Routes.collections:
        navigatorKey.currentState.push(
          MaterialPageRoute(
            builder: (BuildContext context) => CollectionsView(action.payload),
          ),
        );
        break;
    }
  }

  void bottomSheet(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    switch (action.bottomSheet) {
      case BottomSheets.auth:
        navigatorKey.currentState.push(
          ModalBottomSheetRoute(
            builder: (BuildContext context) => Container(
              child: CircularProgressIndicator(),
            ),
            isScrollControlled: false,
          ),
        );
        break;

      case BottomSheets.close:
        navigatorKey.currentState.pop();
        break;
    }
  }

  void dialog(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    switch (action.dialog) {
      case Dialogs.progress:
        navigatorKey.currentState.push(
          DialogRoute(
            barrierDismissible: false,
            pageBuilder: (BuildContext buildContext,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return Builder(builder: (BuildContext context) {
                if (Platform.isAndroid) {
                  return WillPopScope(
                    child: ProgressDialog(),
                    onWillPop: () {},
                  );
                } else {
                  return ProgressDialog();
                }
              });
            },
          ),
        );
        break;

      case Dialogs.error:
        navigatorKey.currentState.push(
          DialogRoute(
            barrierDismissible: false,
            pageBuilder: (BuildContext buildContext,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return Builder(builder: (BuildContext context) {
                return ErrorDialog();
              });
            },
          ),
        );
        break;

      case Dialogs.done:
        navigatorKey.currentState.push(
          DialogRoute(
            barrierDismissible: false,
            pageBuilder: (BuildContext buildContext,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return Builder(builder: (BuildContext context) {
                return DoneDialog();
              });
            },
          ),
        );
        break;

      case Dialogs.close:
        navigatorKey.currentState.pop();
        break;
    }
  }
}
