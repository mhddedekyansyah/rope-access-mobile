import 'package:flutter/material.dart';
import 'package:rope_access/theme.dart';

class CustomFormAddressField extends StatelessWidget {
  const CustomFormAddressField({
    Key? key,
    required this.label,
    required this.controller,
    required this.assetIcon,
    required this.hintText,
    required this.title,
    this.maxLines,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  final String label;
  final String title;

  final TextEditingController controller;
  final String assetIcon;
  final String hintText;
  final int? maxLines;
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
          style: AppTextStyle.primaryStyle
              .copyWith(fontSize: 16, fontWeight: AppFontWeight.medium),
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
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.secondaryStyle.copyWith(color: Colors.grey),
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

            return null;
          },
        ),
      ],
    );
  }
}
