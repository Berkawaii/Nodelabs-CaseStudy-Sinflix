import 'package:injectable/injectable.dart';

import '../../features/auth/data/datasources/auth_api.dart';
import '../../features/movie/data/datasources/movie_api_service.dart';
import '../network/api_client.dart';

@module
abstract class NetworkModule {
  @singleton
  AuthApi authApi(ApiClient apiClient) => AuthApi(apiClient.dio);

  @singleton
  MovieApiService movieApiService(ApiClient apiClient) => MovieApiService(apiClient.dio);
}
