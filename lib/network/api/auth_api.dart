import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kiwi/kiwi.dart';
import 'package:skill_branch_flutter/base/base_api.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/di/injector.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/user/user_actions.dart';

class AuthApi extends BaseApi {
  Future<UserNetworkModel> auth(String code) async {
    try {
      Container container = Container();

      Map<String, dynamic> queryParametrs = {
        'client_id': container<BaseConfig>().baseAccessKey,
        'client_secret': container<BaseConfig>().baseSecretKey,
        'redirect_uri': Uri.parse('photoapp://callback').toString(),
        'code': code,
        'grant_type': 'authorization_code',
      };

      final url = '/oauth/token?${mapToQueryParameters(queryParametrs)}';

      print('https://unsplash.com$url');

      final response = await makeRequest(url, type: RequestType.post, overrideUrl: 'https://unsplash.com');
      String userAccessToken = json.decode(response.body)['access_token'];

      if (userAccessToken != null)
        dispatch(UpdateIsAuth(true, userAccessToken));
      else {
        print(response.body);
        throw StreamError.accessTokenInvalid;
      }

      String urlMe = '/me';
      final responseMe = await makeRequest(urlMe);

      UserNetworkModel userInfo = userNetworkModelFromJson(responseMe.body);
      return userInfo;
    } catch (ex, trace) {
      debugPrint("${DateTime.now()} ex: $ex");
      debugPrint("${DateTime.now()} trace: $trace");

      if (ex.runtimeType != StreamError) throw StreamError.operationError;
      throw ex;
    }
  }
}
