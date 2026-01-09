import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/atoms/custom_back_button.dart';
import '../../../../core/widgets/molecules/social_button.dart';
import 'error_screen.dart';
import 'login_with_password_screen.dart';
import 'phone_number_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            // Header con back button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: CustomBackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),

            const Spacer(),

            // Título
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Iniciar sesión',
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Botones de login
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  SocialButton(
                    text: AppStrings.signInWithGoogle,
                    icon: Icons.g_mobiledata,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ErrorScreen(),
                        ),
                      );
                    },
                    backgroundColor: AppColors.textWhite,
                    textColor: AppColors.textPrimary,
                  ),

                  const SizedBox(height: 16),

                  SocialButton(
                    text: AppStrings.signInWithApple,
                    icon: Icons.apple,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ErrorScreen(),
                        ),
                      );
                    },
                    backgroundColor: AppColors.textWhite,
                    textColor: AppColors.textPrimary,
                  ),

                  const SizedBox(height: 16),

                  SocialButton(
                    text: 'Continuar con celular',
                    icon: Icons.phone_android,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginWithPasswordScreen(),
                        ),
                      );
                    },
                    backgroundColor: AppColors.textWhite,
                    textColor: AppColors.textPrimary,
                  ),

                  const SizedBox(height: 24),

                  // Link de registro
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿No tienes cuenta?',
                        style: TextStyle(
                          color: AppColors.textWhite.withValues(alpha: 0.8),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PhoneNumberScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Regístrate',
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
