import 'ancestry_model.dart';
import 'cover_photo.dart';

class Source {
  Ancestry ancestry;
  String title;
  String subtitle;
  String description;
  String metaTitle;
  String metaDescription;
  CoverPhoto coverPhoto;

  Source({
    this.ancestry,
    this.title,
    this.subtitle,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.coverPhoto,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        ancestry: Ancestry.fromJson(json["ancestry"]),
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        coverPhoto: CoverPhoto.fromJson(json["cover_photo"]),
      );

  Map<String, dynamic> toJson() => {
        "ancestry": ancestry.toJson(),
        "title": title,
        "subtitle": subtitle,
        "description": description,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "cover_photo": coverPhoto.toJson(),
      };
}