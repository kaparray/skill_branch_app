// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable<Object> serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.navigatorKey != null) {
      result
        ..add('navigatorKey')
        ..add(serializers.serialize(object.navigatorKey,
            specifiedType: const FullType(widgets.GlobalKey,
                const [const FullType(widgets.NavigatorState)])));
    }
    if (object.userState != null) {
      result
        ..add('userState')
        ..add(serializers.serialize(object.userState,
            specifiedType: const FullType(UserState)));
    }
    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'navigatorKey':
          result.navigatorKey = serializers.deserialize(value,
              specifiedType: const FullType(widgets.GlobalKey, const [
                const FullType(widgets.NavigatorState)
              ])) as widgets.GlobalKey<widgets.NavigatorState>;
          break;
        case 'userState':
          result.userState.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserState)) as UserState);
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final widgets.GlobalKey<widgets.NavigatorState> navigatorKey;
  @override
  final UserState userState;

  factory _$AppState([void Function(AppStateBuilder) updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.navigatorKey, this.userState}) : super._();

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        navigatorKey == other.navigatorKey &&
        userState == other.userState;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, navigatorKey.hashCode), userState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('navigatorKey', navigatorKey)
          ..add('userState', userState))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  widgets.GlobalKey<widgets.NavigatorState> _navigatorKey;
  widgets.GlobalKey<widgets.NavigatorState> get navigatorKey =>
      _$this._navigatorKey;
  set navigatorKey(widgets.GlobalKey<widgets.NavigatorState> navigatorKey) =>
      _$this._navigatorKey = navigatorKey;

  UserStateBuilder _userState;
  UserStateBuilder get userState =>
      _$this._userState ??= new UserStateBuilder();
  set userState(UserStateBuilder userState) => _$this._userState = userState;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _navigatorKey = _$v.navigatorKey;
      _userState = _$v.userState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              navigatorKey: navigatorKey, userState: _userState?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'userState';
        _userState?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new