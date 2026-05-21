import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PageIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const PageIndicator({
    super.key,
    required this.itemCount,
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isActive = index == currentIndex;
        if (index == 1) {
          // Diamond shape for center indicator
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Transform.rotate(
              angle: 0.785398, // 45 degrees in radians
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isActive ? 9 : 7,
                height: isActive ? 9 : 7,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.gold
                      : AppColors.goldMuted.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isActive ? 8 : 6,
            height: isActive ? 8 : 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? AppColors.gold
                  : AppColors.goldMuted.withValues(alpha: 0.4),
            ),
          ),
        );
      }),
    );
  }
}
