import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/di/injector.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/ui/lib/like_button.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'package:flutter/cupertino.dart';

const double _kImageSize = 42;

class FullScreenImage extends StatefulWidget {
  FullScreenImage(this.photo, this.heroTag);

  final FeedNetworkModel photo;
  final String heroTag;

  @override
  State<StatefulWidget> createState() {
    return FullScreenImageState();
  }
}

class FullScreenImageState extends State<FullScreenImage> {
  FeedBloc feedBloc;

  @override
  void initState() {
    super.initState();
    var container = kiwi.Container();
    feedBloc = container<FeedService>().feedBloc;
  }

  @override
  Widget build(BuildContext context) {
    feedBloc.setUserModel(widget.photo);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeroImage(),
            const SizedBox(height: 11),
            if (feedBloc.altDescriptionFull != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  feedBloc.altDescriptionFull,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF8E8E93),
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    height: 20 / 14,
                    letterSpacing: 0.25,
                  ),
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
    final photoId = feedBloc.photoIdFull;
    final likedByUser = feedBloc.likedByUserFull;

    return LikeButton(
     // onChange: () async => await feedBloc.likePhoto(photoId, likedByUser),
      // isLike: feedBloc.likedByUserFull,
      // likeCounter: feedBloc.likesFull,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: Color(0xFF9FA8B3),
        ),
        onPressed: feedBloc.pop,
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        'Photo',
        style: TextStyle(
          letterSpacing: -0.41,
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontFamily: 'Roboto',
          fontStyle: FontStyle.normal,
          fontSize: 17,
          height: 22 / 17,
        ),
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
            color: Color(0xFFD2D2D2),
            child: CachedNetworkImage(
              imageUrl: widget.photo.urls.regular,
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
                  feedBloc.nameFull,
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    height: 23 / 18,
                  ),
                ),
                Text(
                  feedBloc.usernameFull,
                  style: TextStyle(
                    color: Color(0xFF8E8E93),
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontSize: 13,
                    height: 18 / 13,
                  ),
                ),
              ],
            ),
          ],
        ));
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
            child: _buildButton(() {
              final downloadLink = feedBloc.downloadFull;
              feedBloc.downloadPhoto(downloadLink);
            }, 'Save'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildButton(() {
              final htmlFull = feedBloc.htmlFull;
              feedBloc.launchUrl(htmlFull);
            }, 'Visit'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    return GestureDetector(
      onTap: feedBloc.goToUserScreenFull,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1),
          height: _kImageSize,
          width: _kImageSize,
          child: CachedNetworkImage(
            imageUrl: feedBloc.profileImageLargeFull,
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
          color: Color(0xFF39CEFD),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontSize: 14,
            height: 16 / 14,
            letterSpacing: 0.75,
          ),
        ),
      ),
    );
  }
}
