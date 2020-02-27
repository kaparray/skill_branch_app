class CoverPhotoLinks {
  String self;
  String html;
  String download;
  String downloadLocation;

  CoverPhotoLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  factory CoverPhotoLinks.fromJson(Map<String, dynamic> json) =>
      CoverPhotoLinks(
        self: json["self"],
        html: json["html"],
        download: json["download"],
        downloadLocation: json["download_location"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "download": download,
        "download_location": downloadLocation,
      };
}
