class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        raw: json.containsKey('raw') ? json["raw"] : null,
        full: json.containsKey('full') ? json["full"] : null,
        regular: json.containsKey('regular') ? json["regular"] : null,
        small: json.containsKey('small') ? json["small"] : null,
        thumb: json.containsKey('thumb') ? json["thumb"] : null,
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
        "full": full,
        "regular": regular,
        "small": small,
        "thumb": thumb,
      };
}
