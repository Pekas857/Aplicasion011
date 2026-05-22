import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/artifact.dart';
import '../screens/detail_screen.dart';

class CollectionItem extends StatelessWidget {
  final Artifact artifact;

  const CollectionItem({super.key, required this.artifact});

  Color get _tagColor {
    switch (artifact.category) {
      case ArtifactCategory.maya:
        return AppColors.mayaTag;
      case ArtifactCategory.mexica:
        return AppColors.mexTag;
      case ArtifactCategory.olmeca:
        return AppColors.olmecaTag;
      case ArtifactCategory.pinturasRupestres:
        return const Color(0xFF6E7A35);
      case ArtifactCategory.piramides:
        return const Color(0xFF8B6914);
    }
  }

  Color get _tagTextColor {
    switch (artifact.category) {
      case ArtifactCategory.maya:
        return AppColors.mayaTagText;
      case ArtifactCategory.mexica:
        return AppColors.goldLight;
      case ArtifactCategory.olmeca:
        return const Color(0xFFD4A870);
      case ArtifactCategory.pinturasRupestres:
        return const Color(0xFFD9DBA3);
      case ArtifactCategory.piramides:
        return const Color(0xFFE8C97A);
    }
  }

  IconData get _iconData {
    switch (artifact.category) {
      case ArtifactCategory.maya:
        return Icons.masks;
      case ArtifactCategory.mexica:
        return Icons.wb_sunny;
      case ArtifactCategory.olmeca:
        return Icons.face;
      case ArtifactCategory.pinturasRupestres:
        return Icons.brush;
      case ArtifactCategory.piramides:
        return Icons.account_balance;
    }
  }

  Color get _iconBgColor {
    switch (artifact.category) {
      case ArtifactCategory.maya:
        return const Color(0xFF3A4A28);
      case ArtifactCategory.mexica:
        return const Color(0xFF4A3A18);
      case ArtifactCategory.olmeca:
        return const Color(0xFF3A2A18);
      case ArtifactCategory.pinturasRupestres:
        return const Color(0xFF4A4B2A);
      case ArtifactCategory.piramides:
        return const Color(0xFF3A2E10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(artifact: artifact),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.divider.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            // Icon circle
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _iconBgColor,
                border: Border.all(
                  color: _tagColor.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: Icon(_iconData, color: _tagColor, size: 24),
            ),
            const SizedBox(width: 14),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artifact.civilization,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: _tagTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    artifact.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    artifact.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Chevron
            Icon(
              Icons.chevron_right,
              color: AppColors.goldMuted.withValues(alpha: 0.6),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}