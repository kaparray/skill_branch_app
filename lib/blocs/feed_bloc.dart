import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart' hide Container;
import 'package:kiwi/kiwi.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/network/api/apis.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/feed/feed_actions.dart';
import 'package:skill_branch_flutter/redux/navigation/navigation_actions.dart';
import 'package:skill_branch_flutter/redux/navigation/routes.dart';
import 'package:skill_branch_flutter/redux/store.dart';
import 'package:skill_branch_flutter/redux/user/user_actions.dart';

enum OrderBy { latest, oldest, popular }

class FeedBloc extends BaseBloc {
  final allPhotos = List<FeedNetworkModel>();
  int pageIndex = 1;

  @override
  void init() {}

  Future<List<FeedNetworkModel>> getPhotos({sortType = OrderBy.latest}) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw StreamError.connectionError;
    } else {
      final listPhoto = await Container()<PhotosApi>().requestPhotos(
        page: pageIndex,
        sortType: sortType,
      );
      pageIndex++;

      store.dispatch(UpdateFeed(listPhoto));
      allPhotos.addAll(listPhoto);

      return listPhoto;
    }
  }

  void likePhoto(int index) async {
    final id = store.state.feedState.feed[index].id;

    if (state.userState.isAuth) {
      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        throw StreamError.connectionError;
      } else {
        print("11111 = ${store.state.feedState.feed[index].likedByUser}");
        Like likedByUser =
            await Container()<PhotosApi>().likeUnlikePhoto(id, store.state.feedState.feed[index].likedByUser);

        store.dispatch(UpdateFeedItem(likedByUser.photo, index));
      }
    } else {
      dispatch(AuthUserAction());
    }
  }

  void goToUserScreen(int index) {
    store.dispatch(RouteTo(Routes.profile, payload: userInfo(index)));
  }

  void pop() {
    store.dispatch(RouteTo(Routes.pop));
  }

  void goToFullScreen(int index) {
    store.dispatch(RouteTo(Routes.fullScreen, payload: {'photo': allPhotos[index], 'heroTag': 'feed$index'}));
  }

  double calculatePhotoHeight(BuildContext context, int index) {
    return allPhotos[index].height * MediaQuery.of(context).size.width / allPhotos[index].width;
  }

  String photoId(int index) => allPhotos[index]?.id ?? '';
  UserNetworkModel userInfo(int index) => allPhotos[index].user;
  String regularPhoto(int index) => allPhotos[index].urls.regular ?? '';
  String profileImageLarge(int index) => allPhotos[index].user.profileImage.large ?? '';
  String username(int index) => "@${allPhotos[index].user.username}" ?? 'No username :(';
  String altDescription(int index) => allPhotos[index]?.altDescription ?? '';
  bool likedByUser(int index) => allPhotos[index]?.likedByUser ?? false;
  int likes(int index) => allPhotos[index]?.likes;
  String name(int index) => allPhotos[index]?.user?.name ?? 'No name :(';
  String download(int index) => allPhotos[index].links?.download ?? '';
  String html(int index) => allPhotos[index].links?.html ?? '';
}
