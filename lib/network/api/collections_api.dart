import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:skill_branch_flutter/base/base_api.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/network/models/models.dart';

class CollectionApi extends BaseApi {
  Future<List<FeedNetworkModel>> requestCollectionsPhotos(String collectionsId, int page) async {
    try {
      String url ="/collections/$collectionsId/photos?${feedQueryParameters(page)}";

      final response = await makeRequest(url);
      List<FeedNetworkModel> userPhotos = feedNetworkModelFromJson(response.body);

      return userPhotos;
    } catch (ex, trace) {
      debugPrint("${DateTime.now()} ex: $ex");
      debugPrint("${DateTime.now()} trace: $trace");

      if (ex.runtimeType != StreamError) throw StreamError.operationError;
      throw ex;
    }
  }
  
}
