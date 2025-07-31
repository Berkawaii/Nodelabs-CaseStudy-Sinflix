// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/datasources/auth_api.dart' as _i367;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i17;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../network/api_client.dart' as _i557;
import '../storage/token_storage.dart' as _i973;
import 'network_module.dart' as _i567;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.singleton<_i557.ApiClient>(() => _i557.ApiClient());
    gh.singleton<_i973.TokenStorage>(() => _i973.TokenStorage());
    gh.singleton<_i367.AuthApi>(
      () => networkModule.authApi(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i367.AuthApi>(),
        gh<_i973.TokenStorage>(),
      ),
    );
    gh.factory<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i48.LogoutUseCase>(
      () => _i48.LogoutUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i17.GetCurrentUserUseCase>(
      () => _i17.GetCurrentUserUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i941.RegisterUseCase>(
      () => _i941.RegisterUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i797.AuthBloc>(
      () => _i797.AuthBloc(
        gh<_i188.LoginUseCase>(),
        gh<_i941.RegisterUseCase>(),
        gh<_i48.LogoutUseCase>(),
        gh<_i17.GetCurrentUserUseCase>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i567.NetworkModule {}
