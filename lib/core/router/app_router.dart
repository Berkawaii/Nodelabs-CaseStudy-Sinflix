import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/main/presentation/pages/main_layout_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static final GoRouter _router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,
    routes: [
      // Splash Route
      GoRoute(path: splash, name: 'splash', builder: (context, state) => const SplashPage()),

      // Auth Routes
      GoRoute(path: login, name: 'login', builder: (context, state) => const LoginPage()),
      GoRoute(path: register, name: 'register', builder: (context, state) => const RegisterPage()),

      // Main App Routes
      GoRoute(path: home, name: 'home', builder: (context, state) => const MainLayoutPage()),
    ],

    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.uri}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRouter.splash),
              child: const Text('Go to Splash'),
            ),
          ],
        ),
      ),
    ),
  );

  static GoRouter get router => _router;
}
