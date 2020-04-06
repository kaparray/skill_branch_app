import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:skill_branch_flutter/network/models/models.dart';

part 'serializers.g.dart';

@SerializersFor(const [UserNetworkModel])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(
        StandardJsonPlugin(),
      ))
    .build();
