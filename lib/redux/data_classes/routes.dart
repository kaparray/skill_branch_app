import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'routes.g.dart';

class Routes extends EnumClass {
  static Serializer<Routes> get serializer => _$routesSerializer;

  const Routes._(String name) : super(name);
  static BuiltSet<Routes> get values => _$routesValues;

  static Routes valueOf(String name) => _$routesValueOf(name);

  static const Routes pop = _$pop;
  static const Routes profile = _$profile;
  static const Routes fullScreen = _$fullScreen;
  static const Routes webView = _$webView;
  static const Routes collections = _$collections;
}
