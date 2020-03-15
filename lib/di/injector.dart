import 'package:connectivity/connectivity.dart';
import 'package:kiwi/kiwi.dart';
import 'package:skill_branch_flutter/base/base_bloc.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';
import 'package:skill_branch_flutter/network/api/apis.dart';
import 'package:skill_branch_flutter/redux/store.dart';
import 'package:skill_branch_flutter/redux/user/user_actions.dart';


class Injector {
  void configure() {
    final Container container = Container();
    container.registerSingleton((c) => FeedService());
    container.registerSingleton((c) => BaseConfig());
  }
}

class FeedService {
  FeedBloc feedBloc = FeedBloc();
  final _api = PhotosApi();


  void initService() {
    feedBloc.init();
  }

  void killServicce() {
    feedBloc.dispose();
  }

  Future<bool> likePhoto(String id, bool isLiked) async {

    if (store.state.userState.isAuth) {
      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none)
        throw StreamError.connectionError;
      else
        return await _api.likeUnlikePhoto(id, isLiked);
      
    } else {
      store.dispatch(AuthUserAction());
    }

    return isLiked;
  }

}


class BaseConfig {
  String baseUrl = 'https://api.unsplash.com';
  String baseAccessKey = 'wbTuFeXl7HBB46OLvYni1lCGcESUeh0_SbpgMIXf2-k'; // 'm5dUsve-Aipa3w4RPn2YM7CokabnGNhCqXYFD2pIiPE';
  String baseSecretKey = 'y5ZY0m4RLJnL9K4mvazGLp5saixXOE8pGAGQH_9N8gU'; //'R1nDZUusBwvEgyEww_6HF2tR5uSePgTYTLYVf5JMuJw';
}

void setup() {
  final injector = Injector();
  injector.configure();
}
