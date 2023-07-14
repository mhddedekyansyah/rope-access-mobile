import 'package:flutter/material.dart';
import 'package:rope_access/models/transaction_model.dart';
import 'package:rope_access/theme.dart';
import 'package:rope_access/widgets/card_transaction.dart';

@immutable
class PassOrder extends StatelessWidget {
  final List<TransactionModel> transactions;

  const PassOrder({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(AppSpacer.defaultPadding),
      primary: false,
      shrinkWrap: true,
      children: transactions.isNotEmpty
          ? transactions
              .map((transaction) => CardTransaction(
                    transaction: transaction,
                  ))
              .toList()
          : [
              const Center(
                child: Text(
                  'transaksi kosong',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
    );
  }
}
