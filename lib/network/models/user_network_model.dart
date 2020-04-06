/// To parse this JSON data, do
/// final userNetworkModel = userNetworkModelFromJson(jsonString);

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/serializers.dart';

import 'badge_model.dart';
import 'links_model.dart';
import 'profile_image.dart';

part 'user_network_model.g.dart';

abstract class UserNetworkModel implements Built<UserNetworkModel, UserNetworkModelBuilder> {
  UserNetworkModel._();

  factory UserNetworkModel([updates(UserNetworkModelBuilder builder)]) = _$UserNetworkModel;

  @nullable
  String get id;
  @nullable
  DateTime get updatedAt;
  @nullable
  String get username;
  @nullable
  String get name;
  @nullable
  String get firstName;
  @nullable
  String get lastName;
  @nullable
  String get instagramUsername;
  @nullable
  String get twitterUsername;
  @nullable
  String get portfolioUrl;
  @nullable
  String get bio;
  @nullable
  String get location;
  @nullable
  int get totalLikes;
  @nullable
  int get totalPhotos;
  @nullable
  int get totalCollections;
  @nullable
  bool get followedByUser;
  @nullable
  int get followersCount;
  @nullable
  int get followingCount;
  @nullable
  int get downloads;
  @nullable
  ProfileImage get profileImage;
  @nullable
  Badge get badge;
  @nullable
  Links get links;

  static UserNetworkModel fromJson(Map jsonString) {
    return serializers.deserializeWith(UserNetworkModel.serializer, jsonString);
  }

  static Serializer<UserNetworkModel> get serializer => _$userNetworkModelSerializer;
}
