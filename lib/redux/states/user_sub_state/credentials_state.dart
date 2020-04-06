library app_state;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'credentials_state.g.dart';

abstract class CredentialsState implements Built<CredentialsState, CredentialsStateBuilder> {
  CredentialsState._();

  factory CredentialsState([updates(CredentialsStateBuilder builder)]) {
    return _$CredentialsState((builder) => builder..update(updates));
  }

  String get userAccessToken;
  String get userRefreshToken;

  @BuiltValueField(serialize: false)
  bool get isAuth {
    if (userAccessToken != null && userRefreshToken != null) {
      return true;
    } else {
      return false;
    }
  }

  @nullable
  static Serializer<CredentialsState> get serializer => _$credentialsStateSerializer;
}
