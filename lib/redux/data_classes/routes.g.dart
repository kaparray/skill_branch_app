// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Routes _$pop = const Routes._('pop');
const Routes _$profile = const Routes._('profile');
const Routes _$fullScreen = const Routes._('fullScreen');
const Routes _$webView = const Routes._('webView');
const Routes _$collections = const Routes._('collections');

Routes _$routesValueOf(String name) {
  switch (name) {
    case 'pop':
      return _$pop;
    case 'profile':
      return _$profile;
    case 'fullScreen':
      return _$fullScreen;
    case 'webView':
      return _$webView;
    case 'collections':
      return _$collections;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<Routes> _$routesValues = new BuiltSet<Routes>(const <Routes>[
  _$pop,
  _$profile,
  _$fullScreen,
  _$webView,
  _$collections,
]);

Serializer<Routes> _$routesSerializer = new _$RoutesSerializer();

class _$RoutesSerializer implements PrimitiveSerializer<Routes> {
  @override
  final Iterable<Type> types = const <Type>[Routes];
  @override
  final String wireName = 'Routes';

  @override
  Object serialize(Serializers serializers, Routes object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  Routes deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Routes.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
