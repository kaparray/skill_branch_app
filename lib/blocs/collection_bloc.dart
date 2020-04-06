import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart' hide Container;
import 'package:kiwi/kiwi.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/network/api/apis.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/navigation/navigation_actions.dart';
import 'package:skill_branch_flutter/redux/navigation/routes.dart';
import 'package:skill_branch_flutter/redux/store.dart';

class CollectionBloc extends BaseBloc {
  final _collectionPhotoController = StreamController<StreamData<List<FeedNetworkModel>>>();
  Stream<StreamData<List<FeedNetworkModel>>> get collectionPhotoControllerStream => _collectionPhotoController.stream;

  List<FeedNetworkModel> cacheCollectionPhoto = [];


  @override
  void init() {}

  @override
  void dispose() {
    _collectionPhotoController.close();
  }

  void pop() {
    store.dispatch(RouteTo(Routes.pop));
  }

  Future<List<FeedNetworkModel>> getCollectionPhotosById(String id, int index) async {
    if (cacheCollectionPhoto == null) {
      _collectionPhotoController.add(StreamData(inProgress: true));
    }
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      _collectionPhotoController.add(StreamData(error: StreamError.connectionError));
      return [];
    } else {
      List<FeedNetworkModel> userFeed = await Container()<CollectionApi>().requestCollectionsPhotos(id, index);

      cacheCollectionPhoto.addAll(userFeed);
      _collectionPhotoController.add(StreamData(data: cacheCollectionPhoto));

      return userFeed;
    }
  }

  void goToFullScreen(int index) {
    store.dispatch(RouteTo(
      Routes.fullScreen,
      payload: {'photo': cacheCollectionPhoto[index], 'heroTag': 'cacheCollectionPhoto$index'},
    ));
  }

  double calculateHeight(BuildContext context, int index) {
    return cacheCollectionPhoto[index].height * MediaQuery.of(context).size.width / cacheCollectionPhoto[index].width;
  }

  String regularUserFeedPhoto(int index) {
    return cacheCollectionPhoto[index].urls?.regular ?? '';
  }
}
