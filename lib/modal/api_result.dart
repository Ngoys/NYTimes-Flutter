class NYTimesAPIResult<T> {
  NYTimesAPIResult({
    required this.status,
    required this.copyright,
    required this.numberOfResults,
    required this.results,
  });

  NYTimesAPIResult.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJson) {
    status = json['status'];
    copyright = json['copyright'];
    numberOfResults = json['num_results'];
    results = fromJson(json['results']);
  }

  late final String status;
  late final String copyright;
  late final int numberOfResults;
  late final T results;
}
