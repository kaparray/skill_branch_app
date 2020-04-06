import 'dart:async';

import 'package:kiwi/kiwi.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/network/api/search_api.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/navigation/navigation_actions.dart';
import 'package:skill_branch_flutter/redux/navigation/routes.dart';
import 'package:skill_branch_flutter/redux/store.dart';

class SearchBloc extends BaseBloc {
  final userInfoController = StreamController<String>();
  Stream<String> get userInfoStream => userInfoController.stream;

  String lastSearchWord;
  final allPhotos = List<FeedNetworkModel>();

  @override
  void init() {}

  @override
  dispose() {
    userInfoController.close();
  }

  void goToFullScreen(int index) {
    store.dispatch(RouteTo(Routes.fullScreen, payload: {'photo': allPhotos[index], 'heroTag': 'feed$index'}));
  }

  Future<List<FeedNetworkModel>> search(int page) async {
    try {
      if (lastSearchWord != null && lastSearchWord.isNotEmpty) {
        final searchResult = await Container()<SearchApi>().requestSearch(lastSearchWord, page: page);
        allPhotos.addAll(searchResult.results);
        return searchResult.results;
      }

      return [];
    } catch (ex, trace) {
      print(ex);
      print(trace);

      return [];
    }
  }
}
