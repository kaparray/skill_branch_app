import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:skill_branch_flutter/app.dart';
import 'package:skill_branch_flutter/redux/store.dart';

import 'di/injector.dart';

StreamSubscription connectivitySub;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Injector().configureApp();

  runApp(ReduxProvider(store: store, child: App()));
}
