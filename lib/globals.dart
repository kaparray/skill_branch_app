import 'package:flutter/widgets.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

const int kPerPageUserPhotos = 12;

class BaseConfig {
  final baseUrl = 'https://api.unsplash.com';
  final baseAccessKey = 'wbTuFeXl7HBB46OLvYni1lCGcESUeh0_SbpgMIXf2-k';
  final baseSecretKey = 'y5ZY0m4RLJnL9K4mvazGLp5saixXOE8pGAGQH_9N8gU';
}
