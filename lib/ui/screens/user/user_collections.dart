import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/res/res.dart';
import 'package:skill_branch_flutter/static.dart';
import 'package:skill_branch_flutter/ui/lib/empty.dart';
import 'package:skill_branch_flutter/ui/lib/error.dart';
import 'package:skill_branch_flutter/ui/screens/user/user.dart';

const double _kImageWidth = 100;

typedef Future<List<Collections>> PageFuture(int index);

class UserCollections extends StatefulWidget {
  UserCollections(this.userBloc);

  final UserBloc userBloc;

  @override
  State<StatefulWidget> createState() {
    return UserCollectionsState();
  }
}

class UserCollectionsState extends State<UserCollections> with AutomaticKeepAliveClientMixin<UserCollections> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PagewiseGridView.count(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 21),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1,
      pageSize: kPerPageUserPhotos,
      showRetry: false,
      pageFuture: (int pageIndex) async {
        return await widget.userBloc.getCollectionsUserPhotos(pageIndex + 1);
      },
      itemBuilder: (BuildContext context, Collections data, int index) {
        return buildImage(index);
      },
      errorBuilder: (context, error) => ErrorWidget(),
      loadingBuilder: (BuildContext context) {
        return CircularProgressIndicator();
      },
      noItemsFoundBuilder: (BuildContext context) => EmptyWidget(),
    );
  }

  Widget buildImage(int index) {
    return GestureDetector(
      onTap: () {
        widget.userBloc.goToCollections(index);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Row(
          children: <Widget>[
            _buildImage(0),
            const SizedBox(width: 2),
            Column(
              children: <Widget>[
                _buildImage(1),
                const SizedBox(height: 2),
                _buildImage(2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(int index) {
    return Expanded(
      child: Container(
        width: _kImageWidth,
        color: AppColors.alto,
        height: widget.userBloc.calculateImageHeight(context, index, UserPhotoType.userCollections),
        child: CachedNetworkImage(
          imageUrl: widget.userBloc.regularUserFeedPhoto(index, UserPhotoType.userCollections),
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
