import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rope_access/api/api_constant.dart';
import 'package:rope_access/models/cart_model.dart';
import 'package:rope_access/shared/shared_method.dart';
import 'package:rope_access/theme.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutCard extends StatelessWidget {
  final CartModel cart;
  const CheckoutCard(this.cart, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(spreadRadius: 1, blurRadius: 4, color: Colors.grey.shade200)
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              imageUrl: "${ApiConstant.publicUrl}${cart.product.image}",
              placeholder: (context, url) => SizedBox(
                width: 60.0,
                height: 60.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    color: Colors.white,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  cart.product.name,
                  style: AppTextStyle.primaryStyle.copyWith(
                      fontWeight: AppFontWeight.semibold, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  priceFormat(
                      number: cart.product.price,
                      decimalDigit: 0,
                      locale: 'id',
                      symbol: 'IDR '),
                  style: AppTextStyle.priceStyle,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            '${cart.quantity} Items',
            style: AppTextStyle.secondaryStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
