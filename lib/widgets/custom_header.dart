import 'package:flutter/material.dart';
import 'package:rope_access/theme.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomHeader(
      {Key? key, this.title = 'title', this.subtitle = 'subtitle'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 24),
      width: size.width,
      height: size.height * .2 - 50,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.primaryStyle.copyWith(
                    fontSize: 24,
                    fontWeight: AppFontWeight.semibold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                subtitle,
                style: AppTextStyle.secondaryStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}
