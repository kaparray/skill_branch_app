import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skill_branch_flutter/app.dart';
import 'package:skill_branch_flutter/redux/store.dart';

import 'package:kiwi/kiwi.dart' as kiwi;
import 'di/injector.dart';

StreamSubscription connectivitySub;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await createStore();
  setup();
  var container = kiwi.Container();
  container<FeedService>().initService();

  runApp(App(store));
}
