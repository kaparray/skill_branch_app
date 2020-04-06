// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialogs.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Dialogs _$close = const Dialogs._('close');
const Dialogs _$progress = const Dialogs._('progress');
const Dialogs _$error = const Dialogs._('error');
const Dialogs _$done = const Dialogs._('done');

Dialogs _$dialogsValueOf(String name) {
  switch (name) {
    case 'close':
      return _$close;
    case 'progress':
      return _$progress;
    case 'error':
      return _$error;
    case 'done':
      return _$done;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<Dialogs> _$dialogsValues = new BuiltSet<Dialogs>(const <Dialogs>[
  _$close,
  _$progress,
  _$error,
  _$done,
]);

Serializer<Dialogs> _$dialogsSerializer = new _$DialogsSerializer();

class _$DialogsSerializer implements PrimitiveSerializer<Dialogs> {
  @override
  final Iterable<Type> types = const <Type>[Dialogs];
  @override
  final String wireName = 'Dialogs';

  @override
  Object serialize(Serializers serializers, Dialogs object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  Dialogs deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Dialogs.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
