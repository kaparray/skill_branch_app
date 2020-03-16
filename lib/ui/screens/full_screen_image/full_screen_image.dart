import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skill_branch_flutter/blocs/image_bloc.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/res/res.dart';

import 'package:flutter/cupertino.dart';
import 'package:skill_branch_flutter/res/styles.dart';
import 'package:skill_branch_flutter/ui/lib/like_button.dart';

const double _kImageSize = 42;

class FullScreenImage extends StatefulWidget {
  FullScreenImage({this.heroTag, this.photo});

  final String heroTag;
  final FeedNetworkModel photo;

  @override
  State<StatefulWidget> createState() {
    return FullScreenImageState();
  }
}

class FullScreenImageState extends State<FullScreenImage> {
  ImageBloc imageBloc;

  @override
  void initState() {
    super.initState();
    imageBloc = ImageBloc(widget.photo);
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
                  style: AppStyles.text5,
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
    return LikeButton(
      likeCount: imageBloc.likes,
      isLiked: imageBloc.likedByUser,
      likePhoto: () => imageBloc.likePhoto(),
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
        style: AppStyles.text4,
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
                style: AppStyles.textBlack2,
              ),
              Text(imageBloc.username, style: AppStyles.textBlack1.copyWith(color: AppColors.manatee)),
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
          style: AppStyles.text6.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
