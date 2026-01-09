import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/widgets/atoms/custom_button.dart';
import 'phone_number_screen.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A148C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // Logo o título de la app
              const Text(
                'ChicasApp',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 60),

              // Botón de Google
              _SocialButton(
                text: 'INICIAR SESIÓN CON GOOGLE',
                icon: Icons.g_mobiledata,
                backgroundColor: Colors.white,
                textColor: Colors.black87,
                onPressed: () {
                  // TODO: Implementar Google Sign In
                },
              ),

              const SizedBox(height: 16),

              // Botón de Apple
              _SocialButton(
                text: 'INICIAR SESIÓN CON APPLE',
                icon: Icons.apple,
                backgroundColor: Colors.white,
                textColor: Colors.black87,
                onPressed: () {
                  // TODO: Implementar Apple Sign In
                },
              ),

              const SizedBox(height: 16),

              // Botón de Número de Teléfono
              _SocialButton(
                text: 'INICIAR SESIÓN NÚMERO CEL',
                icon: Icons.phone_android,
                backgroundColor: Colors.white,
                textColor: Colors.black87,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PhoneNumberScreen(),
                    ),
                  );
                },
              ),

              const Spacer(),

              // Texto de registro
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PhoneNumberScreen(),
                    ),
                  );
                },
                child: const Text(
                  '¿No tienes cuenta? Regístrate',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: textColor),
      label: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 0,
      ),
    );
  }
}
