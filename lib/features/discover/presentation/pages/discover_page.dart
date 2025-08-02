import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../movie/domain/entities/movie.dart';
import '../../../movie/presentation/bloc/movie_bloc.dart';
import '../widgets/swipe_card.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DiscoverView();
  }
}

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  List<Movie> _displayedMovies = [];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text(
          l10n.discover,
          style: AppTextStyles.h2.copyWith(
            color: isDark ? AppColors.darkText : AppColors.lightText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) {
          state.whenOrNull(
            loaded: (movies, hasReachedMax, currentPage) {
              // Yeni filmler geldiğinde listeyi güncelle
              if (movies.isNotEmpty) {
                setState(() {
                  _displayedMovies = List.from(movies);
                  // Eğer mevcut index film sayısından büyükse sıfırla
                  if (_currentIndex >= _displayedMovies.length) {
                    _currentIndex = 0;
                  }
                });
              }
            },
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (movies, hasReachedMax, currentPage) {
              // İlk yüklemede listeyi doldur
              if (_displayedMovies.isEmpty && movies.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _displayedMovies = List.from(movies);
                    _currentIndex = 0;
                  });
                });
              }

              if (_displayedMovies.isEmpty) {
                return _buildEmptyState(l10n, isDark);
              }

              return _buildSwipeCards(l10n);
            },
            error: (message) => _buildErrorState(l10n, message, isDark),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Pass button
            GestureDetector(
              onTap: () => _onSwipeLeft(),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: .1),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 2),
                ),
                child: const Icon(Icons.close, color: Colors.red, size: 28),
              ),
            ),
            // Instructions
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.swipeOrTap,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, size: 16, color: Colors.red),
                    Text(
                      ' ${l10n.pass}  ',
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.grey),
                    ),
                    Icon(Icons.favorite, size: 16, color: Colors.green),
                    Text(
                      ' ${l10n.like}',
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.grey),
                    ),
                  ],
                ),
              ],
            ),
            // Like button
            GestureDetector(
              onTap: () => _onSwipeRight(),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: .1),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: const Icon(Icons.favorite, color: Colors.green, size: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwipeCards(AppLocalizations l10n) {
    // Eğer sondan 2 kart kaldıysa yeni filmler yükle
    if (_currentIndex >= _displayedMovies.length - 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final currentState = context.read<MovieBloc>().state;
        currentState.whenOrNull(
          loaded: (movies, hasReachedMax, currentPage) {
            if (!hasReachedMax) {
              context.read<MovieBloc>().add(const MovieEvent.loadMoreMovies());
            }
          },
        );
      });
    }

    // Eğer tüm filmler bittiyse ve yeni film yoksa
    if (_currentIndex >= _displayedMovies.length) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie Animation
            SizedBox(
              width: 150,
              height: 150,
              child: Lottie.asset(
                'assets/lottie/movies_completed.json',
                fit: BoxFit.contain,
                repeat: true,
                animate: true,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.allMoviesViewed,
              style: AppTextStyles.h2.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkText
                    : AppColors.lightText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.refreshToSeeMore,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
                context.read<MovieBloc>().add(const MovieEvent.refreshMovies());
              },
              child: Text(l10n.refresh),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background card (next movie)
          if (_currentIndex + 1 < _displayedMovies.length)
            SwipeCard(
              key: ValueKey(
                _displayedMovies[_currentIndex + 1].id,
              ), // Key ile widget'ı yeniden oluştur
              movie: _displayedMovies[_currentIndex + 1],
              onSwipeLeft: () {},
              onSwipeRight: () {},
              isTop: false,
            ),
          // Top card (current movie)
          SwipeCard(
            key: ValueKey(_displayedMovies[_currentIndex].id), // Key ile widget'ı yeniden oluştur
            movie: _displayedMovies[_currentIndex],
            onSwipeLeft: _onSwipeLeft,
            onSwipeRight: _onSwipeRight,
            isTop: true,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie Animation
          SizedBox(
            width: 200,
            height: 200,
            child: Lottie.asset(
              'assets/lottie/empty_movies.json',
              fit: BoxFit.contain,
              repeat: true,
              animate: true,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.noMoviesAvailable,
            style: AppTextStyles.h2.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.pleaseTryAgain,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<MovieBloc>().add(const MovieEvent.loadMovies());
            },
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(AppLocalizations l10n, String message, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColors.grey),
          const SizedBox(height: 16),
          Text(
            l10n.errorOccurred,
            style: AppTextStyles.h3.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<MovieBloc>().add(const MovieEvent.loadMovies());
            },
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }

  void _onSwipeLeft() {
    // Just move to next movie (pass)
    setState(() {
      _currentIndex++;
    });
  }

  void _onSwipeRight() {
    // Add to favorites and move to next movie
    final movie = _displayedMovies[_currentIndex];
    final l10n = AppLocalizations.of(context)!;

    context.read<MovieBloc>().add(MovieEvent.toggleFavorite(movieId: movie.id));

    setState(() {
      _currentIndex++;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${movie.title} ${l10n.addedToFavorites}'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
