import 'package:flutter/material.dart';
import 'package:todo/src/core/theme/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      showSelectedLabels: true,
      showUnselectedLabels: true,

      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: const TextStyle(
        fontSize: 11.4,
        fontWeight: FontWeight.w500,
      ),
      selectedLabelStyle: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Сегодня'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Предстоящее',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Поиск'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Обзор'),
      ],
    );
  }
}
