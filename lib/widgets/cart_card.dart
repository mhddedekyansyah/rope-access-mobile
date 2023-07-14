import 'package:flutter/material.dart';
import 'package:rope_access/models/cart_model.dart';
import 'package:rope_access/theme.dart';

class CartCard extends StatelessWidget {
  final CartModel? cart;
  const CartCard({this.cart, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: AppSpacer.defaultMargin,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.background2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // image: DecorationImage(
                  //   image: AssetImage(
                  //     cart?.product!.imgUrl!.first ??
                  //         'assets/images/image_shoes.png',
                  //   ),
                  // ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terrex Urban Low',
                      style: AppTextStyle.primaryStyle.copyWith(
                        fontWeight: AppFontWeight.semibold,
                      ),
                    ),
                    Text(
                      '143,98',
                      style: AppTextStyle.priceStyle,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    // child: SvgPicture.asset(
                    //   'assets/icons/ic_add.svg',
                    //   width: 16,
                    // ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    '7',
                    style: AppTextStyle.priceStyle.copyWith(
                      fontWeight: AppFontWeight.medium,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  GestureDetector(
                    onTap: () {},
                    // child: SvgPicture.asset(
                    //   'assets/icons/ic_remove.svg',
                    //   width: 16,
                    // ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                // child: SvgPicture.asset(
                //   'assets/icons/ic_trash.svg',
                //   width: 16,
                // ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                'Remove',
                style: AppTextStyle.primaryStyle.copyWith(
                    fontSize: 12,
                    fontWeight: AppFontWeight.light,
                    color: AppColors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
