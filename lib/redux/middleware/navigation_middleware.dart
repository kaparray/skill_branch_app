//   void routeTo(Store<AppState> store, RouteTo action, NextDispatcher next) {
//     next(action);

//     switch (action.route) {
//       case Routes.pop:
//         navigatorKey.currentState.pop();
//         break;

//       case Routes.fullScreen:
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (BuildContext context) => FullScreenImage(
//               heroTag: (action.payload as Map)['heroTag'],
//               photo: (action.payload as Map)['photo'],
//             ),
//           ),
//         );
//         break;

//       case Routes.profile:
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (BuildContext context) => UserProfile(
//               user: action.payload,
//               isMyProfile: (action.payload as UserNetworkModel).username == action.payload,
//             ),
//           ),
//         );
//         break;
//       case Routes.webView:
//         break;

//       case Routes.collections:
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (BuildContext context) => CollectionsView(action.payload),
//           ),
//         );
//         break;
//     }
//   }

//   void bottomSheet(Store<AppState> store, dynamic action, NextDispatcher next) {
//     next(action);

//     switch (action.bottomSheet) {
//       case BottomSheets.auth:
//         navigatorKey.currentState.push(
//           ModalBottomSheetRoute(
//             builder: (BuildContext context) => Container(
//               child: CircularProgressIndicator(),
//             ),
//             isScrollControlled: false,
//           ),
//         );
//         break;

//       case BottomSheets.close:
//         navigatorKey.currentState.pop();
//         break;
//     }
//   }

//   void dialog(Store<AppState> store, dynamic action, NextDispatcher next) {
//     next(action);

//     switch (action.dialog) {
//       case Dialogs.progress:
//         navigatorKey.currentState.push(
//           DialogRoute(
//             barrierDismissible: false,
//             pageBuilder:
//                 (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
//               return Builder(builder: (BuildContext context) {
//                 if (Platform.isAndroid) {
//                   return WillPopScope(
//                     child: ProgressDialog(),
//                     onWillPop: () {},
//                   );
//                 } else {
//                   return ProgressDialog();
//                 }
//               });
//             },
//           ),
//         );
//         break;

//       case Dialogs.error:
//         navigatorKey.currentState.push(
//           DialogRoute(
//             barrierDismissible: false,
//             pageBuilder:
//                 (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
//               return Builder(builder: (BuildContext context) {
//                 return ErrorDialog();
//               });
//             },
//           ),
//         );
//         break;

//       case Dialogs.done:
//         navigatorKey.currentState.push(
//           DialogRoute(
//             barrierDismissible: false,
//             pageBuilder:
//                 (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
//               return Builder(builder: (BuildContext context) {
//                 return DoneDialog();
//               });
//             },
//           ),
//         );
//         break;

//       case Dialogs.close:
//         navigatorKey.currentState.pop();
//         break;
//     }
//   }
// }


