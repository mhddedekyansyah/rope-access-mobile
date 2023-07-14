import 'package:flutter/material.dart';
import 'package:rope_access/theme.dart';

class CustomButtonLoading extends StatelessWidget {
  const CustomButtonLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      decoration: BoxDecoration(
          color: AppColors.purple, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 3.0,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'loading ...',
              style: AppTextStyle.primaryStyle,
            )
          ],
        ),
      ),
    );
  }
}
