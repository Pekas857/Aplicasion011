import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.gold),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  color: AppColors.gold.withValues(alpha: 0.9),
                  size: 26,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Ajustes',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Cuenta'),
          const SizedBox(height: 12),
          _buildTile(
            icon: Icons.person_outline,
            title: 'Perfil',
            subtitle: 'Gestiona tu información y acceso',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Preferencias'),
          const SizedBox(height: 12),
          _buildTile(
            icon: Icons.language,
            title: 'Idioma',
            subtitle: 'Selecciona el idioma de la aplicación',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _buildTile(
            icon: Icons.notifications_none,
            title: 'Notificaciones',
            subtitle: 'Configura alertas y recordatorios',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Acerca de'),
          const SizedBox(height: 12),
          _buildTile(
            icon: Icons.info_outline,
            title: 'Información',
            subtitle: 'Versiones y detalles de la aplicación',
            onTap: () {},
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
