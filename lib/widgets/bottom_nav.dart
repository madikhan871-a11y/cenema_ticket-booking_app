import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class CinemaBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const CinemaBottomNav({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 72,
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primary.withValues(
        alpha: 0.15,
      ),
      selectedIndex: currentIndex,
      onDestinationSelected: onChanged,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(
            Icons.home_rounded,
            color: AppColors.primary,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.movie_outlined),
          selectedIcon: Icon(
            Icons.movie_rounded,
            color: AppColors.primary,
          ),
          label: 'Movies',
        ),
        NavigationDestination(
          icon: Icon(Icons.confirmation_num_outlined),
          selectedIcon: Icon(
            Icons.confirmation_num_rounded,
            color: AppColors.primary,
          ),
          label: 'Tickets',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(
            Icons.person,
            color: AppColors.primary,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}