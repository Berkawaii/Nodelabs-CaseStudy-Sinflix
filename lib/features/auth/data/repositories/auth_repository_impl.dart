import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_error_handler.dart';
import '../../../../core/storage/token_storage.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_api.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._authApi, this._tokenStorage);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final request = {'email': email, 'password': password};

      final response = await _authApi.login(request);

      if (response.response.code == 200) {
        final user = User(
          id: response.data.id,
          name: response.data.name,
          email: response.data.email,
          photoUrl: response.data.photoUrl,
          token: response.data.token,
        );

        // Token'ı güvenli şekilde sakla
        await _tokenStorage.saveToken(response.data.token);

        // User bilgilerini de sakla
        final userJson = jsonEncode({
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'photoUrl': user.photoUrl,
        });
        await _tokenStorage.saveUserData(userJson);

        return Right(user);
      } else {
        return Left(ServerFailure(response.response.message));
      }
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleError(e));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> register(String name, String email, String password) async {
    try {
      final request = {'name': name, 'email': email, 'password': password};

      final response = await _authApi.register(request);

      if (response.response.code == 200) {
        final user = User(
          id: response.data.id,
          name: response.data.name,
          email: response.data.email,
          photoUrl: response.data.photoUrl,
          token: response.data.token,
        );

        // Token'ı güvenli şekilde sakla
        await _tokenStorage.saveToken(response.data.token);

        // User bilgilerini de sakla
        final userJson = jsonEncode({
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'photoUrl': user.photoUrl,
        });
        await _tokenStorage.saveUserData(userJson);

        return Right(user);
      } else {
        return Left(ServerFailure(response.response.message));
      }
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleError(e));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _tokenStorage.clearAll();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to logout: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final token = await _tokenStorage.getToken();
      final userDataJson = await _tokenStorage.getUserData();

      if (token == null || userDataJson == null) {
        return const Right(null);
      }

      final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
      final user = User(
        id: userData['id'],
        name: userData['name'],
        email: userData['email'],
        photoUrl: userData['photoUrl'],
        token: token,
      );

      return Right(user);
    } catch (e) {
      return Left(CacheFailure('Failed to get current user: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final hasToken = await _tokenStorage.hasToken();
      return Right(hasToken);
    } catch (e) {
      return Left(CacheFailure('Failed to check login status: ${e.toString()}'));
    }
  }
}
