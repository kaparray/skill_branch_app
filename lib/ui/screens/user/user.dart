import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/redux/store.dart';
import 'package:skill_branch_flutter/ui/screens/user/user_collections.dart';
import 'package:skill_branch_flutter/ui/screens/user/user_photo.dart';

const double _kBorderSidewidth = 3.0;
const double _kUserImageHeight = 92.0;

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

class UserProfileState extends State<UserProfile>
    with SingleTickerProviderStateMixin {
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: _kUserImageHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: CachedNetworkImage(
                        imageUrl: userBloc.largeProfileImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  _buildFollowers(),
                ],
              ),
              const SizedBox(height: 12),
              _buildDescription(),
              Container(
                width: double.infinity,
                child: Text(userBloc.profileBio),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFollowers() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            userBloc.followersCount,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(width: 8),
          Text(
            userBloc.followingCount,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          if (userBloc.location.isNotEmpty) ...[
            Icon(Icons.my_location),
            Text(userBloc.location),
          ],
          const SizedBox(width: 8),
          if (userBloc.portfolioUrl != null)
            GestureDetector(
              onTap: () => userBloc.launchUrl(),
              child: Row(
                children: [
                  Icon(Icons.settings_ethernet),
                  Text(userBloc.portfolioUrl),
                ],
              ),
            ),
        ],
      ),
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
      tabs: List.generate(
        3,
        (int index) => Tab(
          child: Icon(Icons.home),
        ),
      ),
    );
  }
}
