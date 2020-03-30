import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/network/api/apis.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/navigation/navigation_actions.dart';
import 'package:skill_branch_flutter/redux/navigation/routes.dart';
import 'package:skill_branch_flutter/redux/store.dart';
import 'package:skill_branch_flutter/ui/screens/user/user.dart';

import 'package:url_launcher/url_launcher.dart';

class UserBloc extends BaseBloc {
  UserBloc(this._cacheUserInfo) {
    _userInfoController.add(StreamData(data: _cacheUserInfo));
  }
  TabController tabController;

  final _tabStreamController = StreamController<int>();
  Stream<int> get tabStream => _tabStreamController.stream;

  final _api = UserApi();

  final StreamController<StreamData<UserNetworkModel>> _userInfoController = StreamController();
  Stream<StreamData<UserNetworkModel>> get userInfoStream => _userInfoController.stream;

  UserNetworkModel _cacheUserInfo;
  List<FeedNetworkModel> cacheUserFeed = [];
  List<FeedNetworkModel> cacheLikeUserFeed = [];
  List<Collections> cacheCollectionsUserFeed = [];

  @override
  void init() {
    getUserInfo();
  }

  void startTabListen() {
    tabController.addListener(() {
      _tabStreamController.add(tabController.index);
    });
  }

  @override
  dispose() {
    _userInfoController.close();
  }

  void pop() {
    store.dispatch(RouteTo(Routes.pop));
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
        UserNetworkModel userInfo = await _api.requestUserInfo(username);
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
      List<FeedNetworkModel> userFeed = await _api.requestUserPhotos(username, index);
      cacheUserFeed.addAll(userFeed);

      return userFeed;
    }
  }

  Future<List<FeedNetworkModel>> getLikeUserPhotos(int index) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none)
      return [];
    else {
      List<FeedNetworkModel> userFeed = await _api.requestLikeUserPhotos(username, index);
      cacheLikeUserFeed.addAll(userFeed);

      return userFeed;
    }
  }

  Future<List<Collections>> getCollectionsUserPhotos(int index) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none)
      return [];
    else {
      List<Collections> userFeed = await _api.requestCollectionsUserPhotos(username, index);
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

  void goToCollections(int index) {
    store.dispatch(RouteTo(Routes.collections, payload: cacheCollectionsUserFeed[index]));
  }

  get portfolioUrl {
    if (_cacheUserInfo?.portfolioUrl != null) {
      return _cacheUserInfo?.portfolioUrl?.replaceFirst('https://', '')?.replaceFirst('http://', '');
    }
  }

  String get profileBio => _cacheUserInfo?.bio ?? '';
  String get followersCount => '${_cacheUserInfo?.followersCount ?? ''}';
  String get followingCount => '${_cacheUserInfo?.followingCount ?? ''}';
  String get name => _cacheUserInfo?.name ?? '';
  String get username => _cacheUserInfo?.username ?? '';
  String get largeProfileImage => _cacheUserInfo?.profileImage?.large?.replaceAll('128', '288') ?? '';
  String get location => _cacheUserInfo?.location ?? '';

  String regularUserFeedPhoto(int index, UserPhotoType type) {
    switch (type) {
      case UserPhotoType.userPhotos:
        return cacheUserFeed[index].urls?.regular ?? '';
      case UserPhotoType.userPhotos:
        return cacheLikeUserFeed[index].urls?.regular ?? '';
      case UserPhotoType.userCollections:
        if (cacheCollectionsUserFeed.length > index) {
          return (cacheCollectionsUserFeed[index]?.previewPhotos?.length ?? -1) >= 3
              ? (cacheCollectionsUserFeed[index]?.previewPhotos[2]?.urls?.regular ?? '')
              : '';
        }
        return '';
      default:
        return '';
    }
  }

  double calculateImageHeight(BuildContext context, int index, UserPhotoType type) {
    switch (type) {
      case UserPhotoType.userPhotos:
        return (cacheUserFeed[index]?.height ?? 1.0) *
            MediaQuery.of(context).size.width /
            (cacheUserFeed[index]?.width ?? 1.0);
      case UserPhotoType.userPhotos:
        return (cacheLikeUserFeed[index]?.height ?? 1.0) *
            MediaQuery.of(context).size.width /
            (cacheUserFeed[index]?.width ?? 1.0);
      case UserPhotoType.userCollections:
        if (cacheCollectionsUserFeed.length > index) {
          return (cacheCollectionsUserFeed[index].coverPhoto?.height ?? 1.0) *
              MediaQuery.of(context).size.width /
              (cacheCollectionsUserFeed[index].coverPhoto?.width ?? 1.0);
        }

        return 0;
      default:
        return 0;
    }
  }

  void goToFullScreen(int index, UserPhotoType type) {
    switch (type) {
      case UserPhotoType.userPhotos:
        store.dispatch(RouteTo(
          Routes.fullScreen,
          payload: {'photo': cacheUserFeed[index], 'heroTag': 'cacheUserFeed$index'},
        ));
        break;
      case UserPhotoType.userPhotos:
        store.dispatch(RouteTo(
          Routes.fullScreen,
          payload: {'photo': cacheLikeUserFeed[index], 'heroTag': 'cacheLikeUserFeed$index'},
        ));
        break;
      case UserPhotoType.userCollections:
        store.dispatch(RouteTo(
          Routes.fullScreen,
          payload: {'photo': cacheCollectionsUserFeed[index], 'heroTag': 'cacheCollectionsUserFeed$index'},
        ));
        break;
      default:
    }
  }
}
