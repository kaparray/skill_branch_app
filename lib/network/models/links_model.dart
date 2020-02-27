class Links {
  String self;
  String html;
  String photos;
  String likes;
  String portfolio;

  Links({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        html: json["html"],
        photos: json["photos"],
        likes: json["likes"],
        portfolio: json["portfolio"],
      );

  Map<String, dynamic> toJson() => {
        "\"self\"": "\"$self\"",
        "\"html\"": "\"$html\"",
        "\"photos\"": "\"$photos\"",
        "\"likes\"": "\"$likes\"",
        "\"portfolio\"": "\"$portfolio\"",
      };
}
