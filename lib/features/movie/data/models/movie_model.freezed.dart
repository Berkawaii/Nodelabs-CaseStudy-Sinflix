// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return _MovieModel.fromJson(json);
}

/// @nodoc
mixin _$MovieModel {
  @JsonKey(name: '_id')
  String get mongoId => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'Title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'Year')
  String get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'Rated')
  String get rated => throw _privateConstructorUsedError;
  @JsonKey(name: 'Released')
  String get released => throw _privateConstructorUsedError;
  @JsonKey(name: 'Runtime')
  String get runtime => throw _privateConstructorUsedError;
  @JsonKey(name: 'Genre')
  String get genre => throw _privateConstructorUsedError;
  @JsonKey(name: 'Director')
  String get director => throw _privateConstructorUsedError;
  @JsonKey(name: 'Writer')
  String get writer => throw _privateConstructorUsedError;
  @JsonKey(name: 'Actors')
  String get actors => throw _privateConstructorUsedError;
  @JsonKey(name: 'Plot')
  String get plot => throw _privateConstructorUsedError;
  @JsonKey(name: 'Language')
  String get language => throw _privateConstructorUsedError;
  @JsonKey(name: 'Country')
  String get country => throw _privateConstructorUsedError;
  @JsonKey(name: 'Awards')
  String get awards => throw _privateConstructorUsedError;
  @JsonKey(name: 'Poster')
  String get poster => throw _privateConstructorUsedError;
  @JsonKey(name: 'Metascore')
  String get metascore => throw _privateConstructorUsedError;
  @JsonKey(name: 'imdbRating')
  String get imdbRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'imdbVotes')
  String get imdbVotes => throw _privateConstructorUsedError;
  @JsonKey(name: 'imdbID')
  String get imdbID => throw _privateConstructorUsedError;
  @JsonKey(name: 'Type')
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'Response')
  String get response => throw _privateConstructorUsedError;
  @JsonKey(name: 'Images')
  List<String> get images => throw _privateConstructorUsedError;
  @JsonKey(name: 'ComingSoon')
  bool get comingSoon => throw _privateConstructorUsedError;
  @JsonKey(name: 'isFavorite')
  bool get isFavorite => throw _privateConstructorUsedError;

  /// Serializes this MovieModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MovieModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieModelCopyWith<MovieModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieModelCopyWith<$Res> {
  factory $MovieModelCopyWith(
    MovieModel value,
    $Res Function(MovieModel) then,
  ) = _$MovieModelCopyWithImpl<$Res, MovieModel>;
  @useResult
  $Res call({
    @JsonKey(name: '_id') String mongoId,
    String id,
    @JsonKey(name: 'Title') String title,
    @JsonKey(name: 'Year') String year,
    @JsonKey(name: 'Rated') String rated,
    @JsonKey(name: 'Released') String released,
    @JsonKey(name: 'Runtime') String runtime,
    @JsonKey(name: 'Genre') String genre,
    @JsonKey(name: 'Director') String director,
    @JsonKey(name: 'Writer') String writer,
    @JsonKey(name: 'Actors') String actors,
    @JsonKey(name: 'Plot') String plot,
    @JsonKey(name: 'Language') String language,
    @JsonKey(name: 'Country') String country,
    @JsonKey(name: 'Awards') String awards,
    @JsonKey(name: 'Poster') String poster,
    @JsonKey(name: 'Metascore') String metascore,
    @JsonKey(name: 'imdbRating') String imdbRating,
    @JsonKey(name: 'imdbVotes') String imdbVotes,
    @JsonKey(name: 'imdbID') String imdbID,
    @JsonKey(name: 'Type') String type,
    @JsonKey(name: 'Response') String response,
    @JsonKey(name: 'Images') List<String> images,
    @JsonKey(name: 'ComingSoon') bool comingSoon,
    @JsonKey(name: 'isFavorite') bool isFavorite,
  });
}

/// @nodoc
class _$MovieModelCopyWithImpl<$Res, $Val extends MovieModel>
    implements $MovieModelCopyWith<$Res> {
  _$MovieModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mongoId = null,
    Object? id = null,
    Object? title = null,
    Object? year = null,
    Object? rated = null,
    Object? released = null,
    Object? runtime = null,
    Object? genre = null,
    Object? director = null,
    Object? writer = null,
    Object? actors = null,
    Object? plot = null,
    Object? language = null,
    Object? country = null,
    Object? awards = null,
    Object? poster = null,
    Object? metascore = null,
    Object? imdbRating = null,
    Object? imdbVotes = null,
    Object? imdbID = null,
    Object? type = null,
    Object? response = null,
    Object? images = null,
    Object? comingSoon = null,
    Object? isFavorite = null,
  }) {
    return _then(
      _value.copyWith(
            mongoId: null == mongoId
                ? _value.mongoId
                : mongoId // ignore: cast_nullable_to_non_nullable
                      as String,
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as String,
            rated: null == rated
                ? _value.rated
                : rated // ignore: cast_nullable_to_non_nullable
                      as String,
            released: null == released
                ? _value.released
                : released // ignore: cast_nullable_to_non_nullable
                      as String,
            runtime: null == runtime
                ? _value.runtime
                : runtime // ignore: cast_nullable_to_non_nullable
                      as String,
            genre: null == genre
                ? _value.genre
                : genre // ignore: cast_nullable_to_non_nullable
                      as String,
            director: null == director
                ? _value.director
                : director // ignore: cast_nullable_to_non_nullable
                      as String,
            writer: null == writer
                ? _value.writer
                : writer // ignore: cast_nullable_to_non_nullable
                      as String,
            actors: null == actors
                ? _value.actors
                : actors // ignore: cast_nullable_to_non_nullable
                      as String,
            plot: null == plot
                ? _value.plot
                : plot // ignore: cast_nullable_to_non_nullable
                      as String,
            language: null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String,
            country: null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String,
            awards: null == awards
                ? _value.awards
                : awards // ignore: cast_nullable_to_non_nullable
                      as String,
            poster: null == poster
                ? _value.poster
                : poster // ignore: cast_nullable_to_non_nullable
                      as String,
            metascore: null == metascore
                ? _value.metascore
                : metascore // ignore: cast_nullable_to_non_nullable
                      as String,
            imdbRating: null == imdbRating
                ? _value.imdbRating
                : imdbRating // ignore: cast_nullable_to_non_nullable
                      as String,
            imdbVotes: null == imdbVotes
                ? _value.imdbVotes
                : imdbVotes // ignore: cast_nullable_to_non_nullable
                      as String,
            imdbID: null == imdbID
                ? _value.imdbID
                : imdbID // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            response: null == response
                ? _value.response
                : response // ignore: cast_nullable_to_non_nullable
                      as String,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            comingSoon: null == comingSoon
                ? _value.comingSoon
                : comingSoon // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFavorite: null == isFavorite
                ? _value.isFavorite
                : isFavorite // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MovieModelImplCopyWith<$Res>
    implements $MovieModelCopyWith<$Res> {
  factory _$$MovieModelImplCopyWith(
    _$MovieModelImpl value,
    $Res Function(_$MovieModelImpl) then,
  ) = __$$MovieModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: '_id') String mongoId,
    String id,
    @JsonKey(name: 'Title') String title,
    @JsonKey(name: 'Year') String year,
    @JsonKey(name: 'Rated') String rated,
    @JsonKey(name: 'Released') String released,
    @JsonKey(name: 'Runtime') String runtime,
    @JsonKey(name: 'Genre') String genre,
    @JsonKey(name: 'Director') String director,
    @JsonKey(name: 'Writer') String writer,
    @JsonKey(name: 'Actors') String actors,
    @JsonKey(name: 'Plot') String plot,
    @JsonKey(name: 'Language') String language,
    @JsonKey(name: 'Country') String country,
    @JsonKey(name: 'Awards') String awards,
    @JsonKey(name: 'Poster') String poster,
    @JsonKey(name: 'Metascore') String metascore,
    @JsonKey(name: 'imdbRating') String imdbRating,
    @JsonKey(name: 'imdbVotes') String imdbVotes,
    @JsonKey(name: 'imdbID') String imdbID,
    @JsonKey(name: 'Type') String type,
    @JsonKey(name: 'Response') String response,
    @JsonKey(name: 'Images') List<String> images,
    @JsonKey(name: 'ComingSoon') bool comingSoon,
    @JsonKey(name: 'isFavorite') bool isFavorite,
  });
}

/// @nodoc
class __$$MovieModelImplCopyWithImpl<$Res>
    extends _$MovieModelCopyWithImpl<$Res, _$MovieModelImpl>
    implements _$$MovieModelImplCopyWith<$Res> {
  __$$MovieModelImplCopyWithImpl(
    _$MovieModelImpl _value,
    $Res Function(_$MovieModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MovieModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mongoId = null,
    Object? id = null,
    Object? title = null,
    Object? year = null,
    Object? rated = null,
    Object? released = null,
    Object? runtime = null,
    Object? genre = null,
    Object? director = null,
    Object? writer = null,
    Object? actors = null,
    Object? plot = null,
    Object? language = null,
    Object? country = null,
    Object? awards = null,
    Object? poster = null,
    Object? metascore = null,
    Object? imdbRating = null,
    Object? imdbVotes = null,
    Object? imdbID = null,
    Object? type = null,
    Object? response = null,
    Object? images = null,
    Object? comingSoon = null,
    Object? isFavorite = null,
  }) {
    return _then(
      _$MovieModelImpl(
        mongoId: null == mongoId
            ? _value.mongoId
            : mongoId // ignore: cast_nullable_to_non_nullable
                  as String,
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as String,
        rated: null == rated
            ? _value.rated
            : rated // ignore: cast_nullable_to_non_nullable
                  as String,
        released: null == released
            ? _value.released
            : released // ignore: cast_nullable_to_non_nullable
                  as String,
        runtime: null == runtime
            ? _value.runtime
            : runtime // ignore: cast_nullable_to_non_nullable
                  as String,
        genre: null == genre
            ? _value.genre
            : genre // ignore: cast_nullable_to_non_nullable
                  as String,
        director: null == director
            ? _value.director
            : director // ignore: cast_nullable_to_non_nullable
                  as String,
        writer: null == writer
            ? _value.writer
            : writer // ignore: cast_nullable_to_non_nullable
                  as String,
        actors: null == actors
            ? _value.actors
            : actors // ignore: cast_nullable_to_non_nullable
                  as String,
        plot: null == plot
            ? _value.plot
            : plot // ignore: cast_nullable_to_non_nullable
                  as String,
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
        country: null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String,
        awards: null == awards
            ? _value.awards
            : awards // ignore: cast_nullable_to_non_nullable
                  as String,
        poster: null == poster
            ? _value.poster
            : poster // ignore: cast_nullable_to_non_nullable
                  as String,
        metascore: null == metascore
            ? _value.metascore
            : metascore // ignore: cast_nullable_to_non_nullable
                  as String,
        imdbRating: null == imdbRating
            ? _value.imdbRating
            : imdbRating // ignore: cast_nullable_to_non_nullable
                  as String,
        imdbVotes: null == imdbVotes
            ? _value.imdbVotes
            : imdbVotes // ignore: cast_nullable_to_non_nullable
                  as String,
        imdbID: null == imdbID
            ? _value.imdbID
            : imdbID // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        response: null == response
            ? _value.response
            : response // ignore: cast_nullable_to_non_nullable
                  as String,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        comingSoon: null == comingSoon
            ? _value.comingSoon
            : comingSoon // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFavorite: null == isFavorite
            ? _value.isFavorite
            : isFavorite // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieModelImpl implements _MovieModel {
  const _$MovieModelImpl({
    @JsonKey(name: '_id') required this.mongoId,
    required this.id,
    @JsonKey(name: 'Title') required this.title,
    @JsonKey(name: 'Year') required this.year,
    @JsonKey(name: 'Rated') required this.rated,
    @JsonKey(name: 'Released') required this.released,
    @JsonKey(name: 'Runtime') required this.runtime,
    @JsonKey(name: 'Genre') required this.genre,
    @JsonKey(name: 'Director') required this.director,
    @JsonKey(name: 'Writer') required this.writer,
    @JsonKey(name: 'Actors') required this.actors,
    @JsonKey(name: 'Plot') required this.plot,
    @JsonKey(name: 'Language') required this.language,
    @JsonKey(name: 'Country') required this.country,
    @JsonKey(name: 'Awards') required this.awards,
    @JsonKey(name: 'Poster') required this.poster,
    @JsonKey(name: 'Metascore') required this.metascore,
    @JsonKey(name: 'imdbRating') required this.imdbRating,
    @JsonKey(name: 'imdbVotes') required this.imdbVotes,
    @JsonKey(name: 'imdbID') required this.imdbID,
    @JsonKey(name: 'Type') required this.type,
    @JsonKey(name: 'Response') required this.response,
    @JsonKey(name: 'Images') required final List<String> images,
    @JsonKey(name: 'ComingSoon') required this.comingSoon,
    @JsonKey(name: 'isFavorite') required this.isFavorite,
  }) : _images = images;

  factory _$MovieModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String mongoId;
  @override
  final String id;
  @override
  @JsonKey(name: 'Title')
  final String title;
  @override
  @JsonKey(name: 'Year')
  final String year;
  @override
  @JsonKey(name: 'Rated')
  final String rated;
  @override
  @JsonKey(name: 'Released')
  final String released;
  @override
  @JsonKey(name: 'Runtime')
  final String runtime;
  @override
  @JsonKey(name: 'Genre')
  final String genre;
  @override
  @JsonKey(name: 'Director')
  final String director;
  @override
  @JsonKey(name: 'Writer')
  final String writer;
  @override
  @JsonKey(name: 'Actors')
  final String actors;
  @override
  @JsonKey(name: 'Plot')
  final String plot;
  @override
  @JsonKey(name: 'Language')
  final String language;
  @override
  @JsonKey(name: 'Country')
  final String country;
  @override
  @JsonKey(name: 'Awards')
  final String awards;
  @override
  @JsonKey(name: 'Poster')
  final String poster;
  @override
  @JsonKey(name: 'Metascore')
  final String metascore;
  @override
  @JsonKey(name: 'imdbRating')
  final String imdbRating;
  @override
  @JsonKey(name: 'imdbVotes')
  final String imdbVotes;
  @override
  @JsonKey(name: 'imdbID')
  final String imdbID;
  @override
  @JsonKey(name: 'Type')
  final String type;
  @override
  @JsonKey(name: 'Response')
  final String response;
  final List<String> _images;
  @override
  @JsonKey(name: 'Images')
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey(name: 'ComingSoon')
  final bool comingSoon;
  @override
  @JsonKey(name: 'isFavorite')
  final bool isFavorite;

  @override
  String toString() {
    return 'MovieModel(mongoId: $mongoId, id: $id, title: $title, year: $year, rated: $rated, released: $released, runtime: $runtime, genre: $genre, director: $director, writer: $writer, actors: $actors, plot: $plot, language: $language, country: $country, awards: $awards, poster: $poster, metascore: $metascore, imdbRating: $imdbRating, imdbVotes: $imdbVotes, imdbID: $imdbID, type: $type, response: $response, images: $images, comingSoon: $comingSoon, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieModelImpl &&
            (identical(other.mongoId, mongoId) || other.mongoId == mongoId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.rated, rated) || other.rated == rated) &&
            (identical(other.released, released) ||
                other.released == released) &&
            (identical(other.runtime, runtime) || other.runtime == runtime) &&
            (identical(other.genre, genre) || other.genre == genre) &&
            (identical(other.director, director) ||
                other.director == director) &&
            (identical(other.writer, writer) || other.writer == writer) &&
            (identical(other.actors, actors) || other.actors == actors) &&
            (identical(other.plot, plot) || other.plot == plot) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.awards, awards) || other.awards == awards) &&
            (identical(other.poster, poster) || other.poster == poster) &&
            (identical(other.metascore, metascore) ||
                other.metascore == metascore) &&
            (identical(other.imdbRating, imdbRating) ||
                other.imdbRating == imdbRating) &&
            (identical(other.imdbVotes, imdbVotes) ||
                other.imdbVotes == imdbVotes) &&
            (identical(other.imdbID, imdbID) || other.imdbID == imdbID) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.response, response) ||
                other.response == response) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.comingSoon, comingSoon) ||
                other.comingSoon == comingSoon) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    mongoId,
    id,
    title,
    year,
    rated,
    released,
    runtime,
    genre,
    director,
    writer,
    actors,
    plot,
    language,
    country,
    awards,
    poster,
    metascore,
    imdbRating,
    imdbVotes,
    imdbID,
    type,
    response,
    const DeepCollectionEquality().hash(_images),
    comingSoon,
    isFavorite,
  ]);

  /// Create a copy of MovieModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieModelImplCopyWith<_$MovieModelImpl> get copyWith =>
      __$$MovieModelImplCopyWithImpl<_$MovieModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieModelImplToJson(this);
  }
}

abstract class _MovieModel implements MovieModel {
  const factory _MovieModel({
    @JsonKey(name: '_id') required final String mongoId,
    required final String id,
    @JsonKey(name: 'Title') required final String title,
    @JsonKey(name: 'Year') required final String year,
    @JsonKey(name: 'Rated') required final String rated,
    @JsonKey(name: 'Released') required final String released,
    @JsonKey(name: 'Runtime') required final String runtime,
    @JsonKey(name: 'Genre') required final String genre,
    @JsonKey(name: 'Director') required final String director,
    @JsonKey(name: 'Writer') required final String writer,
    @JsonKey(name: 'Actors') required final String actors,
    @JsonKey(name: 'Plot') required final String plot,
    @JsonKey(name: 'Language') required final String language,
    @JsonKey(name: 'Country') required final String country,
    @JsonKey(name: 'Awards') required final String awards,
    @JsonKey(name: 'Poster') required final String poster,
    @JsonKey(name: 'Metascore') required final String metascore,
    @JsonKey(name: 'imdbRating') required final String imdbRating,
    @JsonKey(name: 'imdbVotes') required final String imdbVotes,
    @JsonKey(name: 'imdbID') required final String imdbID,
    @JsonKey(name: 'Type') required final String type,
    @JsonKey(name: 'Response') required final String response,
    @JsonKey(name: 'Images') required final List<String> images,
    @JsonKey(name: 'ComingSoon') required final bool comingSoon,
    @JsonKey(name: 'isFavorite') required final bool isFavorite,
  }) = _$MovieModelImpl;

  factory _MovieModel.fromJson(Map<String, dynamic> json) =
      _$MovieModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get mongoId;
  @override
  String get id;
  @override
  @JsonKey(name: 'Title')
  String get title;
  @override
  @JsonKey(name: 'Year')
  String get year;
  @override
  @JsonKey(name: 'Rated')
  String get rated;
  @override
  @JsonKey(name: 'Released')
  String get released;
  @override
  @JsonKey(name: 'Runtime')
  String get runtime;
  @override
  @JsonKey(name: 'Genre')
  String get genre;
  @override
  @JsonKey(name: 'Director')
  String get director;
  @override
  @JsonKey(name: 'Writer')
  String get writer;
  @override
  @JsonKey(name: 'Actors')
  String get actors;
  @override
  @JsonKey(name: 'Plot')
  String get plot;
  @override
  @JsonKey(name: 'Language')
  String get language;
  @override
  @JsonKey(name: 'Country')
  String get country;
  @override
  @JsonKey(name: 'Awards')
  String get awards;
  @override
  @JsonKey(name: 'Poster')
  String get poster;
  @override
  @JsonKey(name: 'Metascore')
  String get metascore;
  @override
  @JsonKey(name: 'imdbRating')
  String get imdbRating;
  @override
  @JsonKey(name: 'imdbVotes')
  String get imdbVotes;
  @override
  @JsonKey(name: 'imdbID')
  String get imdbID;
  @override
  @JsonKey(name: 'Type')
  String get type;
  @override
  @JsonKey(name: 'Response')
  String get response;
  @override
  @JsonKey(name: 'Images')
  List<String> get images;
  @override
  @JsonKey(name: 'ComingSoon')
  bool get comingSoon;
  @override
  @JsonKey(name: 'isFavorite')
  bool get isFavorite;

  /// Create a copy of MovieModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieModelImplCopyWith<_$MovieModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
