class FeedNetworkModelLinks {
  String self;
  String html;
  String download;
  String downloadLocation;

  FeedNetworkModelLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  factory FeedNetworkModelLinks.fromJson(Map<String, dynamic> json) {
    return FeedNetworkModelLinks(
      self: json["self"],
      html: json["html"],
      download: json["download"],
      downloadLocation: json["download_location"],
    );
  }

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "download": download,
        "download_location": downloadLocation,
      };
}