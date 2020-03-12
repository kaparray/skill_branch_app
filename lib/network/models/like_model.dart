import 'package:skill_branch_flutter/network/models/user_model.dart';

import 'feed_network_model.dart';

class Like {
  FeedNetworkModel photo;
  User user;

  Like({
    this.photo,
    this.user,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        photo: FeedNetworkModel.fromJson(json["photo"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "user": photo,
      };
}
