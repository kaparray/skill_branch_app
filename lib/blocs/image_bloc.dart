import 'package:connectivity/connectivity.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/network/api/apis.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/navigation/navigation_actions.dart';
import 'package:skill_branch_flutter/redux/navigation/routes.dart';
import 'package:skill_branch_flutter/redux/store.dart';
import 'package:skill_branch_flutter/redux/user/user_actions.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageBloc extends BaseBloc {
  ImageBloc(this.photo);

  final _api = PhotosApi();

  final FeedNetworkModel photo;

  void pop() {
    store.dispatch(RouteTo(Routes.pop));
  }

  void goToUserScreen() {
    store.dispatch(RouteTo(Routes.profile, payload: userInfo));
  }

  void openInWeb() async {
    if (await canLaunch(html)) {
      await launch(html);
    } else {
      throw 'Could not launch $html';
    }
  }

  Future<bool> likePhoto() async {
    if (state.userState.isAuth) {
      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        throw StreamError.connectionError;
      } else {
        bool liked = await _api.likeUnlikePhoto(photoId, likedByUser);

        if (liked)
          photo.likes++;
        else
          photo.likes--;

        return liked;
      }
    } else {
      dispatch(AuthUserAction());
    }

    return likedByUser;
  }

  void downloadPhoto() {
    ImageDownloader.downloadImage(downloadLink).then((_) async {
      store.dispatch(DialogAction(Dialogs.done));
      await Future.delayed(Duration(milliseconds: 1500)).then((_) {
        store.dispatch(DialogAction(Dialogs.close));
      });
    });
  }

  UserNetworkModel get userInfo => photo.user;
  String get photoId => photo?.id ?? '';
  String get regularPhoto => photo.urls.regular ?? '';
  String get profileImageLarge => photo.user.profileImage.large ?? '';
  String get username => "@${photo.user.username}" ?? 'No username :(';
  String get altDescription => photo?.altDescription ?? '';
  bool get likedByUser => photo?.likedByUser ?? false;
  int get likes => photo?.likes;
  String get name => photo?.user?.name ?? 'No name :(';
  String get downloadLink => photo?.links?.download ?? '';
  String get html => photo?.links?.html ?? '';

  @override
  void init() {}
}
