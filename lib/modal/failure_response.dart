class FailureResponse {
  FailureResponse({
    required this.code,
    required this.error,
    this.errorDescription,
  });

  final int? code;
  final String error;
  final String? errorDescription;
}
