import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/ui/screens/user/user.dart';

typedef Future<List<FeedNetworkModel>> PageFuture(int index);

class UserPhoto extends StatefulWidget {
  UserPhoto(this.userBloc, this.type);

  final UserBloc userBloc;
  final UserPhotoType type;

  @override
  State<StatefulWidget> createState() {
    return UserPhotoState();
  }
}

class UserPhotoState extends State<UserPhoto>
    with AutomaticKeepAliveClientMixin<UserPhoto> {
  @override
  bool get wantKeepAlive => true;

  

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PagewiseGridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      childAspectRatio: 1,
      pageSize: 12,
      pageFuture: (int pageIndex) async {
        switch (widget.type) {
          case UserPhotoType.userPhotos:
            return await widget.userBloc.getUserPhotos(pageIndex + 1);
          case UserPhotoType.userPhotos:
            return await widget.userBloc.getLikeUserPhotos(pageIndex + 1);
          default:
            return <FeedNetworkModel>[];
        }
      },
      itemBuilder: (BuildContext context, FeedNetworkModel data, int index) {
        return buildImage(index);
      },
      retryBuilder: (BuildContext context, Object error) {
        return Container();
      },
      loadingBuilder: (BuildContext context) {
        return Container();
      },
      noItemsFoundBuilder: (BuildContext context) {
        return Center(
          child: const Text('Нет элементов'),
        );
      },
    );
  }

  Widget buildImage(int index) {
    return GestureDetector(
      onTap: () {
        widget.userBloc.goToFullScreen(index, widget.type);
      },
      child: Container(
        color: const Color(0xFFD2D2D2),
        height:
            widget.userBloc.caclulateImageHeight(context, index, widget.type),
        child: CachedNetworkImage(
          imageUrl: widget.userBloc.regularUserFeedPhoto(index, widget.type),
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
