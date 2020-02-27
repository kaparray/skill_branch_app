import 'package:flutter/material.dart';
import 'package:skill_branch_flutter/static.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'redux/app/app_state.dart';
import 'ui/screens/home/home.dart';

class App extends StatelessWidget {
  App(this.store);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: StoreProvider(
        store: store,
        child: Home(),
      ),
    );
  }

  
}
