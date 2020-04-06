import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dialogs.g.dart';

class Dialogs extends EnumClass {
  const Dialogs._(String name) : super(name);

  static Serializer<Dialogs> get serializer => _$dialogsSerializer;
  static BuiltSet<Dialogs> get values => _$dialogsValues;
  static Dialogs valueOf(String name) => _$dialogsValueOf(name);

  static const Dialogs close = _$close;
  static const Dialogs progress = _$progress;
  static const Dialogs error = _$error;
  static const Dialogs done = _$done;
}
