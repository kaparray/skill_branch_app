import 'sponsorship.dart';
import 'urls_photo.dart';
import 'user_network_model.dart';
import 'user_network_model_links.dart';

class FeedNetworkModel {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime promotedAt;
  int width;
  int height;
  String color;
  String description;
  String altDescription;
  Urls urls;
  FeedNetworkModelLinks links;
  List<dynamic> categories;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  UserNetworkModel user;
  Sponsorship sponsorship;

  FeedNetworkModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.description,
    this.altDescription,
    this.urls,
    this.links,
    this.categories,
    this.likes,
    this.likedByUser,
    this.currentUserCollections,
    this.user,
    this.sponsorship,
  });

  @override
  String toString() => """FeedNetworkModel:
       id = $id\ncreatedAt = $createdAt
      updatedAt = $updatedAt
      promotedAt = $promotedAt
      width = $width
      height = $height
      color = $color
      description = $description
      altDescription = $altDescription
      urls = $urls
      links = $links
      categories = $categories
      likes = $likes
      likedByUser = $likedByUser
      currentUserCollections = $currentUserCollections
      user = $user
      sponsorship = $sponsorship
      """;

  factory FeedNetworkModel.fromJson(Map<String, dynamic> json) {
    return FeedNetworkModel(
      id: json["id"].toString(),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      promotedAt: json["promoted_at"] == null
          ? null
          : DateTime.parse(json["promoted_at"]),
      width: json["width"] == null ? null : json["width"],
      height: json["height"] == null ? null : json["height"],
      color: json["color"] == null ? null : json["color"],
      description: json["description"] == null ? null : json["description"],
      altDescription:
          json["alt_description"] == null ? null : json["alt_description"],
      urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
      links: json["links"] != null
          ? FeedNetworkModelLinks.fromJson(json["links"])
          : null,
      categories: json["categories"] == null
          ? null
          : List<dynamic>.from(json["categories"].map((x) => x)),
      likes: json["likes"] == null ? null : json["likes"],
      likedByUser: json["liked_by_user"] == null ? null : json["liked_by_user"],
      currentUserCollections: json["current_user_collections"] == null
          ? null
          : List<dynamic>.from(json["current_user_collections"].map((x) => x)),
      user:
          json["user"] == null ? null : UserNetworkModel.fromJson(json["user"]),
      sponsorship: json["sponsorship"] == null
          ? null
          : Sponsorship.fromJson(json["sponsorship"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "promoted_at": promotedAt == null ? null : promotedAt.toIso8601String(),
        "width": width,
        "height": height,
        "color": color,
        "description": description == null ? null : description,
        "alt_description": altDescription == null ? null : altDescription,
        "urls": urls.toJson(),
        "links": links.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "likes": likes,
        "liked_by_user": likedByUser,
        "current_user_collections":
            List<dynamic>.from(currentUserCollections.map((x) => x)),
        "user": user.toString(),
        "sponsorship": sponsorship == null ? null : sponsorship.toJson(),
      };
}
