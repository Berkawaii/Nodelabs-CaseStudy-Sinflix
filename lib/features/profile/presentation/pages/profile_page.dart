import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../movie/presentation/pages/movie_detail_page.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() {
    context.read<ProfileBloc>().add(const LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.message}',
                      style: AppTextStyles.bodyMedium.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(onPressed: _loadProfileData, child: const Text('Retry')),
                  ],
                ),
              );
            }

            if (state is ProfileLoaded) {
              return _buildProfileContent(context, state, isDark);
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileLoaded state, bool isDark) {
    return CustomScrollView(
      slivers: [
        // Custom App Bar
        SliverAppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          pinned: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Profil Detayı',
            style: AppTextStyles.h2.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Sınırlı Teklif',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Profile Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Profile Image and Name
                Row(
                  children: [
                    // Profile Picture
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.grey.withOpacity(0.3), width: 2),
                      ),
                      child: ClipOval(
                        child: state.userProfile.photoUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: state.userProfile.photoUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: AppColors.grey.withOpacity(0.3),
                                  child: Icon(Icons.person, size: 40, color: AppColors.grey),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: AppColors.grey.withOpacity(0.3),
                                  child: Icon(Icons.person, size: 40, color: AppColors.grey),
                                ),
                              )
                            : Container(
                                color: AppColors.grey.withOpacity(0.3),
                                child: Icon(Icons.person, size: 40, color: AppColors.grey),
                              ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.userProfile.name,
                            style: AppTextStyles.h2.copyWith(
                              color: isDark ? AppColors.darkText : AppColors.lightText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'ID: ${state.userProfile.id.substring(0, 6)}',
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),

                    // Photo Add Button
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Fotoğraf Ekle',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Favorite Movies Section
                if (state.favoriteMovies.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Beğendiğim Filmler',
                      style: AppTextStyles.h3.copyWith(
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFavoriteMoviesGrid(state.favoriteMovies, isDark),
                ],
              ],
            ),
          ),
        ),

        // Bottom Navigation Space
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildFavoriteMoviesGrid(List<dynamic> favoriteMovies, bool isDark) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: favoriteMovies.length,
      itemBuilder: (context, index) {
        final movie = favoriteMovies[index];
        return GestureDetector(
          onTap: () => _showMovieDetail(context, movie),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Poster
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: movie.poster.replaceFirst('http://', 'https://'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => Container(
                        color: AppColors.grey.withOpacity(0.3),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.grey.withOpacity(0.3),
                        child: const Icon(Icons.movie, size: 50, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                // Movie Info
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : AppColors.lightCard,
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          movie.title,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          movie.director,
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMovieDetail(BuildContext context, dynamic movie) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => MovieDetailPage(movie: movie),
      ),
    );
  }
}
