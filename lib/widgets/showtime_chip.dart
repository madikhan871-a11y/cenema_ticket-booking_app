import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class ShowtimeChip extends StatelessWidget {
  final String time;
  final String format;
  final bool selected;
  final VoidCallback onTap;

  const ShowtimeChip({
    super.key,
    required this.time,
    required this.format,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : AppColors.surface,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.border,
          ),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : AppColors.textPrimary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              format,
              style: TextStyle(
                color: selected
                    ? Colors.white70
                    : AppColors.textSecondary,
                fontSize: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}