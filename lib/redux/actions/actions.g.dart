// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actions.dart';

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$AppActions extends AppActions {
  factory _$AppActions() => _$AppActions._();
  _$AppActions._() : super._();

  final setNavigatorKey =
      ActionDispatcher<GlobalKey<NavigatorState>>('AppActions-setNavigatorKey');

  final userActions = UserActions();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    setNavigatorKey.setDispatcher(dispatcher);

    userActions.setDispatcher(dispatcher);
  }
}

class AppActionsNames {
  static final setNavigatorKey =
      ActionName<GlobalKey<NavigatorState>>('AppActions-setNavigatorKey');
}
