// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserState> _$userStateSerializer = new _$UserStateSerializer();

class _$UserStateSerializer implements StructuredSerializer<UserState> {
  @override
  final Iterable<Type> types = const [UserState, _$UserState];
  @override
  final String wireName = 'UserState';

  @override
  Iterable<Object> serialize(Serializers serializers, UserState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.credentialsState != null) {
      result
        ..add('credentialsState')
        ..add(serializers.serialize(object.credentialsState,
            specifiedType: const FullType(CredentialsState)));
    }
    if (object.userData != null) {
      result
        ..add('userData')
        ..add(serializers.serialize(object.userData,
            specifiedType: const FullType(UserNetworkModel)));
    }
    if (object.myPhotos != null) {
      result
        ..add('myPhotos')
        ..add(serializers.serialize(object.myPhotos,
            specifiedType: const FullType(
                List, const [const FullType(FeedNetworkModel)])));
    }
    if (object.myLikesPhotos != null) {
      result
        ..add('myLikesPhotos')
        ..add(serializers.serialize(object.myLikesPhotos,
            specifiedType: const FullType(
                List, const [const FullType(FeedNetworkModel)])));
    }
    if (object.myCollections != null) {
      result
        ..add('myCollections')
        ..add(serializers.serialize(object.myCollections,
            specifiedType: const FullType(
                List, const [const FullType(FeedNetworkModel)])));
    }
    return result;
  }

  @override
  UserState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'credentialsState':
          result.credentialsState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(CredentialsState))
              as CredentialsState);
          break;
        case 'userData':
          result.userData.replace(serializers.deserialize(value,
                  specifiedType: const FullType(UserNetworkModel))
              as UserNetworkModel);
          break;
        case 'myPhotos':
          result.myPhotos = serializers.deserialize(value,
                  specifiedType: const FullType(
                      List, const [const FullType(FeedNetworkModel)]))
              as List<FeedNetworkModel>;
          break;
        case 'myLikesPhotos':
          result.myLikesPhotos = serializers.deserialize(value,
                  specifiedType: const FullType(
                      List, const [const FullType(FeedNetworkModel)]))
              as List<FeedNetworkModel>;
          break;
        case 'myCollections':
          result.myCollections = serializers.deserialize(value,
                  specifiedType: const FullType(
                      List, const [const FullType(FeedNetworkModel)]))
              as List<FeedNetworkModel>;
          break;
      }
    }

    return result.build();
  }
}

class _$UserState extends UserState {
  @override
  final CredentialsState credentialsState;
  @override
  final UserNetworkModel userData;
  @override
  final List<FeedNetworkModel> myPhotos;
  @override
  final List<FeedNetworkModel> myLikesPhotos;
  @override
  final List<FeedNetworkModel> myCollections;

  factory _$UserState([void Function(UserStateBuilder) updates]) =>
      (new UserStateBuilder()..update(updates)).build();

  _$UserState._(
      {this.credentialsState,
      this.userData,
      this.myPhotos,
      this.myLikesPhotos,
      this.myCollections})
      : super._();

  @override
  UserState rebuild(void Function(UserStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserStateBuilder toBuilder() => new UserStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserState &&
        credentialsState == other.credentialsState &&
        userData == other.userData &&
        myPhotos == other.myPhotos &&
        myLikesPhotos == other.myLikesPhotos &&
        myCollections == other.myCollections;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, credentialsState.hashCode), userData.hashCode),
                myPhotos.hashCode),
            myLikesPhotos.hashCode),
        myCollections.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserState')
          ..add('credentialsState', credentialsState)
          ..add('userData', userData)
          ..add('myPhotos', myPhotos)
          ..add('myLikesPhotos', myLikesPhotos)
          ..add('myCollections', myCollections))
        .toString();
  }
}

class UserStateBuilder implements Builder<UserState, UserStateBuilder> {
  _$UserState _$v;

  CredentialsStateBuilder _credentialsState;
  CredentialsStateBuilder get credentialsState =>
      _$this._credentialsState ??= new CredentialsStateBuilder();
  set credentialsState(CredentialsStateBuilder credentialsState) =>
      _$this._credentialsState = credentialsState;

  UserNetworkModelBuilder _userData;
  UserNetworkModelBuilder get userData =>
      _$this._userData ??= new UserNetworkModelBuilder();
  set userData(UserNetworkModelBuilder userData) => _$this._userData = userData;

  List<FeedNetworkModel> _myPhotos;
  List<FeedNetworkModel> get myPhotos => _$this._myPhotos;
  set myPhotos(List<FeedNetworkModel> myPhotos) => _$this._myPhotos = myPhotos;

  List<FeedNetworkModel> _myLikesPhotos;
  List<FeedNetworkModel> get myLikesPhotos => _$this._myLikesPhotos;
  set myLikesPhotos(List<FeedNetworkModel> myLikesPhotos) =>
      _$this._myLikesPhotos = myLikesPhotos;

  List<FeedNetworkModel> _myCollections;
  List<FeedNetworkModel> get myCollections => _$this._myCollections;
  set myCollections(List<FeedNetworkModel> myCollections) =>
      _$this._myCollections = myCollections;

  UserStateBuilder();

  UserStateBuilder get _$this {
    if (_$v != null) {
      _credentialsState = _$v.credentialsState?.toBuilder();
      _userData = _$v.userData?.toBuilder();
      _myPhotos = _$v.myPhotos;
      _myLikesPhotos = _$v.myLikesPhotos;
      _myCollections = _$v.myCollections;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserState;
  }

  @override
  void update(void Function(UserStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserState build() {
    _$UserState _$result;
    try {
      _$result = _$v ??
          new _$UserState._(
              credentialsState: _credentialsState?.build(),
              userData: _userData?.build(),
              myPhotos: myPhotos,
              myLikesPhotos: myLikesPhotos,
              myCollections: myCollections);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'credentialsState';
        _credentialsState?.build();
        _$failedField = 'userData';
        _userData?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
