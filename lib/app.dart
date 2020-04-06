import 'package:flutter/material.dart';

import 'package:skill_branch_flutter/globals.dart';
import 'package:skill_branch_flutter/ui/screens/home/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: Home(),
    );
  }
}
