class Category {
  String slug;
  String prettySlug;

  Category({
    this.slug,
    this.prettySlug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        slug: json["slug"],
        prettySlug: json["pretty_slug"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "pretty_slug": prettySlug,
      };
}