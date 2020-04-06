import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:skill_branch_flutter/base/base_api.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/network/models/models.dart';

class UserApi extends BaseApi {
  Future<UserNetworkModel> requestUserInfo(String username) async {
    try {
      String url = "/users/$username";

      http.Response response = await makeRequest(url);
      final userInfo = UserNetworkModel.fromJson(json.decode(response.body));

      return userInfo;
    } catch (ex, trace) {
      debugPrint("${DateTime.now()} ex: $ex");
      debugPrint("${DateTime.now()} trace: $trace");

      if (ex.runtimeType != StreamError) throw StreamError.operationError;
      throw ex;
    }
  }

  Future<List<FeedNetworkModel>> requestUserPhotos(String username, int page) async {
    try {
      String url = "/users/$username/photos?${feedQueryParameters(page)}";

      http.Response response = await makeRequest(url);
      final userPhotos = feedNetworkModelFromJson(response.body);

      return userPhotos;
    } catch (ex, trace) {
      debugPrint("${DateTime.now()} ex: $ex");
      debugPrint("${DateTime.now()} trace: $trace");

      if (ex.runtimeType != StreamError) throw StreamError.operationError;
      throw ex;
    }
  }

  Future<List<FeedNetworkModel>> requestLikeUserPhotos(String username, int page) async {
    try {
      String url = "/users/$username/likes?${feedQueryParameters(page)}";

      http.Response response = await makeRequest(url);
      final userPhotos = feedNetworkModelFromJson(response.body);

      return userPhotos;
    } catch (ex, trace) {
      debugPrint("${DateTime.now()} ex: $ex");
      debugPrint("${DateTime.now()} trace: $trace");

      if (ex.runtimeType != StreamError) throw StreamError.operationError;
      throw ex;
    }
  }

  Future<List<Collections>> requestCollectionsUserPhotos(String username, int page) async {
    try {
      String url = "/users/$username/collections?${feedQueryParameters(page)}";

      http.Response response = await makeRequest(url);
      final userPhotos = collectionsFromJson(response.body);

      return userPhotos;
    } catch (ex, trace) {
      debugPrint("${DateTime.now()} ex: $ex");
      debugPrint("${DateTime.now()} trace: $trace");

      if (ex.runtimeType != StreamError) throw StreamError.operationError;
      throw ex;
    }
  }

  Future<List<Collections>> requestCollectionsById(int collectionsId, int page) async {
    try {
      String url = "/users/$collectionsId/collections?${feedQueryParameters(page)}";

      http.Response response = await makeRequest(url);
      final userPhotos = collectionsFromJson(response.body);

      return userPhotos;
    } catch (ex, trace) {
      debugPrint("${DateTime.now()} ex: $ex");
      debugPrint("${DateTime.now()} trace: $trace");

      if (ex.runtimeType != StreamError) throw StreamError.operationError;
      throw ex;
    }
  }
}
