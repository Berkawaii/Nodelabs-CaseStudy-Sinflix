import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/login_response.dart';
import '../models/register_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/user/login')
  Future<LoginResponse> login(@Body() Map<String, dynamic> request);

  @POST('/user/register')
  Future<RegisterResponse> register(@Body() Map<String, dynamic> request);
}
