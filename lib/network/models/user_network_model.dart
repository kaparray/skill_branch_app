/// To parse this JSON data, do
/// final userNetworkModel = userNetworkModelFromJson(jsonString);

import 'dart:convert';

import 'package:skill_branch_flutter/network/models/models.dart';

import 'badge_model.dart';
import 'links_model.dart';
import 'profile_image.dart';

UserNetworkModel userNetworkModelFromJson(String str) =>
    UserNetworkModel.fromJson(json.decode(str));

String userNetworkModelToJson(UserNetworkModel data) =>
    json.encode(data.toJson());

class UserNetworkModel {
  String id;
  DateTime updatedAt;
  String username;
  String name;
  String firstName;
  String lastName;
  String instagramUsername;
  String twitterUsername;
  dynamic portfolioUrl;
  String bio;
  String location;
  int totalLikes;
  int totalPhotos;
  int totalCollections;
  bool followedByUser;
  int followersCount;
  int followingCount;
  int downloads;
  ProfileImage profileImage;
  Badge badge;
  Links links;

  UserNetworkModel({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.instagramUsername,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.totalLikes,
    this.totalPhotos,
    this.totalCollections,
    this.followedByUser,
    this.followersCount,
    this.followingCount,
    this.downloads,
    this.profileImage,
    this.badge,
    this.links,
  });

  factory UserNetworkModel.fromJson(Map<String, dynamic> json) {
    return UserNetworkModel(
      id: json["id"],
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      username: json["username"],
      name: json["name"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      instagramUsername: json["instagram_username"],
      twitterUsername: json["twitter_username"],
      portfolioUrl: json["portfolio_url"],
      bio: json["bio"],
      location: json["location"],
      totalLikes: json["total_likes"],
      totalPhotos: json["total_photos"],
      totalCollections: json["total_collections"],
      followedByUser: json["followed_by_user"],
      followersCount: json["followers_count"],
      followingCount: json["following_count"],
      downloads: json["downloads"],
      profileImage: ProfileImage.fromJson(json["profile_image"]),
      badge: Badge.fromJson(json["badge"]),
      links: Links.fromJson(json["links"]),
    );
  }

  Map<String, Object> toJson() => {
        "\"id\"": "\"$id\"",
        "\"updated_at\"": "\"${updatedAt?.toIso8601String()}\"",
        "\"username\"": "\"$username\"",
        "\"name\"": "\"$name\"",
        "\"first_name\"": "\"$firstName\"",
        "\"last_name\"": "\"$lastName\"",
        "\"instagram_username\"": "\"$instagramUsername\"",
        "\"twitter_username\"": "\"$twitterUsername\"",
        "\"portfolio_url\"": "\"$portfolioUrl\"",
        "\"bio\"": "\"$bio\"",
        "\"location\"": "\"$location\"",
        "\"total_likes\"": totalLikes,
        "\"total_photos\"": totalPhotos,
        "\"total_collections\"": totalCollections,
        "\"followed_by_user\"": followedByUser,
        "\"followers_count\"": followersCount,
        "\"following_count\"": followingCount,
        "\"downloads\"": downloads,
        "\"profile_image\"": profileImage.toJson(),
        "\"badge\"": badge.toJson(),
        "\"links\"": links.toJson(),
      };
}
