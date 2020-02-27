import 'user_network_model.dart';

class Sponsorship {
  List<String> impressionUrls;
  String tagline;
  UserNetworkModel sponsor;

  Sponsorship({
    this.impressionUrls,
    this.tagline,
    this.sponsor,
  });

  factory Sponsorship.fromJson(Map<String, dynamic> json) => Sponsorship(
        impressionUrls:
            List<String>.from(json["impression_urls"].map((x) => x)),
        tagline: json["tagline"],
        sponsor: UserNetworkModel.fromJson(json["sponsor"]),
      );

  Map<String, dynamic> toJson() => {
        "impression_urls": List<dynamic>.from(impressionUrls.map((x) => x)),
        "tagline": tagline,
        "sponsor": sponsor.toJson(),
      };
}