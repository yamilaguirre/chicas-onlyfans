import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController? countryController;
  final TextEditingController? phoneController;
  final void Function(String)? onCountryChanged;
  final void Function(String)? onPhoneChanged;

  const PhoneInputField({
    super.key,
    this.countryController,
    this.phoneController,
    this.onCountryChanged,
    this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Country code field
        SizedBox(
          width: 100,
          child: TextFormField(
            controller: countryController,
            onChanged: onCountryChanged,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: const InputDecoration(
              hintText: 'BOL',
              counterText: '',
            ),
            maxLength: 5,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Phone number field
        Expanded(
          child: TextFormField(
            controller: phoneController,
            onChanged: onPhoneChanged,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            maxLength: 15,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s]')),
              LengthLimitingTextInputFormatter(15),
            ],
            decoration: const InputDecoration(
              hintText: '+5921 000000000',
              counterText: '',
            ),
          ),
        ),
      ],
    );
  }
}
