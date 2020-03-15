import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:skill_branch_flutter/base/inhereted_widget.dart';
import 'package:redux/redux.dart';
import 'package:skill_branch_flutter/main.dart';
import 'package:skill_branch_flutter/redux/app/app_state.dart';
import 'package:skill_branch_flutter/redux/bottom_navigation_bar/tab_bar_action.dart';
import 'package:skill_branch_flutter/redux/connectivity/connectivity_actions.dart';
import 'package:skill_branch_flutter/redux/store.dart';
import 'package:skill_branch_flutter/redux/user/user_actions.dart';
import 'package:skill_branch_flutter/res/res.dart';
import 'package:skill_branch_flutter/ui/lib/tab_bar/bottom_navigation_bar.dart';
import 'package:skill_branch_flutter/ui/screens/feed/feed.dart';
import 'package:skill_branch_flutter/ui/screens/search/search.dart';
import 'package:skill_branch_flutter/ui/screens/user/user.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  static ScrollController feedScrollController = ScrollController();
  final PageStorageBucket bucket = PageStorageBucket();

  List<Widget> pages = [
    Feed(key: PageStorageKey('FeedPage')),
    SearchView(key: PageStorageKey('SearchView')),
    UserProfile(isMyProfile: true, key: PageStorageKey('UserProfile')),
  ];

  final List<BottomNavyBarItem> _tabs = [
    BottomNavyBarItem(
      asset: 'assets/icons/feed.png',
      title: Text('Feed'),
      activeColor: AppColors.dodgerBlue,
      inactiveColor: AppColors.manatee,
    ),
    BottomNavyBarItem(
      asset: 'assets/icons/search.png',
      title: Text('Search'),
      activeColor: AppColors.dodgerBlue,
      inactiveColor: AppColors.manatee,
    ),
    BottomNavyBarItem(
      asset: 'assets/icons/user.png',
      title: Text('User'),
      activeColor: AppColors.dodgerBlue,
      inactiveColor: AppColors.manatee,
    ),
  ];

  @override
  void initState() {
    super.initState();
    connectivitySub = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      store.dispatch(ConnectivityAction(result));
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentTabIndex = store.state.tabState.currentTab;

    return Globals(
      child: Scaffold(
        bottomNavigationBar: BottomNavyBar(
          showElevation: true,
          itemCornerRadius: 8,
          curve: Curves.ease,
          items: _tabs,
          onItemSelected: (index) {
            if (!store.state.userState.isAuth && index == 2) {
              store.dispatch(AuthUserAction());
            } else if (index == currentTabIndex && index == 0) {
              feedScrollController.jumpTo(0);
            } else {
              setState(() {
                store.dispatch(UpdateTabAction(index));
              });
            }
          },
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: PageStorage(
                child: pages[currentTabIndex],
                bucket: bucket,
              ),
            ),
            Positioned(left: 0, right: 0, top: 0, bottom: 0, child: buildNoConnection()),
          ],
        ),
      ),
      feedScrollController: feedScrollController,
    );
  }

  Widget buildNoConnection() {
    double height = 0;

    return StoreBuilder(
      builder: (BuildContext context, Store<AppState> vm) {
        if (store.state.connectivityState.connectivityResult == ConnectivityResult.none) {
          height = 142;
        } else {
          height = 0;
        }
        return AnimatedSize(
          duration: Duration(seconds: 1),
          vsync: this,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.all(16),
                height: height,
                color: AppColors.alto.withOpacity(0.9),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/image/connection.png',
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'There was an error loading the feed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.manatee,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        height: 22 / 17,
                        letterSpacing: -0.41,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    connectivitySub.cancel();
    super.dispose();
  }
}
