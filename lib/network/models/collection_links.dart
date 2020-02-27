class CollectionLinks {
  String self;
  String html;
  String photos;
  String related;

  CollectionLinks({
    this.self,
    this.html,
    this.photos,
    this.related,
  });

  factory CollectionLinks.fromJson(Map<String, dynamic> json) =>
      CollectionLinks(
        self: json["self"],
        html: json["html"],
        photos: json["photos"],
        related: json["related"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "photos": photos,
        "related": related,
      };
}