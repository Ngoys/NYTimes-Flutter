// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nytimes/service/api/api_client.dart' as _i5;
import 'package:nytimes/service/api/base_dio.dart' as _i6;
import 'package:nytimes/service/article_store.dart' as _i7;
import 'package:nytimes/service/secure_storage_store.dart' as _i8;
import 'package:nytimes/service/user_store.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final secureStorageStore = _$SecureStorageStore();
    gh.lazySingleton<_i3.FlutterSecureStorage>(() => secureStorageStore.init());
    gh.lazySingleton<_i4.UserStore>(
        () => _i4.UserStore(secureStorage: gh<_i3.FlutterSecureStorage>()));
    gh.lazySingleton<_i5.APIClient>(() => _i5.APIClient(
          gh<_i6.AppDio>(),
          gh<_i4.UserStore>(),
        ));
    gh.lazySingleton<_i7.ArticleStore>(
        () => _i7.ArticleStore(apiClient: gh<_i5.APIClient>()));
    return this;
  }
}

class _$SecureStorageStore extends _i8.SecureStorageStore {}
