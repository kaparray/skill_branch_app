import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart' hide Container;
import 'package:kiwi/kiwi.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/network/api/apis.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/store.dart';
import 'package:skill_branch_flutter/ui/screens/user/user.dart';

import 'package:url_launcher/url_launcher.dart';

class UserBloc extends BaseBloc {
  UserBloc(this._cacheUserInfo) {
    _userInfoController.add(StreamData(data: _cacheUserInfo));
  }


  UserNetworkModel _cacheUserInfo;
  List<FeedNetworkModel> cacheLikeUserFeed = [];
  List<Collections> cacheCollectionsUserFeed = [];

  @override
  void init() {
    getUserInfo();
  }



  @override
  dispose() {
    _userInfoController.close();
  }

  Future<void> getUserInfo() async {
    try {
      if (_cacheUserInfo == null) {
        _userInfoController.add(StreamData(inProgress: true));
      }
      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        _userInfoController.add(StreamData(error: StreamError.connectionError));
      } else {
        UserNetworkModel userInfo = await Container()<UserApi>().requestUserInfo(username);
        _userInfoController.add(StreamData(data: userInfo));
        _cacheUserInfo = userInfo;
      }
    } catch (ex, trace) {
      print(ex);
      print(trace);
    }
  }

  Future<List<FeedNetworkModel>> getUserPhotos(int index) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none)
      return [];
    else {
      List<FeedNetworkModel> userFeed = await Container()<UserApi>().requestUserPhotos(username, index);
      dispatch(UpdateUserFeed(userFeed));

      return userFeed;
    }
  }

  Future<List<FeedNetworkModel>> getLikeUserPhotos(int index) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none)
      return [];
    else {
      List<FeedNetworkModel> userFeed = await Container()<UserApi>().requestLikeUserPhotos(username, index);
      cacheLikeUserFeed.addAll(userFeed);

      return userFeed;
    }
  }

  Future<List<Collections>> getCollectionsUserPhotos(int index) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none)
      return [];
    else {
      List<Collections> userFeed = await Container()<UserApi>().requestCollectionsUserPhotos(username, index);
      cacheCollectionsUserFeed.addAll(userFeed);

      return userFeed;
    }
  }

  Future<void> launchUrl() async {
    if (await canLaunch(_cacheUserInfo?.portfolioUrl)) {
      await launch(_cacheUserInfo?.portfolioUrl);
    } else {
      throw 'Could not launch ${_cacheUserInfo?.portfolioUrl}';
    }
  }

  double horizontalInsets(BuildContext context) {
    return MediaQuery.of(context).size.width / 3 - 24;
  }

  
  

  double calculateImageHeight(BuildContext context, int index) {
    // switch (type) {
    //   case UserPhotoType.userPhotos:
    //     return (state.userState.userPhoto[index]?.height ?? 1.0) *
    //         MediaQuery.of(context).size.width /
    //         (state.userState.userPhoto[index]?.width ?? 1.0);
    //   case UserPhotoType.userPhotos:
    //     return (cacheLikeUserFeed[index]?.height ?? 1.0) *
    //         MediaQuery.of(context).size.width /
    //         (state.userState.userPhoto[index]?.width ?? 1.0);
    //   case UserPhotoType.userCollections:
    //     if (cacheCollectionsUserFeed.length > index) {
    //       return (cacheCollectionsUserFeed[index].coverPhoto?.height ?? 1.0) *
    //           MediaQuery.of(context).size.width /
    //           (cacheCollectionsUserFeed[index].coverPhoto?.width ?? 1.0);
    //     }

    //     return 0;
    //   default:
    //     return 0;
    // }
  }

  void goToFullScreen(int index) {
    // switch (type) {
    //   case UserPhotoType.userPhotos:
    //     store.dispatch(RouteTo(
    //       Routes.fullScreen,
    //       payload: {'photo': state.userState.userPhoto[index], 'heroTag': 'cacheUserFeed$index'},
    //     ));
    //     break;
    //   case UserPhotoType.likeUserPhotos:
    //     store.dispatch(RouteTo(
    //       Routes.fullScreen,
    //       payload: {'photo': cacheLikeUserFeed[index], 'heroTag': 'cacheLikeUserFeed$index'},
    //     ));
    //     break;
    //   case UserPhotoType.userCollections:
    //     store.dispatch(RouteTo(
    //       Routes.fullScreen,
    //       payload: {'photo': cacheCollectionsUserFeed[index], 'heroTag': 'cacheCollectionsUserFeed$index'},
    //     ));
    //     break;
    //   default:
    // }
  }
}
