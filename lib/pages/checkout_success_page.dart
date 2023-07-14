import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rope_access/blocs/page/page_bloc.dart';
import 'package:rope_access/models/transaction_model.dart';
import 'package:rope_access/theme.dart';
import 'package:rope_access/widgets/custom_btn.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutSuccess extends StatelessWidget {
  final TransactionModel transaction;
  const CheckoutSuccess({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    PreferredSize header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          // backgroundColor: AppColors.background2,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Pesanan Sukses',
          ),
          elevation: 0,
        ),
      );
    }

    Widget content() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/ic_cart_view.svg',
              width: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Anda Membuat Transaksi',
              style: AppTextStyle.primaryStyle.copyWith(
                  fontSize: 16,
                  fontWeight: AppFontWeight.medium,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Tunngu di rumah\n saat kami menyiapkan produk impian mu',
              style: AppTextStyle.secondaryStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomBtn(
              text: 'Konfirmasi Pembayaran',
              onPressed: () async {
                if (Platform.isAndroid) {
                  var wa =
                      "whatsapp://send?phone=6285372235517&text=konfirmasi pembayaran transaksi id : ${transaction.id}\ntotal harga ${transaction.totalPrice}";
                  await launchUrl(Uri.parse(wa));
                }
              },
              width: 196,
              color: AppColors.accent,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomBtn(
              text: 'Pesan Produk Lainnya',
              onPressed: () {
                context.goNamed('main-home');
              },
              width: 196,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomBtn(
              text: 'Lihat Riwayat Transaksi  ',
              onPressed: () {
                context
                    .read<PageBloc>()
                    .add(const SetPageEvent(currentIndex: 2));
                context.goNamed('main-home');
              },
              width: 196,
              color: AppColors.secondary,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      // backgroundColor: AppColors.background3,
      appBar: header(),
      body: content(),
    );
  }
}
