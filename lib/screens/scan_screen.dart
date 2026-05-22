import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:ar_historia/api/ai_tts.dart';

import '../theme/app_theme.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final AudioPlayer _player = AudioPlayer();
  final String servidorTTS = Mittsservidor.link;

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

  @override
void dispose() {
  _player.stop();
  _player.release();
  _player.dispose();

  super.dispose();
}

  void _openCameraIfNeeded() {
    if (!_hasRequestedCamera) {
      _hasRequestedCamera = true;
      _pickImage();
    }
  }

  Future<String> getLocalAudioPath(String audioFilename) async {
  final appDir = await getApplicationDocumentsDirectory();

  return "${appDir.path}/tts/$audioFilename";
  }
  Future<String?> descargarYCachearAudio(String audioFilename) async {
  try {
    final localPath = await getLocalAudioPath(audioFilename);

    final localFile = File(localPath);

    // Ya existe
    if (await localFile.exists()) {
      print("✅ Audio ya cacheado");

      return localPath;
    }

    // Descargar
    final audioUrl = "$servidorTTS/outputs/$audioFilename";

    final response = await http.get(Uri.parse(audioUrl));

    if (response.statusCode != 200) {
      print("❌ Error descargando audio");

      return null;
    }

    // Crear carpeta
    await localFile.parent.create(recursive: true);

    // Guardar
    await localFile.writeAsBytes(response.bodyBytes);

    print("✅ Audio guardado");

    return localPath;
  } catch (e) {
    print("❌ Error cacheando audio: $e");

    return null;
  }
}

  Future<String?> generarAudioEnServidor(String texto) async {
  try {
    final response = await http.post(
      Uri.parse("$servidorTTS/tts"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "text": texto,
      }),
    );

    if (response.statusCode != 200) {
      print("❌ Error TTS");

      return null;
    }

    final data = jsonDecode(response.body);

    final String audioFilename = data["audio_filename"];

    print("🎵 Audio generado: $audioFilename");

    return audioFilename;
  } catch (e) {
    print("❌ Error generando audio: $e");

    return null;
  }
}

Future<void> reproducirAudio(String audioFilename) async {
  try {
    final localPath =
        await descargarYCachearAudio(audioFilename);

    if (localPath == null) return;

    await _player.stop();

    await _player.play(
      DeviceFileSource(localPath),
    );

  } catch (e) {
    print("❌ Error reproduciendo audio: $e");
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

Actúa como arqueólogo, antropólogo e historiador del patrimonio cultural mexicano.

Identifica la posible civilización, cultura o periodo histórico de la imagen.

Analiza:

- Símbolos
- Figuras humanas o animales
- Geometría
- Pigmentos
- Técnica artística
- Material visible
- Estado de conservación

Responde SOLO:

🏺 Evidencia:
🌎 Región cultural:
🏛 Cultura probable:
📅 Periodo:
🎨 Técnica:
🔍 Evidencias clave:
⚠ Alternativa:
⭐ Confianza: Alta / Media / Baja

Máximo 2 líneas por apartado.

Si no hay suficiente evidencia escribe:

"identificación no concluyente"

No inventes datos.
No agregues introducción.
No agradezcas.
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
        final textoLimpio =
    limpiarTextoParaTTS(result);

final audioFilename =
    await generarAudioEnServidor(textoLimpio);

if (audioFilename != null) {
  await reproducirAudio(audioFilename);
}
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

  String limpiarTextoParaTTS(String texto) {

  // Quitar emojis y símbolos raros
  texto = texto.replaceAll(
    RegExp(r'[^\w\sáéíóúÁÉÍÓÚñÑ.,:()-]'),
    '',
  );

  // Quitar múltiples saltos
  texto = texto.replaceAll(RegExp(r'\n+'), '. ');

  // Quitar espacios dobles
  texto = texto.replaceAll(RegExp(r'\s+'), ' ');

  return texto.trim();
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