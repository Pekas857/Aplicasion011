import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../theme/app_theme.dart';
import '../models/artifact.dart';
import 'ar_view_screen.dart';

class DetailScreen extends StatefulWidget {
  final Artifact artifact;

  const DetailScreen({super.key, required this.artifact});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color get _tagColor {
    switch (widget.artifact.category) {
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
    switch (widget.artifact.category) {
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

  @override
  Widget build(BuildContext context) {
    final a = widget.artifact;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.grid_view_rounded,
                      color: AppColors.gold.withValues(alpha: 0.7),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Preview 3D
                    Container(
                      width: double.infinity,
                      height: 240,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.goldDark.withValues(alpha: 0.2),
                          width: 0.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            if (a.previewModel.isNotEmpty)
                              ModelViewer(
                                src: a.previewModel,
                                alt: a.name,
                                autoRotate: true,
                                autoRotateDelay: 0,
                                rotationPerSecond: '20deg',
                                cameraControls: false,
                                disableZoom: true,
                                ar: false,
                                backgroundColor: Colors.transparent,
                                disableTap: true,
                              )
                            else
                              Center(
                                child: Icon(
                                  Icons.view_in_ar,
                                  size: 64,
                                  color: AppColors.gold.withValues(alpha: 0.3),
                                ),
                              ),
                            if (a.previewModel.isNotEmpty)
                              Positioned.fill(
                                child: AbsorbPointer(
                                  absorbing: true,
                                  child: Container(color: Colors.transparent),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Tag + discovered
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: _tagColor.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _tagColor.withValues(alpha: 0.5),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              a.civilization.split(' ').first,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                                color: _tagTextColor,
                              ),
                            ),
                          ),
                          if (a.discovered.isNotEmpty)
                            Text(
                              a.discovered,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary
                                    .withValues(alpha: 0.7),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        a.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Period
                    if (a.period.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          a.period,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _tagTextColor.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    const SizedBox(height: 28),

                    // Tabs
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: AppColors.textPrimary,
                        unselectedLabelColor: AppColors.textMuted,
                        labelStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        indicatorColor: AppColors.gold,
                        indicatorWeight: 2.5,
                        indicatorSize: TabBarIndicatorSize.label,
                        dividerColor: AppColors.divider.withValues(alpha: 0.4),
                        tabs: const [
                          Tab(text: 'Historia'),
                          Tab(text: 'Descubrimiento'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tab content
                    SizedBox(
                      height: 300,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SingleChildScrollView(
                              child: Text(
                                a.historyText.isNotEmpty
                                    ? a.historyText
                                    : 'No hay información histórica disponible.',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColors.textSecondary,
                                  height: 1.7,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SingleChildScrollView(
                              child: Text(
                                a.discoveryText.isNotEmpty
                                    ? a.discoveryText
                                    : 'No hay información del descubrimiento disponible.',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColors.textSecondary,
                                  height: 1.7,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom AR button
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ArViewScreen(artifact: widget.artifact),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold.withValues(alpha: 0.15),
                      foregroundColor: AppColors.gold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                          color: AppColors.gold.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.view_in_ar, size: 22),
                        SizedBox(width: 10),
                        Text(
                          'VER EN TU SALA (AR)',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}