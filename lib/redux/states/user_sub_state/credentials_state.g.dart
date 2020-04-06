// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CredentialsState> _$credentialsStateSerializer =
    new _$CredentialsStateSerializer();

class _$CredentialsStateSerializer
    implements StructuredSerializer<CredentialsState> {
  @override
  final Iterable<Type> types = const [CredentialsState, _$CredentialsState];
  @override
  final String wireName = 'CredentialsState';

  @override
  Iterable<Object> serialize(Serializers serializers, CredentialsState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'userAccessToken',
      serializers.serialize(object.userAccessToken,
          specifiedType: const FullType(String)),
      'userRefreshToken',
      serializers.serialize(object.userRefreshToken,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  CredentialsState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CredentialsStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'userAccessToken':
          result.userAccessToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userRefreshToken':
          result.userRefreshToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$CredentialsState extends CredentialsState {
  @override
  final String userAccessToken;
  @override
  final String userRefreshToken;

  factory _$CredentialsState(
          [void Function(CredentialsStateBuilder) updates]) =>
      (new CredentialsStateBuilder()..update(updates)).build();

  _$CredentialsState._({this.userAccessToken, this.userRefreshToken})
      : super._() {
    if (userAccessToken == null) {
      throw new BuiltValueNullFieldError('CredentialsState', 'userAccessToken');
    }
    if (userRefreshToken == null) {
      throw new BuiltValueNullFieldError(
          'CredentialsState', 'userRefreshToken');
    }
  }

  @override
  CredentialsState rebuild(void Function(CredentialsStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CredentialsStateBuilder toBuilder() =>
      new CredentialsStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CredentialsState &&
        userAccessToken == other.userAccessToken &&
        userRefreshToken == other.userRefreshToken;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc(0, userAccessToken.hashCode), userRefreshToken.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CredentialsState')
          ..add('userAccessToken', userAccessToken)
          ..add('userRefreshToken', userRefreshToken))
        .toString();
  }
}

class CredentialsStateBuilder
    implements Builder<CredentialsState, CredentialsStateBuilder> {
  _$CredentialsState _$v;

  String _userAccessToken;
  String get userAccessToken => _$this._userAccessToken;
  set userAccessToken(String userAccessToken) =>
      _$this._userAccessToken = userAccessToken;

  String _userRefreshToken;
  String get userRefreshToken => _$this._userRefreshToken;
  set userRefreshToken(String userRefreshToken) =>
      _$this._userRefreshToken = userRefreshToken;

  CredentialsStateBuilder();

  CredentialsStateBuilder get _$this {
    if (_$v != null) {
      _userAccessToken = _$v.userAccessToken;
      _userRefreshToken = _$v.userRefreshToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CredentialsState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CredentialsState;
  }

  @override
  void update(void Function(CredentialsStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CredentialsState build() {
    final _$result = _$v ??
        new _$CredentialsState._(
            userAccessToken: userAccessToken,
            userRefreshToken: userRefreshToken);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
