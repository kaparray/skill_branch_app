import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:skill_branch_flutter/base/base_api.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/network/models/models.dart';

class PhotosApi extends BaseApi {
  Future<List<FeedNetworkModel>> requestPhotos({int page = 1, OrderBy sortType = OrderBy.latest}) async {
    try {
      String url = "/photos?${feedQueryParameters(page)}";

      final response = await makeRequest(url);
      final listPhotos = feedNetworkModelFromJson(response.body);

      return listPhotos;
    } catch (ex, trace) {
      debugPrint("${DateTime.now()} ex: $ex");
      debugPrint("${DateTime.now()} trace: $trace");

      if (ex.runtimeType != StreamError) throw StreamError.operationError;
      throw ex;
    }
  }

  Future<Like> likeUnlikePhoto(String photoId, bool isLike) async {
    try {
      Response response;
      String url = "/photos/$photoId/like";
      print(isLike);
      
      if (isLike) {
        print("RequestType.delete");
        response = await makeRequest(url, type: RequestType.delete);
      } else {
        print("RequestType.post");
        response = await makeRequest(url, type: RequestType.post);
      }

      print("response  ${response.body}");
      Map<String, dynamic> responseParse = json.decode(response.body);

      if (responseParse.containsKey('errors')) {
        throw StreamError.accessTokenInvalid;
      }

      final photo = Like.fromJson(json.decode(response.body));
      print('likedByUser = ${photo.photo.likedByUser}');
      print('likedByUser = ${photo.photo.likes}');

      return photo;
    } catch (ex, trace) {
      debugPrint("${DateTime.now()} ex: $ex");
      debugPrint("${DateTime.now()} trace: $trace");

      if (ex.runtimeType != StreamError) throw StreamError.operationError;
      throw ex;
    }
  }
}
