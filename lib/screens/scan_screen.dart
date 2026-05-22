import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../theme/app_theme.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;
  String _analysisResult = '';
  bool _isAnalyzing = false;
  bool _hasRequestedCamera = false;

  static const String _openRouterApiKey = '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';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openCameraIfNeeded();
    });
  }

  void _openCameraIfNeeded() {
    if (!_hasRequestedCamera) {
      _hasRequestedCamera = true;
      _pickImage();
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (pickedImage == null) return;

    setState(() {
      _imageFile = pickedImage;
      _analysisResult = '';
    });
  }

  Future<void> _analyzeImage() async {
    if (_imageFile == null) return;

    setState(() {
      _isAnalyzing = true;
      _analysisResult = '';
    });

    try {
      final imageBytes = await File(_imageFile!.path).readAsBytes();
      final base64Image = base64Encode(imageBytes);

      final response = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $_openRouterApiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://ar-historia.app',
          'X-Title': 'NeuroVibe',
        },
        body: jsonEncode({
          "model": "google/gemini-2.5-flash",
          'messages': [
            {
              'role': 'user',
              'content': [
                {
                  'type': 'text',
                  'text': '''
Actúa como arqueólogo, antropólogo, historiador del arte y especialista en patrimonio cultural mexicano.

Tu tarea es identificar a qué civilización, cultura o periodo histórico podría pertenecer esta imagen.

Analiza visualmente:

- Símbolos
- Figuras humanas
- Figuras animales
- Geometría
- Pigmentos visibles
- Técnica de elaboración
- Material de la superficie (roca, muro, cerámica, piedra)
- Estado de conservación
- Distribución espacial de elementos

Debes responder EXACTAMENTE en este formato:

🏺 Tipo de evidencia:
(Pintura rupestre, petrograbado, mural, códice, escultura, etc.)

🌎 Región cultural probable:
(Mesoamérica, Aridoamérica, Oasisamérica u otra)

🏛 Civilización o cultura probable:
(Maya, Mexica, Teotihuacana, Zapoteca, Mixteca, Tolteca, Olmeca, Totonaca, Huichol, Seri, grupos cazadores-recolectores, etc.)

📅 Periodo histórico probable:
(Preclásico, Clásico, Posclásico, Colonial, Prehistórico, etc.)

🎨 Técnica artística observada:
(Pigmento mineral, carbón, grabado, pintura rupestre, relieve, etc.)

🔍 Evidencias visuales:
(Explica qué elementos de la imagen apoyan la hipótesis)

⚠ Posibles alternativas:
(Otras culturas o periodos posibles)

⭐ Contexto histórico:
(Importancia cultural o arqueológica)

Si NO puedes identificar con certeza la civilización, NO inventes.

Indica:
"identificación no concluyente"

y explica qué evidencia adicional sería necesaria.

No escribas introducciones.
No agradezcas.
Ve directo al análisis técnico.
'''
                },
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': 'data:image/jpeg;base64,$base64Image',
                  }
                }
              ]
            }
          ],
          'temperature': 0.4,
          'max_tokens': 1000,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final result = data['choices'][0]['message']['content'];

        setState(() {
          _analysisResult = result;
        });
      } else {
        setState(() {
          _analysisResult =
              'Error ${response.statusCode}\n\n${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _analysisResult = 'No se pudo analizar la imagen.\n\nError: $e';
      });
    } finally {
      setState(() {
        _isAnalyzing = false;
      });
    }
  }

  Widget _buildActionButton() {
    if (_imageFile == null) {
      return ElevatedButton.icon(
        icon: const Icon(Icons.camera_alt),
        label: const Text('Tomar foto'),
        onPressed: _pickImage,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.refresh),
          label: const Text('Volver a tomar foto'),
          onPressed: _isAnalyzing ? null : _pickImage,
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          icon: const Icon(Icons.send),
          label: const Text('Enviar a IA'),
          onPressed: _isAnalyzing ? null : _analyzeImage,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Escanear'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Usa la cámara para tomar una foto de la pintura y recibir información mediante IA.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

            if (_imageFile != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.divider.withValues(alpha: 0.5),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    File(_imageFile!.path),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  ),
                ),
              )
            else
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.divider.withValues(alpha: 0.4),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.photo_camera,
                    size: 72,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            _buildActionButton(),

            const SizedBox(height: 24),

            if (_isAnalyzing)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (_analysisResult.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                constraints: const BoxConstraints(maxHeight: 240),
                child: SingleChildScrollView(
                  child: Text(
                    _analysisResult,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textPrimary,
                      height: 1.5,
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