import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';
import '../../../movie/domain/entities/movie.dart';
import '../../domain/entities/user_profile.dart';

@injectable
class ProfileApiService {
  final ApiClient _apiClient;

  ProfileApiService(this._apiClient);

  Future<UserProfile> getUserProfile() async {
    try {
      final response = await _apiClient.dio.get('/user/profile');

      if (response.statusCode == 200) {
        final jsonData = response.data;
        if (jsonData['response']['code'] == 200) {
          return UserProfile.fromJson(jsonData['data']);
        } else {
          throw Exception('Failed to get user profile: ${jsonData['response']['message']}');
        }
      } else {
        throw Exception('Failed to get user profile: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<Movie>> getFavoriteMovies() async {
    try {
      final response = await _apiClient.dio.get('/movie/favorites');

      if (response.statusCode == 200) {
        final jsonData = response.data;
        if (jsonData['response']['code'] == 200) {
          final List<dynamic> moviesJson = jsonData['data'];
          return moviesJson.map((movieJson) => Movie.fromJson(movieJson)).toList();
        } else {
          throw Exception('Failed to get favorite movies: ${jsonData['response']['message']}');
        }
      } else {
        throw Exception('Failed to get favorite movies: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
