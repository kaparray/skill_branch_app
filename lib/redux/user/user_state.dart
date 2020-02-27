
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/store.dart';

@immutable
class UserState {
  UserState({
    @required this.userData,
    @required this.userAccessToken,
    @required this.isAuth,
  });

  final UserNetworkModel userData;
  final String userAccessToken;
  final bool isAuth;

  factory UserState.initial(UserState userState) {
    return UserState(
      userData: userState?.userData,
      userAccessToken: userState?.userAccessToken,
      isAuth: userState?.isAuth ?? false,
    );
  }

  UserState copyWith({
    UserNetworkModel userData,
    String userAccessToken,
    bool isAuth,
  }) {

    UserState newState = UserState(
      userData: userData ?? this.userData,
      userAccessToken: userAccessToken ?? this.userAccessToken,
      isAuth: isAuth ?? this.isAuth,
    );

    SharedPreferences.getInstance().then((data) async {
      await data.setString(kUserStateKey, newState.toJson());
    });

    return newState;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          runtimeType == other.runtimeType &&
          userData == other.userData &&
          userAccessToken == other.userAccessToken &&
          isAuth == other.isAuth;

  @override
  int get hashCode =>
      userData.hashCode ^ userAccessToken.hashCode ^ isAuth.hashCode;

  static UserState fromJson(Map<String, dynamic> json) => UserState(
      isAuth: json['isAuth'] ?? false,
      userAccessToken: json['userAccessToken'],
      userData: UserNetworkModel.fromJson(json['userData']));

  String toJson() {
    return {
        "\"userAccessToken\"": "\"$userAccessToken\"",
        "\"isAuth\"": "$isAuth",
        "\"userData\"": userData != null ? userData.toJson() : null
      }.toString();
  }
}
