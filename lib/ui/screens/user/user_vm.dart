import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/base/base_vm.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/ui/screens/user/user.dart';
import 'package:url_launcher/url_launcher.dart';

class UserVM extends BaseVM {
  TabController tabController;
  UserNetworkModel _cacheUserInfo;
  bool isMyProfile;
  List<FeedNetworkModel> listPhoto = [];
  List<FeedNetworkModel> cacheLikeUserFeed = [];
  List<Collections> cacheCollectionsUserFeed = [];

  UserBloc userBloc;

  final _tabStreamController = StreamController<int>();
  Stream<int> get tabStream => _tabStreamController.stream;

  final StreamController<StreamData<UserNetworkModel>> _userInfoController = StreamController();
  Stream<StreamData<UserNetworkModel>> get userInfoStream => _userInfoController.stream;

  void startTabListen() {
    tabController.addListener(() {
      _tabStreamController.add(tabController.index);
    });
  }

  void pop() {}

  void goToCollections(int index) {
    // TODO
    // store.dispatch(RouteTo(Routes.collections, payload: cacheCollectionsUserFeed[index]));
  }

  @override
  void dispose() {
    super.dispose();
    _tabStreamController.close();
    _userInfoController.close();
  }

  Future<void> launchUrl() async {
    if (await canLaunch(_cacheUserInfo?.portfolioUrl)) {
      await launch(_cacheUserInfo?.portfolioUrl);
    } else {
      throw 'Could not launch ${_cacheUserInfo?.portfolioUrl}';
    }
  }

  get portfolioUrl {
    if (_cacheUserInfo?.portfolioUrl != null) {
      return _cacheUserInfo?.portfolioUrl?.replaceFirst('https://', '')?.replaceFirst('http://', '');
    }
  }

  double horizontalInsets(BuildContext context) => MediaQuery.of(context).size.width / 3 - 24;
  String get profileBio => _cacheUserInfo?.bio ?? '';
  String get followersCount => '${_cacheUserInfo?.followersCount ?? ''}';
  String get followingCount => '${_cacheUserInfo?.followingCount ?? ''}';
  String get name => _cacheUserInfo?.name ?? '';
  String get username => _cacheUserInfo?.username ?? '';
  String get largeProfileImage => _cacheUserInfo?.profileImage?.large?.replaceAll('128', '288') ?? '';
  String get location => _cacheUserInfo?.location ?? '';

  String regularUserFeedPhoto(int index, UserPhotoType type) {
    if (type == UserPhotoType.userCollections && list.length > index) {
      return (list[index]?.previewPhotos?.length ?? -1) >= 3
          ? (list[index]?.previewPhotos[2]?.urls?.regular ?? '')
          : '';
    }

    return list[index].urls?.regular ?? '';
  }
}
