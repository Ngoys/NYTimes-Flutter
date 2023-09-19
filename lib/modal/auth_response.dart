class AuthResponse {
  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.sessionState,
    required this.expiresIn,
    required this.refreshExpiresIn,
  });

  AuthResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    refreshExpiresIn = json['refresh_expires_in'];
    sessionState = json['session_state'];
  }

  late final String accessToken;
  late final String refreshToken;
  late final String tokenType;
  late final String sessionState;
  late final int expiresIn;
  late final int refreshExpiresIn;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    data['refresh_expires_in'] = refreshExpiresIn;
    data['session_state'] = sessionState;
    return data;
  }
}
