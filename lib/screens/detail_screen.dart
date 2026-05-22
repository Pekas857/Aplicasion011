import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../theme/app_theme.dart';
import '../models/artifact.dart';
import '../models/picture.dart';
import 'ar_view_screen.dart';

String _previewModelPath(ArtifactCategory category) {
  switch (category) {
    case ArtifactCategory.maya:
      return 'assets/models/mascara_pakal.glb';
    case ArtifactCategory.mexica:
      return 'assets/models/mexica_antes.glb';
    case ArtifactCategory.olmeca:
      return 'assets/models/olmeca_antes.glb';
    case ArtifactCategory.pinturasRupestres:
      return 'assets/models/rupestre_antes.glb';
    case ArtifactCategory.piramides:
      return 'assets/models/piramide_antes.glb';
  }
}

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

  String get _historyText {
    switch (widget.artifact.category) {
      case ArtifactCategory.maya:
        return 'Encontrada en el Templo de las Inscripciones en Palenque, México. '
            'Esta icónica máscara está hecha de 340 teselas de jade verde imperial, '
            'dos placas de concha para los ojos y obsidiana pulida para las pupilas. '
            'Representa el rostro reconstruido del rey para su viaje al inframundo '
            'mesoamericano (Xibalbá), simbolizando la renovación y la inmortalidad '
            'como el Dios del Maíz. Al escanearla, la tecnología holográfica la '
            'restaura digitalmente mostrando el brillo original de sus joyas precolombinas.';
      case ArtifactCategory.mexica:
        return 'La Piedra del Sol es un monolito basáltico de 3.6 metros de diámetro '
            'y 24 toneladas de peso. Fue labrada durante el reinado de Moctezuma II '
            'alrededor de 1479. Representa la cosmogonía mexica con los cinco soles '
            'o eras del mundo. En el centro se encuentra Tonatiuh, el dios solar, '
            'rodeado por los glifos de los cuatro soles anteriores y los 20 días '
            'del calendario sagrado.';
      case ArtifactCategory.olmeca:
        return 'Las Cabezas Colosales olmecas son monumentales esculturas de basalto '
            'que representan rostros humanos con rasgos individualizados. La Cabeza '
            'Colosal No. 1 fue descubierta en San Lorenzo Tenochtitlán, Veracruz. '
            'Mide aproximadamente 2.85 metros de altura y pesa alrededor de 25 '
            'toneladas. Se cree que representan a gobernantes olmecas, cada una '
            'con características faciales únicas y elaborados tocados.';
      case ArtifactCategory.pinturasRupestres:
        return 'Las pinturas rupestres representan los primeros intentos del ser humano '
            'de narrar su entorno y sus creencias. Estas obras se encuentran en cuevas '
            'como la Cueva de las Manos y datan de miles de años antes de Cristo. '
            'A través de pigmentos naturales y manos en negativo, reflejan la vida '
            'y el arte de las sociedades prehistóricas de la región.';
      case ArtifactCategory.piramides:
        return 'Las pirámides mesoamericanas son monumentos arquitectónicos de gran '
            'escala construidos por diversas civilizaciones como la maya, la azteca '
            'y la teotihuacana. Funcionaban como centros ceremoniales, tumbas reales '
            'y observatorios astronómicos. La Pirámide del Sol en Teotihuacán es una '
            'de las más grandes del mundo, con una base de 225 metros por lado y '
            '65 metros de altura.';
    }
  }

  String get _discoveryText {
    switch (widget.artifact.category) {
      case ArtifactCategory.maya:
        return 'Descubierta el 15 de junio de 1952 por el arqueólogo mexicano '
            'Alberto Ruz Lhuillier en la cripta funeraria del Templo de las '
            'Inscripciones en Palenque, Chiapas. Fue uno de los hallazgos más '
            'importantes de la arqueología mesoamericana, revelando que las '
            'pirámides mayas también servían como tumbas reales, similar a las '
            'pirámides egipcias.';
      case ArtifactCategory.mexica:
        return 'Descubierta el 17 de diciembre de 1790 durante las obras de '
            'nivelación de la Plaza Mayor de la Ciudad de México. Fue encontrada '
            'a unos 40 centímetros de profundidad junto con la estatua de '
            'Coatlicue. Actualmente se exhibe en la Sala Mexica del Museo '
            'Nacional de Antropología.';
      case ArtifactCategory.olmeca:
        return 'La Cabeza Colosal No. 1 fue descubierta en 1862 por el viajero '
            'José María Melgar y Serrano en la hacienda de Hueyapan, en el '
            'municipio de Texistepec, Veracruz. Las investigaciones posteriores '
            'de Matthew Stirling en 1938-1946 revelaron la importancia de la '
            'civilización olmeca como la cultura madre de Mesoamérica.';
      case ArtifactCategory.pinturasRupestres:
        return 'Las pinturas de la Cueva de las Manos fueron registradas por '
            'arqueólogos en el siglo XX como uno de los ejemplos más antiguos '
            'del arte rupestre americano. Se hicieron con pigmentos naturales '
            'aplicados directamente sobre las paredes de la cueva, creando un '
            'testimonio visual de la vida de los primeros habitantes de la región.';
      case ArtifactCategory.piramides:
        return 'Las grandes pirámides de Teotihuacán fueron redescubiertas y '
            'estudiadas sistemáticamente a partir del siglo XIX. Las excavaciones '
            'arqueológicas del siglo XX revelaron que la ciudad de Teotihuacán '
            'fue una de las más grandes del mundo antiguo, con una población '
            'estimada de 100,000 a 200,000 habitantes en su apogeo alrededor '
            'del año 450 d.C.';
    }
  }

  String get _period {
    switch (widget.artifact.category) {
      case ArtifactCategory.maya:
        return 'Período Clásico (603 – 683 d.C.)';
      case ArtifactCategory.mexica:
        return 'Período Posclásico (1479 d.C.)';
      case ArtifactCategory.olmeca:
        return 'Período Preclásico (1200 – 900 a.C.)';
      case ArtifactCategory.pinturasRupestres:
        return 'Arte prehistórico (hasta 10,000 a.C.)';
      case ArtifactCategory.piramides:
        return 'Período Clásico (100 – 650 d.C.)';
    }
  }

  String get _discovered {
    switch (widget.artifact.category) {
      case ArtifactCategory.maya:
        return 'Descubierto en 1952';
      case ArtifactCategory.mexica:
        return 'Descubierto en 1790';
      case ArtifactCategory.olmeca:
        return 'Descubierto en 1862';
      case ArtifactCategory.pinturasRupestres:
        return 'Descubierto en 10,000 a.C.';
      case ArtifactCategory.piramides:
        return 'Explorado s. XIX';
    }
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

                    // ── Preview 3D girando ───────────────────────
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
                            ModelViewer(
                              src: _previewModelPath(widget.artifact.category),
                              alt: widget.artifact.name,
                              autoRotate: true,
                              autoRotateDelay: 0,
                              rotationPerSecond: '20deg',
                              cameraControls: false,
                              disableZoom: true,
                              ar: false,
                              backgroundColor: Colors.transparent,
                              disableTap: true,
                            ),
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
                              widget.artifact.civilization.split(' ').first,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                                color: _tagTextColor,
                              ),
                            ),
                          ),
                          Text(
                            _discovered,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary.withValues(alpha: 0.7),
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
                        widget.artifact.name,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        _period,
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
                            child: Text(
                              _historyText,
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColors.textSecondary,
                                height: 1.7,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              _discoveryText,
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColors.textSecondary,
                                height: 1.7,
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