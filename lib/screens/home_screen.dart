import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/artifact.dart';
import '../widgets/featured_card.dart';
import '../widgets/civilization_chips.dart';
import '../widgets/collection_item.dart';
import '../widgets/page_indicator.dart';
import '../widgets/bottom_nav_bar.dart';
import 'scan_screen.dart';
import 'settings_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // "Pieza Destacada" header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: AppColors.gold.withValues(alpha: 0.7),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Pieza Destacada',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary.withValues(alpha: 0.8),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Featured card
          const FeaturedCard(),
          const SizedBox(height: 20),

          // Page indicator dots
          const PageIndicator(itemCount: 4, currentIndex: 1),
          const SizedBox(height: 28),

          // "Civilizaciones" header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Civilizaciones',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Civilization filter chips
          const CivilizationChips(),
          const SizedBox(height: 24),

          // "Colección" header + count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Colección',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  '4 piezas',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gold.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Collection list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: sampleArtifacts
                  .map((artifact) => CollectionItem(artifact: artifact))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPage() {
    switch (_navIndex) {
      case 1:
        return const ScanScreen();
      case 2:
        return const SettingsScreen();
      case 0:
      default:
        return _buildHomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // App bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'AR  HISTORIA',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3.5,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_none_rounded,
                        color: AppColors.gold.withValues(alpha: 0.8),
                        size: 26,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.person_outline_rounded,
                        color: AppColors.gold.withValues(alpha: 0.8),
                        size: 26,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Expanded(child: _buildPage()),

            // Bottom navigation
            BottomNavBar(
              selectedIndex: _navIndex,
              onTap: (index) {
                setState(() {
                  _navIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}