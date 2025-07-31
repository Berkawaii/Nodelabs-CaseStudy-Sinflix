import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'core/localization/app_localizations.dart';
import 'core/logger/app_logger.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logger
  appLogger.info('🚀 Sinflix app starting...');

  // Initialize dependencies
  await configureDependencies();
  appLogger.info('✅ Dependencies configured');

  runApp(const SinflixApp());
}

class SinflixApp extends StatelessWidget {
  const SinflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<AuthBloc>())],
      child: MaterialApp.router(
        title: 'Sinflix',
        debugShowCheckedModeBanner: false,

        // Localization
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,

        // Theme
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,

        // Router
        routerConfig: AppRouter.router,
      ),
    );
  }
}
