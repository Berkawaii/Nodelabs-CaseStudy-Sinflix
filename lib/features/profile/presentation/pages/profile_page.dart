import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/limited_offer_modal.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../movie/presentation/bloc/movie_bloc.dart';
import '../../../movie/presentation/pages/movie_detail_page.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import 'photo_upload_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadProfileData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App resumed, reload profile data
      _loadProfileData();
    }
  }

  void _loadProfileData() {
    context.read<ProfileBloc>().add(const LoadProfile());
  }

  Future<void> _navigateToPhotoUpload(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PhotoUploadPage()),
    );

    // If photo was uploaded successfully, reload profile
    if (result == true) {
      _loadProfileData();
    }
  }

  void _showLimitedOfferModal(BuildContext context) {
    showModalBottomSheet(
      requestFocus: true,
      context: context,

      isScrollControlled: true,
      builder: (context) => const LimitedOfferModal(),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirmation),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.cancel)),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthBloc>().add(const LogoutRequested());
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthUnauthenticated) {
                  // Navigate to login page
                  context.go(AppRouter.login);
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Logout failed: ${state.message}'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              },
            ),
            // Listen to MovieBloc for favorite changes
            BlocListener<MovieBloc, MovieState>(
              listener: (context, state) {
                // When a movie toggle favorite action completes, reload favorites
                // This will be triggered after any toggle favorite operation
                if (mounted) {
                  // Small delay to ensure the API call is completed
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted) {
                      context.read<ProfileBloc>().add(const LoadFavoriteMovies());
                    }
                  });
                }
              },
            ),
          ],
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
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileLoaded state, bool isDark) {
    final l10n = AppLocalizations.of(context)!;

    return CustomScrollView(
      slivers: [
        // Custom App Bar
        SliverAppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          pinned: true,
          automaticallyImplyLeading: false,
          title: Text(
            l10n.profileDetail,
            style: AppTextStyles.h2.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            // Refresh Button
            IconButton(
              onPressed: () => _loadProfileData(),
              icon: Icon(Icons.refresh, color: isDark ? AppColors.darkText : AppColors.lightText),
              tooltip: 'Refresh',
            ),

            // Limited Offer Button
            GestureDetector(
              onTap: () => _showLimitedOfferModal(context),
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      l10n.limitedOffer,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
                        border: Border.all(color: AppColors.grey.withValues(alpha: 0.3), width: 2),
                      ),
                      child: ClipOval(
                        child: state.userProfile.photoUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: state.userProfile.photoUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: AppColors.grey.withValues(alpha: 0.3),
                                  child: Icon(Icons.person, size: 40, color: AppColors.grey),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: AppColors.grey.withValues(alpha: 0.3),
                                  child: Icon(Icons.person, size: 40, color: AppColors.grey),
                                ),
                              )
                            : Container(
                                color: AppColors.grey.withValues(alpha: 0.3),
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
                    GestureDetector(
                      onTap: () => _navigateToPhotoUpload(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          l10n.addPhoto,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    // Logout Button
                    IconButton(
                      onPressed: () => _showLogoutConfirmation(context),
                      icon: Icon(
                        Icons.logout,
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                      tooltip: l10n.logout,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Favorite Movies Section
                if (state.favoriteMovies.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.favoriteMovies,
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
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemCount: favoriteMovies.length,
      itemBuilder: (context, index) {
        final movie = favoriteMovies[index];
        return GestureDetector(
          onTap: () => _showMovieDetail(context, movie),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Movie Poster
                  CachedNetworkImage(
                    imageUrl: movie.poster.replaceFirst('http://', 'https://'),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.grey.withValues(alpha: 0.3),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.grey.withValues(alpha: 0.3),
                      child: const Icon(Icons.movie, size: 50, color: Colors.grey),
                    ),
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.3),
                          Colors.black.withValues(alpha: 0.8),
                        ],
                        stops: const [0.4, 0.7, 1.0],
                      ),
                    ),
                  ),
                  // Movie Info at Bottom
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            movie.title,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                movie.imdbRating,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  movie.year,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Favorite Icon
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.favorite, color: AppColors.primary, size: 16),
                    ),
                  ),
                ],
              ),
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
