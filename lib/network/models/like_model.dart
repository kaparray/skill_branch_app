import 'collection_links.dart';
import 'feed_network_model.dart';

class Like {
  FeedNetworkModel photo;
  CollectionLinks links;

  Like({
    this.photo,
    this.links,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        photo: json["photo"],
        links: json["links"],
      );

  Map<String, dynamic> toJson() => {
        "links": links,
        "photo": photo,
      };
}
