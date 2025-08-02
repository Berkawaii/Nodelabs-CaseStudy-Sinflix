import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../discover/presentation/pages/discover_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../movie/presentation/bloc/movie_bloc.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../profile/presentation/bloc/profile_event.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class MainLayoutPage extends StatefulWidget {
  const MainLayoutPage({super.key});

  @override
  State<MainLayoutPage> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [const HomeView(), const DiscoverView(), const ProfilePage()];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<MovieBloc>()..add(const MovieEvent.loadMovies())),
        BlocProvider(create: (context) => getIt<ProfileBloc>()),
      ],
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });

              // If switching to profile page (index 2), refresh profile data
              if (index == 2) {
                // Add a small delay to ensure the page is built
                Future.delayed(const Duration(milliseconds: 100), () {
                  try {
                    final profileBloc = BlocProvider.of<ProfileBloc>(context, listen: false);
                    profileBloc.add(const LoadProfile());
                  } catch (e) {
                    // Context may not be available, ignore
                  }
                });
              }
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: isDark ? AppColors.lightBackground : AppColors.darkBackground,
            elevation: 0,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
                label: l10n.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.explore_outlined),
                activeIcon: const Icon(Icons.explore),
                label: l10n.discover,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                activeIcon: const Icon(Icons.person),
                label: l10n.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
