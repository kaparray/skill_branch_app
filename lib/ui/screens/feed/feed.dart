import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/base/inhereted_widget.dart';
import 'package:skill_branch_flutter/di/injector.dart';
import 'package:skill_branch_flutter/ui/lib/like_button.dart';

import 'package:kiwi/kiwi.dart' as kiwi;

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);
  
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin<Feed> {
  
  FeedBloc feedBloc;

  @override
  void initState() {
    super.initState();
    var container = kiwi.Container();
    feedBloc = container<FeedService>().feedBloc;

    print('feedBloc = ${container<FeedService>().feedBloc.pageIndex}');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadMore(
      delegate: DefaultLoadMoreDelegate(),
      textBuilder: DefaultLoadMoreTextBuilder.english,
      onLoadMore: () async {
        await feedBloc.getPhotos();
        setState(() {});
        return true;
      },
      child: ListView.builder(
        controller: Globals.of(context).feedScrollController,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(index);
        },
        itemCount: feedBloc.allPhotos.length,
      ),
    );
  }

  Widget _buildItem(int index) {
    return GestureDetector(
      onTap: () => feedBloc.goToFullScreen(index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildImage(index),
          _buildPhotoMeta(index),
          if (feedBloc.altDescription(index) != null)
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                feedBloc.altDescription(index),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          _buildLikeButton(index),
        ],
      ),
    );
  }

  Widget _buildPhotoMeta(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: <Widget>[
          _buildUserAvatar(index),
          SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(feedBloc.username(index), style: TextStyle(fontWeight: FontWeight.bold)),
              Text("@${feedBloc.username(index)}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLikeButton(int index) {
    final photoId = feedBloc.photoId(index);
    final likedByUser = feedBloc.likedByUser(index);
        
    return LikeButton(
      onChange: () async => await feedBloc.likePhoto(photoId, likedByUser),
      isLike: feedBloc.likedByUser(index),
      likeCounter: feedBloc.likes(index),
    );
  }

  Widget _buildUserAvatar(int index) {
     return GestureDetector(
        onTap: () => feedBloc.goToUserScreen(index),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 42,
            width: 42,
            child: CachedNetworkImage(
              imageUrl: feedBloc.profileImageLarge(index),
              fit: BoxFit.fill,
            ),
          ),
        ),
    );
  }

  Widget _buildImage(int index) {
    return Hero(
      tag: 'feed$index',
      child: Container(
        color: Color(0xFFD2D2D2),
        height: feedBloc.calculatePhotoHeight(context, index),
        child: CachedNetworkImage(
          imageUrl: feedBloc.regularPhoto(index),
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
