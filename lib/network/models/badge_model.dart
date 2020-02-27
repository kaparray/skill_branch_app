class Badge {
  String title;
  bool primary;
  String slug;
  String link;

  Badge({
    this.title,
    this.primary,
    this.slug,
    this.link,
  });

  factory Badge.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return Badge(
        title: json["title"],
        primary: json["primary"],
        slug: json["slug"] == null ? null : json["slug"],
        link: json["link"],
      );
    }

    return Badge();
  }

  Map<String, dynamic> toJson() => {
        "\"title\"": "\"$title\"",
        "\"primary\"": primary,
        "\"slug\"": "\"$slug\"",
        "\"link\"": "\"$link\"",
      };
}