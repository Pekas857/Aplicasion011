import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    final pickedImage = await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (pickedImage == null) {
      return;
    }

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
      // TODO: Reemplaza este bloque con la llamada real a tu servicio de IA.
      await Future.delayed(const Duration(seconds: 2));
      final file = File(_imageFile!.path);
      final size = await file.length();

      setState(() {
        _analysisResult =
            'Imagen analizada con éxito. Tamaño: ${size ~/ 1024} KB.\n' 
            'Describe la pintura, el estilo y posibles detalles históricos basados en la foto.';
      });
    } catch (e) {
      setState(() {
        _analysisResult = 'No se pudo analizar la imagen. Intenta de nuevo.';
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
          onPressed: _pickImage,
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
                  border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
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
                  border: Border.all(color: AppColors.divider.withValues(alpha: 0.4)),
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
                child: Text(
                  _analysisResult,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
