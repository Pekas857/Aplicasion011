import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CivilizationChips extends StatefulWidget {
  const CivilizationChips({super.key});

  @override
  State<CivilizationChips> createState() => _CivilizationChipsState();
}

class _CivilizationChipsState extends State<CivilizationChips> {
  int _selectedIndex = 0;

  final List<String> _categories = [
    'Todas',
    'Maya',
    'Mexica',
    'Inca',
    'Olmeca',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.chipSelected
                      : AppColors.chipUnselected,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.goldDark.withValues(alpha: 0.5)
                        : AppColors.chipBorder.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: Text(
                  _categories[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
