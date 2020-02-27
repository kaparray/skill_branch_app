import 'package:skill_branch_flutter/redux/navigation/routes.dart';

class RouteTo {
  RouteTo(this.route, {this.payload});
  final Routes route;
  final Object payload;
}

class BottomSheetAction {
  BottomSheetAction(this.bottomSheet, {this.bundle});
  final BottomSheets bottomSheet;
  final Object bundle;
}

class SnackbarAction {
  SnackbarAction({this.title, this.message});
  String title;
  String message;
}

class DialogAction {
  DialogAction(this.dialog);
  Dialogs dialog;
}
