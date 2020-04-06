import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:loadmore/loadmore.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/base/inhereted_widget.dart';
import 'package:skill_branch_flutter/redux/app/app_state.dart';
import 'package:skill_branch_flutter/redux/feed/feed_state.dart';
import 'package:skill_branch_flutter/redux/store.dart';
import 'package:skill_branch_flutter/res/colors.dart';
import 'package:skill_branch_flutter/res/styles.dart';

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
    feedBloc = container<FeedBloc>();
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
          return Column(
            children: <Widget>[
              _buildItem(index),
              Divider(thickness: 2, color: AppColors.mercury),
            ],
          );
        },
        itemCount: store.state.feedState.feed.length,
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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                store.state.feedState.feed[index].altDescription,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.h3.copyWith(color: AppColors.manatee),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPhotoMeta(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildUserAvatar(index),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    store.state.feedState?.feed[index]?.user?.name ?? '',
                    style: AppStyles.h2Black,
                  ),
                  Text(
                    store.state.feedState?.feed[index]?.user?.username ?? '',
                    style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
                  ),
                ],
              ),
            ],
          ),
          _buildLikeButton(index),
        ],
      ),
    );
  }

  Widget _buildLikeButton(int index) {
    store.onChange.listen((data) {
      print("data = ${data.feedState.feed}");
    });

    return StoreConnector<AppState, FeedState>(
      converter: (store) {
        return store.state.feedState;
      },
      onWillChange: (_, __) {
        print("9999 = $__");
      },
      builder: (BuildContext context, FeedState state) {
        print("00000000 = ${state}");

        return GestureDetector(
          onTap: () => feedBloc.likePhoto(index),
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
                    color: store.state.feedState.feed[index].likedByUser ? Colors.red : Colors.black,
                  ),
                  SizedBox(width: 4.21),
                  Text(
                    store.state.feedState.feed[index].likes.toString(),
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

  Widget _buildUserAvatar(int index) {
    return GestureDetector(
      onTap: () => feedBloc.goToUserScreen(index),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          width: 40,
          height: 40,
          imageUrl: feedBloc.profileImageLarge(index),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildImage(int index) {
    return Hero(
      tag: 'feed$index',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(17)),
          child: Container(
            color: AppColors.white,
            height: feedBloc.calculatePhotoHeight(context, index),
            child: CachedNetworkImage(
              imageUrl: feedBloc.regularPhoto(index),
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
