import 'package:skill_branch_flutter/network/models/models.dart';

class RefreshUserAction {}

class AuthUserAction {}

class ErrorLoadingUserAction {}

class UpdateUserName {
  UpdateUserName(this.name);
  final String name;
}

class UpdateAccessToken {
  UpdateAccessToken(this.accessToken);
  final String accessToken;
}

class UpdateUserInfo {
  UpdateUserInfo(this.userModel);

  UserNetworkModel userModel;
}

class UpdateIsAuth {
  UpdateIsAuth(this.isAuth, this.userAccessToken);
  final bool isAuth;
  final String userAccessToken;
}
