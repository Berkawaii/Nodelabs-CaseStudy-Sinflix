import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/movie.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: CustomScrollView(
        slivers: [
          // App Bar with Movie Poster
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: isDark ? AppColors.darkCard : AppColors.lightCard,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Movie Poster
                  CachedNetworkImage(
                    imageUrl: movie.poster.replaceFirst('http://', 'https://'),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.movie, size: 100, color: Colors.grey),
                    ),
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                  // Movie Title and Year at Bottom
                  Positioned(
                    bottom: 60,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: AppTextStyles.h1.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                movie.year,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                movie.rated,
                                style: AppTextStyles.bodySmall.copyWith(color: Colors.white),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Movie Details Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating and Runtime Row
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${movie.imdbRating}/10',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.darkText : AppColors.lightText,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${movie.imdbVotes} ${l10n.votes})',
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey),
                      ),
                      const Spacer(),
                      Icon(Icons.access_time, color: AppColors.grey, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        movie.runtime,
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Plot/Overview
                  _buildSection(l10n.plot, movie.plot, isDark),
                  const SizedBox(height: 24),

                  // Genre
                  _buildSection(l10n.genre, movie.genre, isDark),
                  const SizedBox(height: 24),

                  // Director
                  _buildSection(l10n.director, movie.director, isDark),
                  const SizedBox(height: 24),

                  // Cast
                  _buildSection(l10n.cast, movie.actors, isDark),
                  const SizedBox(height: 24),

                  // Writer
                  _buildSection(l10n.writer, movie.writer, isDark),
                  const SizedBox(height: 24),

                  // Additional Info
                  _buildInfoGrid(isDark, l10n),

                  // Movie Images Gallery
                  if (movie.images.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    _buildImageGallery(isDark, l10n),
                  ],

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.h3.copyWith(
            color: isDark ? AppColors.darkText : AppColors.lightText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isDark ? AppColors.darkText : AppColors.lightText,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoGrid(bool isDark, AppLocalizations l10n) {
    final infoItems = [
      {'label': l10n.released, 'value': movie.released},
      {'label': l10n.language, 'value': movie.language},
      {'label': l10n.country, 'value': movie.country},
      {'label': l10n.awards, 'value': movie.awards},
      {'label': l10n.metascore, 'value': movie.metascore},
      {'label': 'IMDB ID', 'value': movie.imdbID},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.additionalInformation,
          style: AppTextStyles.h3.copyWith(
            color: isDark ? AppColors.darkText : AppColors.lightText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5, // UI overflow sorununu çözmek için artırdık
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: infoItems.length,
          itemBuilder: (context, index) {
            final item = infoItems[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightCard,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.grey.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['label']!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    // UI overflow sorununu çözmek için Expanded ekledik
                    child: Text(
                      item['value']!,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3, // Daha fazla satır için artırdık
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildImageGallery(bool isDark, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.gallery,
          style: AppTextStyles.h3.copyWith(
            color: isDark ? AppColors.darkText : AppColors.lightText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movie.images.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 12),
                width: 160,
                child: GestureDetector(
                  onTap: () => _showImageDialog(context, movie.images, index),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: movie.images[index],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showImageDialog(BuildContext context, List<String> images, int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (context) => ImageGalleryDialog(images: images, initialIndex: initialIndex),
    );
  }
}

class ImageGalleryDialog extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ImageGalleryDialog({super.key, required this.images, required this.initialIndex});

  @override
  State<ImageGalleryDialog> createState() => _ImageGalleryDialogState();
}

class _ImageGalleryDialogState extends State<ImageGalleryDialog> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          // Image PageView
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: CachedNetworkImage(
                    imageUrl: widget.images[index],
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator(color: Colors.white)),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error, color: Colors.white, size: 50)),
                  ),
                ),
              );
            },
          ),
          // Close button
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 24),
              ),
            ),
          ),
          // Image counter
          if (widget.images.length > 1)
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_currentIndex + 1} / ${widget.images.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          // Navigation arrows for multiple images
          if (widget.images.length > 1) ...[
            // Previous arrow
            if (_currentIndex > 0)
              Positioned(
                left: 20,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ),
            // Next arrow
            if (_currentIndex < widget.images.length - 1)
              Positioned(
                right: 20,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
