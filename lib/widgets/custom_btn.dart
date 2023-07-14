import 'package:flutter/material.dart';
import 'package:rope_access/theme.dart';

class CustomBtn extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final Color color;

  const CustomBtn(
      {Key? key,
      this.formKey,
      required this.text,
      required this.onPressed,
      this.width,
      this.color = AppColors.purple})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize:
            width != null ? Size(width!, 50) : const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
