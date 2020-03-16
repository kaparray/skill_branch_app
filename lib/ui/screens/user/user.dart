import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/store.dart';
import 'package:skill_branch_flutter/res/res.dart';
import 'package:skill_branch_flutter/res/styles.dart';
import 'package:skill_branch_flutter/ui/screens/user/user_collections.dart';
import 'package:skill_branch_flutter/ui/screens/user/user_photo.dart';

const double _kBorderSidewidth = 3.0;
const double _kUserImageHeight = 72.0;

enum UserPhotoType { userPhotos, likeUserPhotos, userCollections }

class UserProfile extends StatefulWidget {
  UserProfile({this.user, this.isMyProfile, Key key}) : super(key: key);

  final UserNetworkModel user;
  final bool isMyProfile;

  @override
  State<StatefulWidget> createState() {
    return UserProfileState();
  }
}

class UserProfileState extends State<UserProfile> with SingleTickerProviderStateMixin {
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();

    if (widget.isMyProfile) {
      UserNetworkModel userData = store.state.userState.userData;
      userBloc = UserBloc(userData);
      userBloc.init();
    } else {
      userBloc = UserBloc(widget.user);
      userBloc.init();
    }

    userBloc.tabController = TabController(length: 3, vsync: this);
    userBloc.startTabListen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppbar(),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [SliverToBoxAdapter(child: _buildHederContant())];
          },
          body: Column(
            children: <Widget>[
              _buildTabBar(),
              const Divider(
                color: AppColors.mercury,
                thickness: 2,
                height: 1,
              ),
              Expanded(
                child: TabBarView(
                  controller: userBloc.tabController,
                  children: <Widget>[
                    UserPhoto(userBloc, UserPhotoType.userPhotos),
                    UserPhoto(userBloc, UserPhotoType.likeUserPhotos),
                    UserCollections(userBloc),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(CupertinoIcons.back, color: Colors.black),
        onPressed: userBloc.pop,
      ),
      backgroundColor: AppColors.white,
      centerTitle: true,
      title: Text(
        userBloc.username,
        style: TextStyle(color: Colors.black),
      ),
      elevation: 0.0,
    );
  }

  Widget _buildHederContant() {
    return StreamBuilder(
      stream: userBloc.userInfoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: CachedNetworkImage(
                      height: _kUserImageHeight,
                      width: _kUserImageHeight,
                      imageUrl: userBloc.largeProfileImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildFollowers(),
                      const SizedBox(height: 11),
                      if (userBloc.location.isNotEmpty)
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/maps-and-flags.png',
                              width: 10,
                              height: 13,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              userBloc.location,
                              style: AppStyles.textBlack1,
                            ),
                          ],
                        ),
                      const SizedBox(width: 8),
                      if (userBloc.portfolioUrl != null)
                        GestureDetector(
                          onTap: () => userBloc.launchUrl(),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/group.png',
                                width: 10,
                                height: 13,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                userBloc.portfolioUrl,
                                style: AppStyles.textBlack1,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                userBloc.profileBio,
                style: AppStyles.text3,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFollowers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              userBloc.followersCount,
              style: AppStyles.textBlack2.copyWith(color: AppColors.dodgerBlue),
            ),
            const SizedBox(height: 1),
            Text(
              'followers',
              style: AppStyles.textBlack1,
            ),
          ],
        ),
        const SizedBox(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              userBloc.followingCount,
              style: AppStyles.textBlack2.copyWith(color: AppColors.dodgerBlue),
            ),
            const SizedBox(height: 1),
            Text(
              'following',
              style: AppStyles.textBlack1,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return StreamBuilder(
        stream: userBloc.tabStream,
        builder: (BuildContext context, snapshot) {
          return TabBar(
            controller: userBloc.tabController,
            indicatorColor: Theme.of(context).primaryColor,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: _kBorderSidewidth, color: AppColors.dodgerBlue),
              insets: EdgeInsets.symmetric(
                horizontal: userBloc.horizontalInsets(context),
              ),
            ),
            tabs: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Image.asset(
                  'assets/icons/home.png',
                  color: snapshot.data == 0 ? AppColors.dodgerBlue : AppColors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Image.asset(
                  'assets/icons/like.png',
                  color: snapshot.data == 1 ? AppColors.dodgerBlue : AppColors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Image.asset(
                  'assets/icons/bookmark.png',
                  color: snapshot.data == 2 ? AppColors.dodgerBlue : AppColors.black,
                ),
              ),
            ],
          );
        });
  }
}
