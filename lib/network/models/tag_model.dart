import 'source_model.dart';

class Tag {
  Type type;
  String title;
  Source source;

  Tag({
    this.type,
    this.title,
    this.source,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        type: typeValues.map[json["type"]],
        title: json["title"],
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "title": title,
        "source": source == null ? null : source.toJson(),
      };
}

enum Type { LANDING_PAGE, SEARCH }

final typeValues =
    EnumValues({"landing_page": Type.LANDING_PAGE, "search": Type.SEARCH});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
