import 'feed_network_model.dart';

class Search {
  Search({
    this.total,
    this.totalPages,
    this.results,
  });

  int total;
  int totalPages;
  List<FeedNetworkModel> results;

  factory Search.fromJson(Map<String, dynamic> json) {
    List<FeedNetworkModel> listResults = [];

    (json['results'] as List)?.forEach((data) {
      listResults.add(FeedNetworkModel.fromJson(data));
    });

    return Search(
      total: json['total'],
      totalPages: json['total_pages'],
      results: listResults,
    );
  }
}
