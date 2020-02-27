import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:skill_branch_flutter/base/base_api.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/network/models/models.dart';

class SearchApi extends BaseApi {
  Future<Search> requestSearch(String query, {int page = 1}) async {
    try {
      Map<String, dynamic> queryParametrs = {
        'query': query,
        'page': page,
      };

      String url = "/search/photos?${mapToQueryParametrs(queryParametrs)}";

      final response = await makeRequest(url);
      final listPhotos = Search.fromJson(json.decode(response.body));

      return listPhotos;
    } catch (ex, trace) {
      debugPrint("${DateTime.now()} ex: $ex");
      debugPrint("${DateTime.now()} trace: $trace");

      if (ex.runtimeType != StreamError) throw StreamError.operationError;
      throw ex;
    }
  }
}
