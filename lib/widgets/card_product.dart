import 'package:flutter/material.dart';
import 'package:rope_access/api/api_constant.dart';
import 'package:rope_access/models/product_model.dart';
import 'package:rope_access/shared/shared_method.dart';
import 'package:rope_access/theme.dart';

class CardProduct extends StatelessWidget {
  final ProductModel productModel;
  const CardProduct({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(spreadRadius: 1, blurRadius: 4, color: Colors.grey.shade200)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          productModel.image!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '${ApiConstant.publicUrl}${productModel.image}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 130,
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.cardDark,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'no image product',
                    style: AppTextStyle.primaryStyle,
                  )),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.name,
                    style: AppTextStyle.primaryStyle.copyWith(
                        fontWeight: AppFontWeight.semibold,
                        color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    priceFormat(
                        number: productModel.price,
                        locale: 'id',
                        decimalDigit: 0,
                        symbol: 'IDR '),
                    style: AppTextStyle.priceStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
