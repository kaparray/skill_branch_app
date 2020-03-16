import 'package:kiwi/kiwi.dart';
import 'package:skill_branch_flutter/blocs/blocs.dart';

class Injector {
  void configure() {
    final Container container = Container();
    container.registerSingleton((c) => FeedService());
    container.registerSingleton((c) => BaseConfig());
  }
}

class FeedService {
  FeedBloc feedBloc = FeedBloc();

  void initService() {
    feedBloc.init();
  }

  void killServicce() {
    feedBloc.dispose();
  }
}

class BaseConfig {
  String baseUrl = 'https://api.unsplash.com';
  String baseAccessKey =
      'wbTuFeXl7HBB46OLvYni1lCGcESUeh0_SbpgMIXf2-k'; // 'm5dUsve-Aipa3w4RPn2YM7CokabnGNhCqXYFD2pIiPE';
  String baseSecretKey = 'y5ZY0m4RLJnL9K4mvazGLp5saixXOE8pGAGQH_9N8gU'; //'R1nDZUusBwvEgyEww_6HF2tR5uSePgTYTLYVf5JMuJw';
}

void setup() {
  final injector = Injector();
  injector.configure();
}
