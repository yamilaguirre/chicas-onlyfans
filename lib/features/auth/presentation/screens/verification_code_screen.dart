import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/atoms/custom_back_button.dart';
import '../../../../core/widgets/atoms/primary_button.dart';
import '../../../../core/utils/validators.dart';
import 'name_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String phoneNumber;
  
  const VerificationCodeScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  bool _isButtonEnabled = false;

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

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      // Simular verificación exitosa
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Código verificado correctamente'),
          backgroundColor: AppColors.success,
        ),
      );
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NameScreen(phoneNumber: widget.phoneNumber),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textWhite,
      appBar: AppBar(
        leading: CustomBackButton(
          color: AppColors.textSecondary,
        ),
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
                  'Código enviado a ${widget.phoneNumber}',
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
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
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
