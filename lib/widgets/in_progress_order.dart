import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rope_access/models/transaction_model.dart';
import 'package:rope_access/theme.dart';
import 'package:rope_access/widgets/card_transaction.dart';
import 'package:url_launcher/url_launcher.dart';

@immutable
class InProgress extends StatelessWidget {
  final List<TransactionModel> transactions;

  const InProgress({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(AppSpacer.defaultPadding),
      primary: false,
      shrinkWrap: true,
      children: transactions.isNotEmpty
          ? transactions
              .map((transaction) => GestureDetector(
                    onTap: () async {
                      if (Platform.isAndroid) {
                        var wa =
                            "whatsapp://send?phone=6285372235517&text=konfirmasi pembayaran transaksi id : ${transaction.id}\ntotal harga ${transaction.totalPrice}";
                        await launchUrl(Uri.parse(wa));
                      }
                    },
                    child: CardTransaction(
                      transaction: transaction,
                    ),
                  ))
              .toList()
          : [
              const Center(
                child: Text(
                  'proses transaksi kosong',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
    );
  }
}
