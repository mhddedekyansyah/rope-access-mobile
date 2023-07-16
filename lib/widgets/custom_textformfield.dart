import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rope_access/theme.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.assetIcon,
    this.hintText,
    required this.title,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  final String label;
  final String title;
  final bool obscureText;
  final TextEditingController controller;
  final String? assetIcon;
  final String? hintText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.primaryStyle.copyWith(
              fontSize: 16,
              fontWeight: AppFontWeight.medium,
              color: Colors.black),
        ),
        const SizedBox(height: 5),
        const SizedBox(
          width: 10,
        ),
        TextFormField(
          controller: controller,
          cursorColor: AppColors.purple,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.primaryStyle.copyWith(color: Colors.grey),
            contentPadding: const EdgeInsets.all(15),
            filled: true,
            fillColor: AppColors.secondary,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            errorStyle: const TextStyle(color: AppColors.red),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return '$label wajib diisi';
            }

            if (label.toLowerCase() == 'email' &&
                !EmailValidator.validate(value)) {
              return '$label tidak valid';
            }

            if (title.toLowerCase() == 'signup' &&
                label.toLowerCase() == 'password' &&
                value.length < 6) {
              return '$label minimal 6 karakter';
            }
            return null;
          },
        ),
      ],
    );
  }
}
