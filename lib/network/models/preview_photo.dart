import 'urls_photo.dart';

class PreviewPhoto {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  Urls urls;

  PreviewPhoto({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.urls,
  });

  factory PreviewPhoto.fromJson(Map<String, dynamic> json) => PreviewPhoto(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        urls: Urls.fromJson(json["urls"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "urls": urls.toJson(),
      };
}