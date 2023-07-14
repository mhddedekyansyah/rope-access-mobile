import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:rope_access/theme.dart';

priceFormat(
    {required int number,
    String? locale = 'en_US',
    String? symbol = '\$',
    int? decimalDigit = 2}) {
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: locale,
    symbol: symbol,
    decimalDigits: decimalDigit,
  );
  return currencyFormatter.format(number);
}

Future showCustomSnackbar(BuildContext context, String msg,
    {Color color = AppColors.red}) async {
  await Flushbar(
    message: msg,
    backgroundColor: color,
    flushbarPosition: FlushbarPosition.TOP,
    duration: const Duration(seconds: 3),
  ).show(context);
}
