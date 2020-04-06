import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bottom_sheets.g.dart';

class BottomSheets extends EnumClass {
  const BottomSheets._(String name) : super(name);

  static Serializer<BottomSheets> get serializer => _$bottomSheetsSerializer;
  static BuiltSet<BottomSheets> get values => _$bottomSheetsValues;
  static BottomSheets valueOf(String name) => _$bottomSheetsValueOf(name);

  static const BottomSheets close = _$close;
  static const BottomSheets auth = _$auth;
}
