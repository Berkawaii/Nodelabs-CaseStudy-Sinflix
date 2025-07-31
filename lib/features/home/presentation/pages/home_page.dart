import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../movie/domain/entities/movie.dart';
import '../../../movie/presentation/bloc/movie_bloc.dart';
import '../../../movie/presentation/widgets/movie_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MovieBloc>()..add(const MovieEvent.loadMovies()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final currentState = context.read<MovieBloc>().state;
      currentState.whenOrNull(
        loaded: (movies, hasReachedMax, currentPage) {
          if (!hasReachedMax) {
            context.read<MovieBloc>().add(const MovieEvent.loadMoreMovies());
          }
        },
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCard : AppColors.lightCard,
        elevation: 0,
        title: Text(
          'Sinflix',
          style: AppTextStyles.h2.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: isDark ? AppColors.darkText : AppColors.lightText),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
            onPressed: () {
              // Notifications
            },
          ),
        ],
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (movies, hasReachedMax, currentPage) => RefreshIndicator(
              onRefresh: () async {
                context.read<MovieBloc>().add(const MovieEvent.refreshMovies());
              },
              child: _buildMovieGrid(movies),
            ),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppColors.grey),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)?.errorOccurred ?? 'Bir hata oluştu',
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
                    child: Text(AppLocalizations.of(context)?.retry ?? 'Tekrar Dene'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMovieGrid(List<Movie> movies, {bool isLoadingMore = false}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6, // Daha yüksek kartlar için
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: movies.length + (isLoadingMore ? 2 : 0),
        itemBuilder: (context, index) {
          if (index >= movies.length) {
            // Loading more indicators
            return Card(
              color: AppColors.grey.withOpacity(0.1),
              child: const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            );
          }

          final movie = movies[index];
          return MovieCard(movie: movie);
        },
      ),
    );
  }
}
