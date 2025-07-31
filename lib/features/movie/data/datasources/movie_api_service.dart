import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/api_movie_response.dart';

part 'movie_api_service.g.dart';

@RestApi()
abstract class MovieApiService {
  factory MovieApiService(Dio dio) = _MovieApiService;

  @GET('/movie/list')
  Future<ApiMovieResponse> getMovies({@Query('page') required int page});
}
