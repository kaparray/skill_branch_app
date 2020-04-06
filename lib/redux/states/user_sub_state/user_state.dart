import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:skill_branch_flutter/network/models/models.dart';

import 'credentials_state.dart';

part 'user_state.g.dart';

abstract class UserState implements Built<UserState, UserStateBuilder> {
  UserState._();

  factory UserState([updates(UserStateBuilder builder)]) {
    return _$UserState((builder) => builder..update(updates));
  }

  @nullable
  CredentialsState get credentialsState;

  @nullable
  UserNetworkModel get userData;

  @nullable
  List<FeedNetworkModel> get myPhotos;

  @nullable
  List<FeedNetworkModel> get myLikesPhotos;

  @nullable
  List<FeedNetworkModel> get myCollections;

  @nullable
  static Serializer<UserState> get serializer => _$userStateSerializer;
}
