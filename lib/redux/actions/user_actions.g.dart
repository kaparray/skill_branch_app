// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_actions.dart';

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$UserActions extends UserActions {
  factory _$UserActions() => _$UserActions._();
  _$UserActions._() : super._();

  final setUserState = ActionDispatcher<UserState>('UserActions-setUserState');
  final updateUserCredentials =
      ActionDispatcher<String>('UserActions-updateUserCredentials');
  final authenticate = ActionDispatcher<void>('UserActions-authenticate');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    setUserState.setDispatcher(dispatcher);
    updateUserCredentials.setDispatcher(dispatcher);
    authenticate.setDispatcher(dispatcher);
  }
}

class UserActionsNames {
  static final setUserState = ActionName<UserState>('UserActions-setUserState');
  static final updateUserCredentials =
      ActionName<String>('UserActions-updateUserCredentials');
  static final authenticate = ActionName<void>('UserActions-authenticate');
}
