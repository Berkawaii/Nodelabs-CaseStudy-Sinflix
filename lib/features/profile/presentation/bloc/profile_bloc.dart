import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/profile_api_service.dart';
import 'profile_event.dart';
import 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileApiService _profileApiService;

  ProfileBloc(this._profileApiService) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<LoadFavoriteMovies>(_onLoadFavoriteMovies);
    on<UploadPhoto>(_onUploadPhoto);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final userProfile = await _profileApiService.getUserProfile();
      final favoriteMovies = await _profileApiService.getFavoriteMovies();
      
      emit(ProfileLoaded(
        userProfile: userProfile,
        favoriteMovies: favoriteMovies,
      ));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onLoadFavoriteMovies(LoadFavoriteMovies event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      try {
        final favoriteMovies = await _profileApiService.getFavoriteMovies();
        emit(ProfileLoaded(
          userProfile: currentState.userProfile,
          favoriteMovies: favoriteMovies,
        ));
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    }
  }

  Future<void> _onUploadPhoto(UploadPhoto event, Emitter<ProfileState> emit) async {
    emit(PhotoUploading());
    try {
      final photoUrl = await _profileApiService.uploadPhoto(event.imageFile);
      emit(PhotoUploadSuccess(photoUrl: photoUrl));
      
      // Reload profile after successful upload
      add(const LoadProfile());
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
