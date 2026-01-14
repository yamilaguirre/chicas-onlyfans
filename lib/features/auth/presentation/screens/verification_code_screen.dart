import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/atoms/custom_back_button.dart';
import '../../../../core/widgets/atoms/primary_button.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/enums/user_type.dart';
import '../controllers/auth_controller.dart';
import '../controllers/auth_state.dart';

class VerificationCodeScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final UserType userType;
  final bool isLogin;

  const VerificationCodeScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    this.userType = UserType.male,
    this.isLogin = false,
  });

  @override
  ConsumerState<VerificationCodeScreen> createState() =>
      _VerificationCodeScreenState();
}

class _VerificationCodeScreenState
    extends ConsumerState<VerificationCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _codeController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _codeController.text.length == 6;
    });
  }

  void _handleContinue() async {
    if (_formKey.currentState!.validate() && !_isLoading) {
      setState(() {
        _isLoading = true;
      });

      try {
        await ref
            .read(authControllerProvider.notifier)
            .verifyPhoneOTP(
              verificationId: widget.verificationId,
              otp: _codeController.text,
              phoneNumber: widget.phoneNumber,
            );

        if (!mounted) return;

        // Verificar si es login o registro
        if (widget.isLogin) {
          // LOGIN: Verificar si el usuario existe en Firestore
          final authState = ref.read(authControllerProvider);

          if (authState is AuthStateAuthenticated) {
            final userId = authState.user.id;

            // Obtener datos del usuario de Firestore
            final userDoc = await FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .get();

            if (!mounted) return;

            if (userDoc.exists) {
              // Usuario existe, obtener su tipo
              final userData = userDoc.data()!;
              final userTypeStr = userData['userType'] as String?;
              final userType = userTypeStr == 'female'
                  ? UserType.female
                  : UserType.male;

              // Redirigir según tipo de usuario - LOGIN EXITOSO
              if (userType == UserType.female) {
                // Creadora -> Contenido Screen
                Modular.to.navigate('/female/contenido');
              } else {
                // Hombre/Suscriptor -> Home Screen
                Modular.to.navigate('/male/home');
              }
            } else {
              // Usuario no existe en Firestore, eliminar de Auth y mostrar error
              setState(() {
                _isLoading = false;
              });

              await ref.read(authControllerProvider.notifier).logout();

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Usuario no encontrado. Por favor regístrate primero.',
                  ),
                  backgroundColor: AppColors.error,
                  duration: Duration(seconds: 4),
                ),
              );

              // Volver a la pantalla de sign in
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          }
        } else {
          // REGISTRO: Continuar al flujo de crear perfil
          setState(() {
            _isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Código verificado correctamente'),
              backgroundColor: AppColors.success,
            ),
          );

          Modular.to.pushNamed(
            '/auth/name',
            arguments: {
              'phoneNumber': widget.phoneNumber,
              'userType': widget.userType,
            },
          );
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textWhite,
      appBar: AppBar(
        leading: CustomBackButton(color: AppColors.textSecondary),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),

                // Título
                const Text(
                  AppStrings.codeTitle,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 16),

                // Mensaje con número de teléfono
                Text(
                  'Código enviado a +591 ${widget.phoneNumber}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 32),

                // Campo de código con indicadores
                Column(
                  children: [
                    TextFormField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      autofocus: true,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 16,
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: const InputDecoration(
                        hintText: '000000',
                        counterText: '',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: Validators.validateCode,
                      onChanged: (value) => _validateForm(),
                    ),

                    const SizedBox(height: 16),

                    // Indicadores de progreso
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: index < _codeController.text.length
                                ? AppColors.primary
                                : AppColors.textHint,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      }),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Botón reenviar código
                Center(
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Código reenviado'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                    child: Text(
                      '¿No recibiste el código? Reenviar',
                      style: TextStyle(color: AppColors.primary, fontSize: 14),
                    ),
                  ),
                ),

                const Spacer(),

                // Botón continuar
                PrimaryButton(
                  text: _isLoading
                      ? 'Verificando...'
                      : AppStrings.continueButton,
                  onPressed: (_isButtonEnabled && !_isLoading)
                      ? _handleContinue
                      : null,
                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
