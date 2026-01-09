import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/atoms/custom_back_button.dart';
import '../../../../core/widgets/atoms/primary_button.dart';
import 'follow_profiles_screen.dart';

class ProfileConfirmationScreen extends StatefulWidget {
  final String phoneNumber;
  final String name;
  final DateTime birthDate;

  const ProfileConfirmationScreen({
    super.key,
    required this.phoneNumber,
    required this.name,
    required this.birthDate,
  });

  @override
  State<ProfileConfirmationScreen> createState() =>
      _ProfileConfirmationScreenState();
}

class _ProfileConfirmationScreenState extends State<ProfileConfirmationScreen> {
  Uint8List? _profileImage;
  final ImagePicker _picker = ImagePicker();
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _birthDateController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _usernameController = TextEditingController(
      text: 'anonimo${DateTime.now().millisecondsSinceEpoch % 1000}',
    );
    _birthDateController = TextEditingController(
      text:
          '${widget.birthDate.day.toString().padLeft(2, '0')}/${widget.birthDate.month.toString().padLeft(2, '0')}/${widget.birthDate.year}',
    );
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _profileImage = bytes;
      });
    }
  }

  void _handleContinue() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FollowProfilesScreen(
          phoneNumber: widget.phoneNumber,
          name: _nameController.text,
          birthDate: _birthDateController.text,
        ),
      ),
    );
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Indicador de progreso completo
                Row(
                  children: List.generate(4, (index) {
                    return Expanded(
                      child: Container(
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 32),

                // Título
                const Text(
                  'Confirma tu perfil 123',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 48),

                // Foto de perfil
                Center(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 4,
                            ),
                            color: const Color(0xFFE0E0E0),
                            image: _profileImage != null
                                ? DecorationImage(
                                    image: MemoryImage(_profileImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _profileImage == null
                              ? const Icon(
                                  Icons.person,
                                  size: 70,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: AppColors.textWhite,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Nombre completo - EDITABLE
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Nombre completo',
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.all(18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Nombre de usuario - EDITABLE
                TextFormField(
                  controller: _usernameController,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Nombre de usuario',
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.all(18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Fecha de nacimiento - EDITABLE
                TextFormField(
                  controller: _birthDateController,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Fecha de nacimiento',
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                    contentPadding: const EdgeInsets.all(18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Email - EDITABLE
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'E-mail',
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    contentPadding: const EdgeInsets.all(18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                _buildInfoField(
                  label: widget.phoneNumber,
                  value: widget.phoneNumber,
                  icon: Icons.phone_outlined,
                  prefix: '🇧🇴  ',
                ),

                const SizedBox(height: 48),

                // Botón continuar
                PrimaryButton(text: 'CONTINUAR', onPressed: _handleContinue),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField({
    required String label,
    required String value,
    IconData? icon,
    String? prefix,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (prefix != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                prefix,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          if (icon != null) Icon(icon, color: AppColors.textHint, size: 22),
        ],
      ),
    );
  }
}
