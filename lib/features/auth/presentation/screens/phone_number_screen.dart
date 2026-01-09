import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/atoms/custom_back_button.dart';
import '../../../../core/widgets/atoms/primary_button.dart';
import '../../../../core/widgets/molecules/phone_input_field.dart';
import 'verification_code_screen.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _countryController = TextEditingController(
    text: 'BOL',
  );
  final TextEditingController _phoneController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _countryController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _phoneController.text.length >= 8;
    });
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      // Simular envío de código
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Código enviado a ${_phoneController.text}'),
          backgroundColor: AppColors.success,
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationCodeScreen(
            phoneNumber: '${_countryController.text} ${_phoneController.text}',
          ),
        ),
      );
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
                  AppStrings.phoneTitle,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 32),

                // Campo de teléfono con validación
                PhoneInputField(
                  countryController: _countryController,
                  phoneController: _phoneController,
                  onPhoneChanged: (value) => _validateForm(),
                ),

                const SizedBox(height: 16),

                // Mensaje
                Text(
                  AppStrings.codeMessage,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),

                const Spacer(),

                // Botón continuar
                PrimaryButton(
                  text: AppStrings.continueButton,
                  onPressed: _isButtonEnabled ? _handleContinue : null,
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
