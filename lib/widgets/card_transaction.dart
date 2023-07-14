import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rope_access/api/api_constant.dart';
import 'package:rope_access/models/transaction_model.dart';
import 'package:rope_access/shared/shared_method.dart';
import 'package:rope_access/theme.dart';
import 'package:shimmer/shimmer.dart';

class CardTransaction extends StatelessWidget {
  TransactionModel transaction;
  // TransactionItem transactionItem;
  CardTransaction({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: AppSpacer.defaultMargin),
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
          Row(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Barang ${transaction.transactionItem.length}',
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Total harga ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                                text: priceFormat(
                                    number: transaction.totalPrice,
                                    decimalDigit: 0,
                                    locale: 'id',
                                    symbol: 'IDR '),
                                style: AppTextStyle.priceStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: transaction.status == 'PENDING'
                        ? Colors.amber.withOpacity(.8)
                        : transaction.status == 'SUCCESS'
                            ? Colors.green
                            : AppColors.red,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  transaction.status,
                  style: AppTextStyle.primaryStyle.copyWith(fontSize: 12),
                ),
              )
            ],
          ),
          SizedBox(
            height: AppSpacer.defaultMargin,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Detail Porduk',
                style: const TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: AppSpacer.defaultMargin / 2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: transaction.transactionItem
                    .map(
                      (product) => Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                imageUrl:
                                    "${ApiConstant.publicUrl}${product.product.image}",
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
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.product.name,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                Text(
                                  '${priceFormat(number: product.product.price, decimalDigit: 0, locale: 'id', symbol: 'IDR ')}',
                                  style: AppTextStyle.priceStyle,
                                ),
                                Text(
                                  'kuantitas ${product.quantity}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
