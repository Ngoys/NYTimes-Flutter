import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nytimes/modal/auth_response.dart';

const String _authKey = 'nytimes_auth_key';

@lazySingleton
class UserStore {
  UserStore({required this.secureStorage});

  final FlutterSecureStorage secureStorage;
  final StreamController<bool> _hasActiveUser =
      StreamController<bool>.broadcast();

  Future<void> saveAuthData(AuthResponse authResponseModel) async =>
      secureStorage
          .write(
            key: _authKey,
            value: json.encode(authResponseModel.toJson()),
          )
          .then((_) => _hasActiveUser.add(true));

  Future<AuthResponse?> getAuthData() async {
    final String? serializedAuth = await secureStorage.read(key: _authKey);
    if (serializedAuth != null) {
      return AuthResponse.fromJson(json.decode(serializedAuth));
    } else {
      return null;
    }
  }

  Future<void> deleteAuthData({bool? deleteAuthOnly}) async {
    await secureStorage.delete(key: _authKey);
    if ((deleteAuthOnly ?? false) == false) _hasActiveUser.add(false);
  }

  Future<void> checkSessionExistenceOrLogout() =>
      getAuthData().then((AuthResponse? auth) {
        if (auth == null) _hasActiveUser.add(false);
      });

  Stream<bool> hasActiveUser() => _hasActiveUser.stream;
}
