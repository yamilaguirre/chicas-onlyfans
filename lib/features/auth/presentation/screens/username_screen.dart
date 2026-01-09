import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/widgets/atoms/custom_button.dart';
import '../../../../../core/widgets/atoms/custom_text_field.dart';
import 'birth_date_screen.dart';

class UsernameScreen extends ConsumerStatefulWidget {
  final String phoneNumber;

  const UsernameScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends ConsumerState<UsernameScreen> {
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BirthDateScreen(
          phoneNumber: widget.phoneNumber,
          name: _usernameController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                const Text(
                  'Mi nombre\nes o Apodo',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Test',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),

                const SizedBox(height: 40),

                CustomTextField(
                  controller: _usernameController,
                  hintText: 'Nombre de usuario',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa tu nombre de usuario';
                    }
                    if (value.length < 3) {
                      return 'Mínimo 3 caracteres';
                    }
                    return null;
                  },
                ),

                const Spacer(),

                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'CONFIRMAR',
                        onPressed: _continue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        text: 'GENERAR',
                        backgroundColor: Colors.white,
                        textColor: const Color(0xFF4A148C),
                        onPressed: () {
                          // Generar nombre aleatorio
                          _usernameController.text =
                              'User${DateTime.now().millisecondsSinceEpoch % 10000}';
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
