import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/store.dart';
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
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    if (widget.isMyProfile) {
      UserNetworkModel userData = store.state.userState.userData;
      userBloc = UserBloc(userData);
      userBloc.init();
    } else {
      userBloc = UserBloc(widget.user);
      userBloc.init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Expanded(
                child: TabBarView(
                  controller: _tabController,
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
      backgroundColor: Colors.white,
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
                              style: const TextStyle(
                                fontSize: 13,
                                height: 18 / 13,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                letterSpacing: -0.08,
                                color: Color(0xFF000000),
                              ),
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
                                style: const TextStyle(
                                  fontSize: 13,
                                  height: 18 / 13,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: -0.08,
                                  color: Color(0xFF000000),
                                ),
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
                style: TextStyle(
                  letterSpacing: -0.24,
                  fontSize: 12,
                  height: 20 / 12,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                ),
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
              style: const TextStyle(
                fontSize: 23,
                height: 23 / 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF16B9FD),
              ),
            ),
            const SizedBox(height: 1),
            Text(
              'followers',
              style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF000000),
                  height: 18 / 13,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Roboto'),
            ),
          ],
        ),
        const SizedBox(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              userBloc.followingCount,
              style: const TextStyle(
                fontSize: 23,
                height: 23 / 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF16B9FD),
              ),
            ),
            const SizedBox(height: 1),
            Text(
              'following',
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF000000),
                  height: 18 / 13,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Roboto'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Theme.of(context).primaryColor,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: _kBorderSidewidth, color: Colors.blue),
        insets: EdgeInsets.symmetric(
          horizontal: userBloc.horizontalInsets(context),
        ),
      ),
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.blue[300].withOpacity(0.75),
      tabs: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Image.asset('assets/icons/home.png', color: Colors.black),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Image.asset('assets/icons/like.png'),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Image.asset('assets/icons/bookmark.png'),
        ),
      ],
    );
  }
}
