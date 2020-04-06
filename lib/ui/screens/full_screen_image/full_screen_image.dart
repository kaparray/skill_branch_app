import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:skill_branch_flutter/blocs/image_bloc.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/app/app_state.dart';
import 'package:skill_branch_flutter/res/res.dart';

import 'package:flutter/cupertino.dart';
import 'package:skill_branch_flutter/res/styles.dart';
import 'package:skill_branch_flutter/ui/lib/like_button.dart';

const double _kImageSize = 42;

class FullScreenImage<StateT> extends StatefulWidget {
  FullScreenImage({this.heroTag, this.listState, this.index});

  final String heroTag;
  final StateT listState;
  final int index;

  @override
  State<StatefulWidget> createState() {
    return FullScreenImageState<StateT>();
  }
}

class FullScreenImageState<StateT> extends State<FullScreenImage> {
  ImageBloc imageBloc;

  @override
  void initState() {
    super.initState();
    imageBloc = ImageBloc(widget.listState[widget.index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeroImage(),
            const SizedBox(height: 11),
            if (imageBloc.altDescription != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  imageBloc.altDescription,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.h3,
                ),
              ),
            const SizedBox(height: 9),
            _buildPhotoMeta(),
            const SizedBox(height: 17),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLikeButton() {
    // return LikeButton(
    //   likeCount: imageBloc.likes,
    //   isLiked: imageBloc.likedByUser,
    //   likePhoto: () => imageBloc.likePhoto(),
    // );

    return StoreConnector<AppState, StateT>(
      converter: (store) {
        return widget.listState;
      },
      onWillChange: (_, __) {
        print("9999 = $__");
      },
      builder: (BuildContext context, StateT state) {
        print("00000000 = ${state}");

        return GestureDetector(
         // onTap: () => feedBloc.likePhoto(index),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/icons/like.png',
                    width: 21,
                    height: 18.3,
                    color: state[widget.index].likedByUser ? Colors.red : Colors.black,
                  ),
                  SizedBox(width: 4.21),
                  Text(
                    state[widget.index].likes.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      height: 16 / 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: AppColors.grayChateau,
        ),
        onPressed: imageBloc.pop,
      ),
      backgroundColor: AppColors.white,
      centerTitle: true,
      title: Text(
        'Photo',
        style: AppStyles.h2Black,
      ),
    );
  }

  Widget _buildHeroImage() {
    return Hero(
      tag: widget.heroTag,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(17)),
          child: Container(
            color: AppColors.alto,
            child: CachedNetworkImage(
              imageUrl: imageBloc.regularPhoto,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          _buildUserAvatar(),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                imageBloc.name,
                style: AppStyles.h1Black,
              ),
              Text(imageBloc.username, style: AppStyles.h5Black.copyWith(color: AppColors.manatee)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: _buildLikeButton(),
          ),
          Expanded(
            child: _buildButton(imageBloc.downloadPhoto, 'Save'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildButton(() {
              imageBloc.openInWeb();
            }, 'Visit'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    return GestureDetector(
      onTap: () => imageBloc.goToUserScreen(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1),
          height: _kImageSize,
          width: _kImageSize,
          child: CachedNetworkImage(
            imageUrl: imageBloc.profileImageLarge,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(Function onTap, String text) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.dodgerBlue,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          text,
          style: AppStyles.h4.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
