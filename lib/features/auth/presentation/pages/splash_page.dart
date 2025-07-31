import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animasyon controller'ını başlat
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    // Animasyonu başlat
    _animationController.forward();

    // Auth durumunu kontrol et
    context.read<AuthBloc>().add(const AuthStatusChecked());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Kullanıcı giriş yapmış, ana sayfaya yönlendir
            Future.delayed(const Duration(milliseconds: 1500), () {
              if (mounted) {
                context.go(AppRouter.home);
              }
            });
          } else if (state is AuthUnauthenticated) {
            // Kullanıcı giriş yapmamış, login sayfasına yönlendir
            Future.delayed(const Duration(milliseconds: 1500), () {
              if (mounted) {
                context.go(AppRouter.login);
              }
            });
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo ve uygulama adı
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: Column(
                        children: [
                          // Logo
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.movie, size: 60, color: Colors.white),
                          ),

                          const SizedBox(height: 24),

                          // Uygulama adı
                          Text(
                            'Sinflix',
                            style: AppTextStyles.h1.copyWith(
                              color: isDark ? AppColors.darkText : AppColors.lightText,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Slogan
                          Text(
                            'Your Movie Experience',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 80),

              // Loading indicator
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeAnimation.value,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                              ),
                            ),

                            const SizedBox(height: 16),

                            Text(
                              _getLoadingText(state),
                              style: AppTextStyles.bodySmall.copyWith(color: AppColors.grey),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getLoadingText(AuthState state) {
    if (state is AuthLoading) {
      return 'Checking authentication...';
    } else if (state is AuthAuthenticated) {
      return 'Welcome back!';
    } else if (state is AuthUnauthenticated) {
      return 'Loading...';
    }
    return 'Initializing...';
  }
}
