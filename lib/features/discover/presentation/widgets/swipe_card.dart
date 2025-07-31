import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../movie/domain/entities/movie.dart';

class SwipeCard extends StatefulWidget {
  final Movie movie;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final bool isTop;

  const SwipeCard({
    super.key,
    required this.movie,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    this.isTop = false,
  });

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  Offset _dragOffset = Offset.zero;
  bool _isDragging = false;
  double _dragDistance = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _rotationAnimation = Tween<double>(begin: 0, end: 0).animate(_animationController);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _isDragging = true;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    setState(() {
      _dragOffset += details.delta;
      _dragDistance = _dragOffset.distance;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!_isDragging) return;
    _isDragging = false;

    const threshold = 100.0;
    final velocity = details.velocity.pixelsPerSecond;
    final isSwipeLeft = _dragOffset.dx < -threshold || velocity.dx < -500;
    final isSwipeRight = _dragOffset.dx > threshold || velocity.dx > 500;

    if (isSwipeLeft) {
      _animateSwipe(const Offset(-2, 0), widget.onSwipeLeft);
    } else if (isSwipeRight) {
      _animateSwipe(const Offset(2, 0), widget.onSwipeRight);
    } else {
      _resetPosition();
    }
  }

  void _animateSwipe(Offset targetOffset, VoidCallback onComplete) {
    _animation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset(
        targetOffset.dx * MediaQuery.of(context).size.width,
        targetOffset.dy * MediaQuery.of(context).size.height,
      ),
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _rotationAnimation = Tween<double>(
      begin: _getRotation(),
      end: targetOffset.dx > 0 ? 0.3 : -0.3,
    ).animate(_animationController);

    _animationController.forward().then((_) {
      // Reset the controller for next swipe
      _animationController.reset();
      setState(() {
        _dragOffset = Offset.zero;
        _isDragging = false;
      });
      onComplete();
    });
  }

  void _resetPosition() {
    _animation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.elasticOut));

    _rotationAnimation = Tween<double>(begin: _getRotation(), end: 0).animate(_animationController);

    _animationController.forward().then((_) {
      setState(() {
        _dragOffset = Offset.zero;
        _isDragging = false;
      });
      _animationController.reset();
    });
  }

  double _getRotation() {
    const maxRotation = 0.1;
    return (_dragOffset.dx / 300).clamp(-maxRotation, maxRotation);
  }

  Color _getSwipeColor() {
    if (_dragOffset.dx > 50) {
      return Colors.green.withOpacity(min(1.0, _dragOffset.dx / 200));
    } else if (_dragOffset.dx < -50) {
      return Colors.red.withOpacity(min(1.0, -_dragOffset.dx / 200));
    }
    return Colors.transparent;
  }

  IconData _getSwipeIcon() {
    if (_dragOffset.dx > 50) {
      return Icons.favorite;
    } else if (_dragOffset.dx < -50) {
      return Icons.close;
    }
    return Icons.favorite_border;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final offset = _isDragging ? _dragOffset : _animation.value;
        final rotation = _isDragging ? _getRotation() : _rotationAnimation.value;
        final scale = widget.isTop ? 1.0 : _scaleAnimation.value;

        return Transform.translate(
          offset: offset,
          child: Transform.rotate(
            angle: rotation,
            child: Transform.scale(
              scale: scale,
              child: GestureDetector(
                onPanStart: widget.isTop ? _onPanStart : null,
                onPanUpdate: widget.isTop ? _onPanUpdate : null,
                onPanEnd: widget.isTop ? _onPanEnd : null,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Movie Poster Background
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: widget.movie.poster.replaceFirst('http://', 'https://'),
                          width: double.infinity,
                          height: double.infinity,
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
                      ),
                      // Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                            stops: const [0.4, 1.0],
                          ),
                        ),
                      ),
                      // Swipe Indicator
                      if (_isDragging && _dragDistance > 20)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: _getSwipeColor(),
                          ),
                          child: Center(
                            child: Icon(_getSwipeIcon(), size: 80, color: Colors.white),
                          ),
                        ),
                      // Movie Information
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Title and Year
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.movie.title,
                                      style: AppTextStyles.h2.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      widget.movie.year,
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Rating and Runtime
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 20),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.movie.imdbRating,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.access_time, color: Colors.white70, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.movie.runtime,
                                    style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Genre
                              Text(
                                widget.movie.genre,
                                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),
                              // Plot
                              Text(
                                widget.movie.plot,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Colors.white70,
                                  height: 1.4,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
