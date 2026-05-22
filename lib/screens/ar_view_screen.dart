import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/artifact.dart';
import '../theme/app_theme.dart';

class ArViewScreen extends StatefulWidget {
  final Artifact artifact;

  const ArViewScreen({super.key, required this.artifact});

  @override
  State<ArViewScreen> createState() => _ArViewScreenState();
}

class _ArViewScreenState extends State<ArViewScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  Key _viewerKey = const ValueKey(0);
  WebViewController? _webViewController;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  List<String> get _models => widget.artifact.arModels;
  List<String> get _labels => widget.artifact.arModelLabels;
  
  bool get _hasMultipleModels => _models.length > 1;

  String get _currentModel {
    if (_models.isEmpty) return '';
    return _models[_selectedIndex.clamp(0, _models.length - 1)];
  }

  String get _currentLabel {
    if (_labels.isEmpty) return 'Modelo';
    return _labels[_selectedIndex.clamp(0, _labels.length - 1)];
  }

  Color get _accentColor {
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

  Color get _accentTextColor {
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
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _selectModel(int index) {
    if (index == _selectedIndex || index >= _models.length) return;
    _fadeController.reverse().then((_) {
      setState(() {
        _selectedIndex = index;
        _viewerKey = ValueKey(index);
        _webViewController = null;
      });
      _fadeController.forward();
    });
  }

  Future<void> _activateAR() async {
    if (_webViewController != null) {
      try {
        await _webViewController!.runJavaScript(
          "document.querySelector('model-viewer').activateAR();",
        );
      } catch (_) {
        _showSnack('Toca el botón AR dentro del visor para colocarlo en tu sala');
      }
    } else {
      _showSnack('El visor aún está cargando, intenta en un momento');
    }
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_models.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 48, color: AppColors.textMuted),
              const SizedBox(height: 16),
              const Text(
                'Sin modelos disponibles',
                style: TextStyle(color: AppColors.textMuted, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

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
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.artifact.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          _hasMultipleModels ? _currentLabel : 'Modelo 3D',
                          style: TextStyle(
                            fontSize: 11,
                            color: _accentTextColor.withValues(alpha: 0.8),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Indicador de AR
                  Icon(
                    Icons.view_in_ar,
                    color: AppColors.gold.withValues(alpha: 0.7),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),

            // ModelViewer
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: ModelViewer(
                  key: _viewerKey,
                  src: _currentModel,
                  alt: '${widget.artifact.name} - $_currentLabel',
                  ar: true,
                  arModes: const ['scene-viewer', 'webxr', 'quick-look'],
                  autoRotate: true,
                  autoRotateDelay: 800,
                  cameraControls: true,
                  backgroundColor: Colors.transparent,
                  onWebViewCreated: (controller) {
                    _webViewController = controller;
                  },
                ),
              ),
            ),

            // Panel inferior - Solo mostrar selector si hay múltiples modelos
            if (_hasMultipleModels)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    top: BorderSide(
                      color: AppColors.goldDark.withValues(alpha: 0.2),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 14, left: 20, right: 20, bottom: 8),
                      child: Row(
                        children: [
                          Icon(Icons.layers_outlined, size: 13,
                              color: AppColors.textMuted.withValues(alpha: 0.5)),
                          const SizedBox(width: 6),
                          Text(
                            'VERSIONES DEL MODELO',
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 1.6,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textMuted.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Lista de versiones
                    ...List.generate(_models.length, (i) {
                      final isActive = i == _selectedIndex;
                      final label = _labels.length > i ? _labels[i] : 'Versión ${i + 1}';

                      return GestureDetector(
                        onTap: () => _selectModel(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: isActive
                                ? _accentColor.withValues(alpha: 0.10)
                                : AppColors.background,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isActive
                                  ? _accentColor.withValues(alpha: 0.45)
                                  : AppColors.divider.withValues(alpha: 0.25),
                              width: isActive ? 1.5 : 0.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isActive
                                      ? _accentColor.withValues(alpha: 0.18)
                                      : AppColors.surface,
                                  border: Border.all(
                                    color: isActive
                                        ? _accentColor.withValues(alpha: 0.5)
                                        : AppColors.divider.withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${i + 1}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: isActive ? _accentTextColor : AppColors.textMuted,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                                    color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isActive ? _accentColor : Colors.transparent,
                                  border: Border.all(
                                    color: isActive
                                        ? _accentColor
                                        : AppColors.divider.withValues(alpha: 0.35),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

            // Botón AR (siempre visible)
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border(
                  top: BorderSide(
                    color: AppColors.goldDark.withValues(alpha: 0.2),
                    width: 0.5,
                  ),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _activateAR,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.view_in_ar,
                            size: 20,
                            color: AppColors.gold,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _hasMultipleModels 
                                ? 'VER EN TU SALA (AR)' 
                                : 'VER EN REALIDAD AUMENTADA',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                              color: AppColors.gold,
                            ),
                          ),
                        ],
                      ),
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