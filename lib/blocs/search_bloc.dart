import 'dart:async';

import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/network/api/search_api.dart';
import 'package:skill_branch_flutter/network/models/models.dart';

class SearchBloc extends BaseBloc {
  final userInfoController = StreamController<String>();
  Stream<String> get userInfoStream => userInfoController.stream;

  String lastSearchWord;

  SearchApi _api;

  @override
  void init() {
    _api = SearchApi();
  }

  @override
  dispose() {
    userInfoController.close();
  }

  Future<List<FeedNetworkModel>> search(int page) async {
    try {
      if (lastSearchWord != null && lastSearchWord.isNotEmpty) {
        final serachResult = await _api.requestSearch(lastSearchWord, page: page);
        return serachResult.results;
      }

      return [];
    } catch (ex, trace) {
      print(ex);
      print(trace);

      return [];
    }
  }
}
