import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {
  const LoadProfile();
}

class LoadFavoriteMovies extends ProfileEvent {
  const LoadFavoriteMovies();
}

class UploadPhoto extends ProfileEvent {
  final File imageFile;

  const UploadPhoto({required this.imageFile});

  @override
  List<Object> get props => [imageFile];
}
