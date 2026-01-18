import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/theme/app_colors.dart';

/// Pantalla que permite al usuario seleccionar su tipo
/// ('male' o 'female') después de un login exitoso.
class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _selectRole(String selectedType) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Modular.to.navigate('/auth/sign-in');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Actualizar el tipo de usuario en Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
            'type': selectedType,
            'userType': selectedType,
            'updatedAt': FieldValue.serverTimestamp(),
          });

      if (!mounted) return;

      // Navegar según el tipo seleccionado
      if (selectedType == 'female') {
        Modular.to.navigate('/female/contenido');
      } else {
        Modular.to.navigate('/male/home');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error al guardar el tipo: $e';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _handleLogout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Modular.to.navigate('/auth/sign-in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _handleLogout();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF4A148C),
        body: SafeArea(
          child: Stack(
            children: [
              // Fondo decorativo
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF4A148C),
                        const Color(0xFF6A1B9A),
                        const Color(0xFF8E24AA).withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ),

              // Contenido principal
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Logo o título
                    const SizedBox(height: 40),
                    const Text(
                      'ChicasApp',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const Spacer(),

                    // Contenido de selección
                    Column(
                      children: [
                        const Text(
                          '¿Qué tipo de cuenta deseas usar?',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Selecciona el tipo de cuenta que mejor se adapte a ti',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),

                        // Botón para Creadora
                        _RoleCard(
                          title: 'Creadora de Contenido',
                          description: 'Crea y comparte contenido exclusivo',
                          icon: Icons.camera_alt,
                          color: const Color(0xFFE991C5),
                          onTap: _isLoading
                              ? null
                              : () => _selectRole('female'),
                        ),

                        const SizedBox(height: 24),

                        // Botón para Suscriptor
                        _RoleCard(
                          title: 'Suscriptor',
                          description: 'Descubre y apoya contenido exclusivo',
                          icon: Icons.people,
                          color: Colors.white,
                          onTap: _isLoading ? null : () => _selectRole('male'),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Botón de cerrar sesión
                    TextButton.icon(
                      onPressed: _isLoading ? null : _handleLogout,
                      icon: const Icon(Icons.logout, color: Colors.white70),
                      label: const Text(
                        'Cerrar Sesión',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Loading overlay
              if (_isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _RoleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color == Colors.white
                      ? const Color(0xFF4A148C)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color == Colors.white
                      ? Colors.white
                      : const Color(0xFF4A148C),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color == Colors.white
                            ? const Color(0xFF4A148C)
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: color == Colors.white
                            ? const Color(0xFF4A148C).withOpacity(0.7)
                            : Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
