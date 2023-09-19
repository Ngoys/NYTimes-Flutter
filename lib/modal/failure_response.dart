class FailureResponse {
  FailureResponse({
    required this.code,
    required this.error,
    this.errorDescription,
  });

  final String code;
  final String error;
  final String? errorDescription;
}
