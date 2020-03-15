import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/network/api/apis.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/navigation/navigation_actions.dart';
import 'package:skill_branch_flutter/redux/navigation/routes.dart';
import 'package:skill_branch_flutter/redux/store.dart';
import 'package:skill_branch_flutter/redux/user/user_actions.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderBy { latest, oldest, popular }

class FeedBloc extends BaseBloc {
  final _api = PhotosApi();
  final allPhotos = List<FeedNetworkModel>();
  int pageIndex = 1;

  Future<List<FeedNetworkModel>> getPhotos({sortType = OrderBy.latest}) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw StreamError.connectionError;
    } else {
      final listPhoto = await _api.requestPhotos(
        page: pageIndex,
        sortType: sortType,
      );
      pageIndex++;

      allPhotos.addAll(listPhoto);

      return listPhoto;
    }
  }

  Future<bool> likePhoto(int index) async {
    final id = allPhotos[index].id;
    var likedByUser = this.likedByUser(index);

    if (state.userState.isAuth) {
      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        throw StreamError.connectionError;
      } else {
        likedByUser = await _api.likeUnlikePhoto(id, likedByUser);
        allPhotos[index].likedByUser = likedByUser;

        if (likedByUser)
          allPhotos[index].likes++;
        else
          allPhotos[index].likes--;

        return likedByUser;
      }
    } else {
      dispatch(AuthUserAction());
    }

    return likedByUser;
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

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void downloadPhoto(String downloadLink) {
    ImageDownloader.downloadImage(downloadLink).then((_) async {
      store.dispatch(DialogAction(Dialogs.done));
      await Future.delayed(Duration(milliseconds: 1500)).then((_) {
        store.dispatch(DialogAction(Dialogs.close));
      });
    });
  }

  double calculatePhotoHeight(BuildContext context, int index) {
    return allPhotos[index].height * MediaQuery.of(context).size.width / allPhotos[index].width;
  }

  UserNetworkModel userInfo(int index) => allPhotos[index].user;
  String regularPhoto(int index) => allPhotos[index].urls.regular;
  String profileImageLarge(int index) => allPhotos[index].user.profileImage.large;
  String username(int index) => allPhotos[index].user.username;
  String altDescription(int index) => allPhotos[index]?.altDescription;
  bool likedByUser(int index) => allPhotos[index]?.likedByUser ?? false;
  String photoId(int index) => allPhotos[index]?.id;
  int likes(int index) => allPhotos[index]?.likes;

  ////// Full screen
  FeedNetworkModel _feedNetworkModel;

  void setUserModel(FeedNetworkModel photo) {
    _feedNetworkModel = photo;
  }

  String get regularPhotoFull => _feedNetworkModel?.urls?.regular ?? '';
  String get profileImageLargeFull => _feedNetworkModel?.user?.profileImage?.large ?? '';
  String get usernameFull => "@${_feedNetworkModel?.user?.username}" ?? 'No username :(';
  String get nameFull => _feedNetworkModel?.user?.name ?? 'No name :(';
  String get altDescriptionFull => _feedNetworkModel?.altDescription ?? '';
  bool get likedByUserFull => _feedNetworkModel?.likedByUser ?? false;
  String get photoIdFull => _feedNetworkModel?.id ?? '';
  int get likesFull => _feedNetworkModel?.likes ?? 0;
  String get downloadFull => _feedNetworkModel?.links?.download ?? '';
  String get htmlFull => _feedNetworkModel?.links?.html ?? '';

  void goToUserScreenFull() {
    store.dispatch(RouteTo(Routes.profile, payload: _feedNetworkModel.user));
  }

  @override
  void dispose() {}

  @override
  void init() {}
}
