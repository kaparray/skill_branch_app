import 'package:built_redux/built_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:skill_branch_flutter/base/base_state.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/res/res.dart';
import 'package:skill_branch_flutter/ui/lib/empty.dart';
import 'package:skill_branch_flutter/ui/lib/error.dart';
import 'package:skill_branch_flutter/ui/screens/user/user.dart';
import 'package:skill_branch_flutter/ui/screens/user/user_photo/user_photo_vm.dart';

typedef Future<List<FeedNetworkModel>> PageFuture(int index);

class UserPhoto extends StatefulWidget {
  UserPhoto(this.userBloc);

  final UserBloc userBloc;

  @override
  State<StatefulWidget> createState() {
    return UserPhotoState();
  }
}

class UserPhotoState extends BaseState<UserPhoto, UserPhotoVM> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    viewModel = UserPhotoVM();
  }

  Widget buildImage(int index) {
    return Container(
      child: GestureDetector(
        onTap: () {
          widget.userBloc.goToFullScreen(index);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Container(
            color: AppColors.alto,
            height: widget.userBloc.calculateImageHeight(context, index),
            child: CachedNetworkImage(
              imageUrl: viewModel.regularUserFeedPhoto(index),
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildView(BuildContext context) {
    super.build(context);

    return StreamBuilder(
        stream: viewModel.listStream,
        builder: (BuildContext context, AsyncSnapshot<SubstateChange<List<FeedNetworkModel>>> snapshot) {
          return PagewiseGridView.count(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 21),
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
            pageSize: 12,
            showRetry: false,
            pageFuture: (int pageIndex) async {
              return snapshot.data.;
              // switch (widget.type) {
              //   case UserPhotoType.userPhotos:
              //     return await widget.userBloc.getUserPhotos(pageIndex + 1);
              //   case UserPhotoType.likeUserPhotos:
              //     return await widget.userBloc.getLikeUserPhotos(pageIndex + 1);
              //   default:
              //     return <FeedNetworkModel>[];
              // }
            },
            itemBuilder: (BuildContext context, FeedNetworkModel data, int index) {
              return buildImage(index);
            },
            errorBuilder: (context, error) => ErrorWidget(),
            loadingBuilder: (BuildContext context) {
              return CircularProgressIndicator();
            },
            noItemsFoundBuilder: (BuildContext context) => EmptyWidget(),
          );
        });
  }
}
