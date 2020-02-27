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
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          _buildHeroImage(),
          _buildDescription(),
          if (feedBloc.altDescriptionFull != null)
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                feedBloc.altDescriptionFull,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          _buildLikeButton(),
          const SizedBox(height: 16),
          _buildActionButton(),
        ]),
      ),
    );
  }

  Widget _buildLikeButton() {
    final photoId = feedBloc.photoIdFull;
    final likedByUser = feedBloc.likedByUserFull;

    return LikeButton(
      onChange: () async => await feedBloc.likePhoto(photoId, likedByUser),
      isLike: feedBloc.likedByUserFull,
      likeCounter: feedBloc.likesFull,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(CupertinoIcons.back, color: Colors.black),
        onPressed: feedBloc.pop,
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text('Photo', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildHeroImage() {
    return Hero(
      tag: widget.heroTag,
      child: CachedNetworkImage(
        imageUrl: feedBloc.regularPhotoFull,
        placeholder: (context, url) => Center(
          child: const CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: <Widget>[
          _buildUserAvatar(),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                feedBloc.nameFull,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(feedBloc.usernameFull),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlineButton(
          onPressed: () {
            final downloadLink = feedBloc.downloadFull;
            feedBloc.downloadPhoto(downloadLink);
          },
          child: Text('SAVE'),
        ),
        const SizedBox(width: 16),
        OutlineButton(
          onPressed: () {
            final htmlFull = feedBloc.htmlFull;
            feedBloc.launchUrl(htmlFull);
          },
          child: Text('VISIT'),
        ),
      ],
    );
  }

  Widget _buildUserAvatar() {
    return GestureDetector(
      onTap: feedBloc.goToUserScreenFull,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
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
}
