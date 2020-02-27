import 'dart:convert';

import 'collections.dart';
import 'feed_network_model.dart';

List<FeedNetworkModel> feedNetworkModelFromJson(String str) =>
    List<FeedNetworkModel>.from(
        json.decode(str).map((x) => FeedNetworkModel.fromJson(x)));

String feedNetworkModelToJson(List<FeedNetworkModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Collections> collectionsFromJson(String str) => List<Collections>.from(
    json.decode(str).map((x) => Collections.fromJson(x)));

String collectionsToJson(List<Collections> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
