import 'category.dart';

class Ancestry {
  Category type;
  Category category;
  Category subcategory;

  Ancestry({
    this.type,
    this.category,
    this.subcategory,
  });

  factory Ancestry.fromJson(Map<String, dynamic> json) => Ancestry(
        type: Category.fromJson(json["type"]),
        category: Category.fromJson(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : Category.fromJson(json["subcategory"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type.toJson(),
        "category": category.toJson(),
        "subcategory": subcategory == null ? null : subcategory.toJson(),
      };
}