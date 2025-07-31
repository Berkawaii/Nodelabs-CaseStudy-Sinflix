import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';

class AppRouter {
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';

  static final GoRouter _router = GoRouter(
    initialLocation: login,
    debugLogDiagnostics: true,
    routes: [
      // Auth Routes
      GoRoute(path: login, name: 'login', builder: (context, state) => const LoginPage()),
      GoRoute(path: register, name: 'register', builder: (context, state) => const RegisterPage()),

      // Main App Routes
      GoRoute(path: home, name: 'home', builder: (context, state) => const HomePage()),
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
            ElevatedButton(onPressed: () => context.go(login), child: const Text('Go to Login')),
          ],
        ),
      ),
    ),
  );

  static GoRouter get router => _router;
}

// Temporary HomePage widget - replace with actual implementation later
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sinflix'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () => context.go(AppRouter.login)),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie, size: 100, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'Welcome to Sinflix!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Movies and series coming soon...', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
