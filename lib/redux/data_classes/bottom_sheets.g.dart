// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_sheets.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BottomSheets _$close = const BottomSheets._('close');
const BottomSheets _$auth = const BottomSheets._('auth');

BottomSheets _$bottomSheetsValueOf(String name) {
  switch (name) {
    case 'close':
      return _$close;
    case 'auth':
      return _$auth;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<BottomSheets> _$bottomSheetsValues =
    new BuiltSet<BottomSheets>(const <BottomSheets>[
  _$close,
  _$auth,
]);

Serializer<BottomSheets> _$bottomSheetsSerializer =
    new _$BottomSheetsSerializer();

class _$BottomSheetsSerializer implements PrimitiveSerializer<BottomSheets> {
  @override
  final Iterable<Type> types = const <Type>[BottomSheets];
  @override
  final String wireName = 'BottomSheets';

  @override
  Object serialize(Serializers serializers, BottomSheets object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  BottomSheets deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BottomSheets.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
