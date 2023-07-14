import 'package:flutter/material.dart';
import 'package:rope_access/api/api_constant.dart';
import 'package:rope_access/models/jasa_model.dart';
import 'package:rope_access/shared/shared_method.dart';
import 'package:rope_access/theme.dart';

class CardJasa extends StatelessWidget {
  final JasaModel jasa;
  const CardJasa({Key? key, required this.jasa}) : super(key: key);

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
          jasa.galleries != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '${ApiConstant.publicUrl}${jasa.galleries![0].image}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 130,
                  ),
                )
              : const SizedBox(),
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
                    '${jasa.name}',
                    style: AppTextStyle.primaryStyle.copyWith(
                        fontWeight: AppFontWeight.semibold,
                        fontSize: 16,
                        color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    priceFormat(
                        number: int.parse(jasa.price!),
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
