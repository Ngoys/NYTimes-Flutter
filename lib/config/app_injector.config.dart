// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nytimes/service/geolocation_store.dart' as _i4;
import 'package:nytimes/service/remote/api/api_service.dart' as _i3;
import 'package:nytimes/service/endpoint_provider.dart' as _i7;
import 'package:nytimes/service/user_store.dart' as _i5;

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
    final apiService = _$ApiService();
    gh.singleton<_i3.BaseDio>(apiService.init());
    gh.lazySingleton<_i4.GeoLocationStore>(() => _i4.GeoLocationStore());
    gh.lazySingleton<_i5.UserStore>(
        () => _i5.UserStore(secureStorage: gh<_i6.FlutterSecureStorage>()));
    gh.singleton<_i7.BaseStore>(_i7.BaseStore(
      gh<_i3.BaseDio>(),
      gh<_i5.UserStore>(),
    ));
    return this;
  }
}

class _$ApiService extends _i3.ApiService {}
