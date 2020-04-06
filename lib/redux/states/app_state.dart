library app_state;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:flutter/widgets.dart' as widgets;

import 'user_sub_state/user_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AppState._();

  factory AppState([updates(AppStateBuilder builder)]) {
    return _$AppState((builder) => builder..update(updates));
  }

  @nullable
  widgets.GlobalKey<widgets.NavigatorState> get navigatorKey;

  @nullable
  UserState get userState;

  static Serializer<AppState> get serializer => _$appStateSerializer;
}
