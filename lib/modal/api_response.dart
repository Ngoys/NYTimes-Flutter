class NYTimesAPIResponse<T> {
  NYTimesAPIResponse({
    required this.status,
    required this.copyright,
    required this.response,
  });

  NYTimesAPIResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJson) {
    status = json['status'];
    copyright = json['copyright'];
    response = fromJson(json['response']);
  }

  late final String status;
  late final String copyright;
  late final T response;
}
