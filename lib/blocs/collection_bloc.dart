import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/network/api/apis.dart';
import 'package:skill_branch_flutter/network/models/models.dart';

class CollectionBloc extends BaseBloc {
  final _collectionPhotoController =  StreamController<StreamData<List<FeedNetworkModel>>>();
  Stream<StreamData<List<FeedNetworkModel>>> get collectionPhotoControllerStream => _collectionPhotoController.stream;

  List<FeedNetworkModel> cacheCollectionPhoto = [];

  final _api = CollectionApi();

  @override
  void init() {}

  @override
  void dispose() {
    _collectionPhotoController.close();
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
      
      List<FeedNetworkModel> userFeed = await _api.requestCollectionsPhotos(id, index);
                  print('data = ${userFeed[index].urls.full}');

      cacheCollectionPhoto.addAll(userFeed);
      _collectionPhotoController.add(StreamData(data: cacheCollectionPhoto));

      return userFeed;
    }
  }


}
