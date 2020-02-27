import 'collection_links.dart';
import 'cover_photo.dart';
import 'preview_photo.dart';
import 'tag_model.dart';
import 'user_model.dart';

class Collections {
  int id;
  String title;
  dynamic description;
  DateTime publishedAt;
  DateTime updatedAt;
  bool curated;
  bool featured;
  int totalPhotos;
  bool private;
  String shareKey;
  List<Tag> tags;
  CollectionLinks links;
  User user;
  CoverPhoto coverPhoto;
  List<PreviewPhoto> previewPhotos;

  Collections({
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.updatedAt,
    this.curated,
    this.featured,
    this.totalPhotos,
    this.private,
    this.shareKey,
    this.tags,
    this.links,
    this.user,
    this.coverPhoto,
    this.previewPhotos,
  });

  factory Collections.fromJson(Map<String, dynamic> json) {
    print("json[] = ${json["links"]}");
    return Collections(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      publishedAt: DateTime.parse(json["published_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      curated: json["curated"],
      featured: json["featured"],
      totalPhotos: json["total_photos"],
      private: json["private"],
      shareKey: json["share_key"],
      tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      links: json['links'] != null
          ? CollectionLinks.fromJson(json["links"])
          : null,
      user: User.fromJson(json["user"]),
      coverPhoto: CoverPhoto.fromJson(json["cover_photo"]),
      previewPhotos: List<PreviewPhoto>.from(
          json["preview_photos"].map((x) => PreviewPhoto.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "published_at": publishedAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "curated": curated,
        "featured": featured,
        "total_photos": totalPhotos,
        "private": private,
        "share_key": shareKey,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "links": links.toJson(),
        "user": user.toJson(),
        "cover_photo": coverPhoto.toJson(),
        "preview_photos":
            List<dynamic>.from(previewPhotos.map((x) => x.toJson())),
      };
}
