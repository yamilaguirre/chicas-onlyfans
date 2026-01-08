import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/atoms/custom_back_button.dart';
import '../../../../core/widgets/atoms/primary_button.dart';
import '../../../../core/utils/image_picker_helper.dart';
import 'follow_profiles_screen.dart';

class ProfileConfirmationScreen extends StatefulWidget {
  final String phoneNumber;
  final String name;
  final String birthDate;

  const ProfileConfirmationScreen({
    super.key,
    required this.phoneNumber,
    required this.name,
    required this.birthDate,
  });

  @override
  State<ProfileConfirmationScreen> createState() => _ProfileConfirmationScreenState();
}

class _ProfileConfirmationScreenState extends State<ProfileConfirmationScreen> {
  Uint8List? _profileImage;
  final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _phoneController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await ImagePickerHelper.showImageSourceDialog(context);
    if (image != null) {
      setState(() {
        _profileImage = image;
      });
    }
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _handleContinue() {
    // Navegar a la pantalla de seguir perfiles
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FollowProfilesScreen(
          phoneNumber: widget.phoneNumber,
          name: widget.name,
          birthDate: widget.birthDate,
        ),
      ),
    );
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
                  AppStrings.confirmProfileTitle,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
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
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 3,
                            ),
                            color: AppColors.background,
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
                                  size: 60,
                                  color: AppColors.textHint,
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
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: AppColors.textWhite,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),

                // Botón editar
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _toggleEdit,
                    icon: Icon(
                      _isEditing ? Icons.check : Icons.edit,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    label: Text(
                      _isEditing ? 'Guardar' : 'Editar',
                      style: const TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),

                // Información del perfil
                _buildInfoField(widget.phoneNumber, editable: false),
                const SizedBox(height: 16),
                _buildInfoField(widget.name, editable: false),
                const SizedBox(height: 16),
                _buildInfoField(widget.birthDate, icon: Icons.calendar_today, editable: false),
                const SizedBox(height: 16),
                _buildEditableField(
                  controller: _emailController,
                  hint: 'E-mail',
                  icon: Icons.email,
                ),
                const SizedBox(height: 16),
                _buildEditableField(
                  controller: _phoneController,
                  hint: 'Teléfono',
                  icon: Icons.phone,
                  prefix: '🇧🇴  ',
                ),

                const SizedBox(height: 32),

                // ------------------ BOTÓN CONTINUAR ------------------
                PrimaryButton(
                  text: AppStrings.confirmButton,
                  onPressed: _handleContinue,
    

                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField(String text, {IconData? icon, bool editable = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (icon != null)
            Icon(
              icon,
              color: AppColors.textHint,
              size: 20,
            ),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    String? prefix,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (prefix != null)
            Text(
              prefix,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
          Expanded(
            child: TextFormField(
              controller: controller,
              enabled: _isEditing,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (icon != null)
            Icon(
              icon,
              color: AppColors.textHint,
              size: 20,
            ),
        ],
      ),
    );
  }
}
