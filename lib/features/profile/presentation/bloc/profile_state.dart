import 'package:equatable/equatable.dart';

import '../../domain/entities/user_profile.dart';
import '../../../movie/domain/entities/movie.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile userProfile;
  final List<Movie> favoriteMovies;

  const ProfileLoaded({
    required this.userProfile,
    required this.favoriteMovies,
  });

  @override
  List<Object> get props => [userProfile, favoriteMovies];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}
