import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/base/base_vm.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/ui/screens/user/user.dart';

class UserPhotoVM extends BaseVM {
  UserPhotoVM() {
    listStream = store.substateStream((state) => state.userState.myPhotos);
  }

  bool isMyProfile;
  List<FeedNetworkModel> listPhoto = [];

  Stream<SubstateChange<List<FeedNetworkModel>>> listStream;

  UserBloc userBloc;

  final _tabStreamController = StreamController<int>();
  Stream<int> get tabStream => _tabStreamController.stream;

  final StreamController<StreamData<UserNetworkModel>> _userInfoController = StreamController();
  Stream<StreamData<UserNetworkModel>> get userInfoStream => _userInfoController.stream;

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

  String regularUserFeedPhoto(List previewPhotos) {
    if (previewPhotos.isNotEmpty && (previewPhotos?.length ?? -1) >= 3) {
      return (previewPhotos[2]?.urls?.regular ?? '');
    }

    return '';
  }
}
