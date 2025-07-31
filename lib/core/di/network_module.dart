import 'package:injectable/injectable.dart';

import '../network/api_client.dart';
import '../../features/auth/data/datasources/auth_api.dart';

@module
abstract class NetworkModule {
  @singleton
  AuthApi authApi(ApiClient apiClient) => AuthApi(apiClient.dio);
}
