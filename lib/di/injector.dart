import 'package:kiwi/kiwi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/globals.dart';
import 'package:skill_branch_flutter/network/api/apis.dart';
import 'package:skill_branch_flutter/network/api/search_api.dart';
import 'package:skill_branch_flutter/redux/store.dart';

class Injector {
  Future<void> configureApp() async {
    final Container container = Container();

    container.registerSingleton((c) => BaseConfig());

    // API
    container.registerSingleton((c) => AuthApi());
    container.registerSingleton((c) => PhotosApi());
    container.registerSingleton((c) => UserApi());
    container.registerSingleton((c) => CollectionApi());
    container.registerSingleton((c) => SearchApi());

    // BLoC
    container.registerFactory((c) => CollectionBloc());
    container.registerFactory((c) => UserBloc());
    container.registerFactory((c) => FeedBloc());
    container.registerFactory((c) => ImageBloc());
    container.registerFactory((c) => SearchBloc());

    // Local Data
    final sharedPreferences = await SharedPreferences.getInstance();
    container.registerSingleton((c) => sharedPreferences);

    container<FeedBloc>().init();
    initStore();
  }
}
