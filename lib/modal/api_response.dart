class APIResponse<T> {
  APIResponse({
    required this.status,
    required this.copyright,
    required this.response,
  });

  APIResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    copyright = json['copyright'];
    response = json['published_date'] as T;
  }

  late final String status;
  late final String copyright;
  late final T response;
}
