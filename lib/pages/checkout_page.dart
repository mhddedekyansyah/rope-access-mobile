import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rope_access/blocs/auth/auth_bloc.dart';
import 'package:rope_access/blocs/cart/cart_bloc.dart';
import 'package:rope_access/blocs/transaction/transaction_bloc.dart';
import 'package:rope_access/models/cart_model.dart';
import 'package:rope_access/models/user_model.dart';
import 'package:rope_access/shared/shared_method.dart';
import 'package:rope_access/theme.dart';
import 'package:rope_access/widgets/checkout_card.dart';
import 'package:rope_access/widgets/custom_btn.dart';
import 'package:go_router/go_router.dart';
import 'package:rope_access/widgets/custom_btn_loading.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = (context.read<AuthBloc>().state as Authenthicated).user;
    return Scaffold(
        // backgroundColor: AppColors.background3,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Detail Pesanan',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            List<CartModel> carts = (state as CartLoaded).carts;
            return ListView(
              primary: false,
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacer.defaultPadding,
              ),
              children: [
                // NOTE: LIST ITEMS
                Container(
                  margin: EdgeInsets.only(
                    top: AppSpacer.defaultMargin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daftar Barang',
                        style: AppTextStyle.primaryStyle.copyWith(
                            fontSize: 16,
                            fontWeight: AppFontWeight.bold,
                            color: Colors.black),
                      ),
                      Column(
                        children: carts
                            .map(
                              (cart) => CheckoutCard(cart),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),

                // NOTE: ADDRESS DETAILS
                Container(
                  margin: EdgeInsets.only(
                    top: AppSpacer.defaultMargin,
                  ),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 4,
                          color: Colors.grey.shade200)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Alamat',
                        style: AppTextStyle.primaryStyle.copyWith(
                            fontSize: 16,
                            fontWeight: AppFontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/building.svg',
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SvgPicture.asset(
                                'assets/icons/line.svg',
                                height: 30,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SvgPicture.asset(
                                'assets/icons/location.svg',
                                width: 30,
                                height: 30,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alamat Toko',
                                style: AppTextStyle.secondaryStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Rope Access',
                                style: AppTextStyle.primaryStyle.copyWith(
                                    fontWeight: AppFontWeight.light,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: AppSpacer.defaultMargin,
                              ),
                              Text(
                                'Alamat Anda',
                                style: AppTextStyle.secondaryStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                user.address,
                                style: AppTextStyle.primaryStyle.copyWith(
                                  fontWeight: AppFontWeight.light,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // NOTE: PAYMENT SUMMARY
                Container(
                  margin: EdgeInsets.only(
                    top: AppSpacer.defaultMargin,
                  ),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 4,
                          color: Colors.grey.shade200)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ringkasan Pembayaran',
                        style: AppTextStyle.primaryStyle.copyWith(
                          fontSize: 16,
                          fontWeight: AppFontWeight.light,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Barang',
                            style: AppTextStyle.secondaryStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '${state.totalItems} Items',
                            style: AppTextStyle.primaryStyle.copyWith(
                              fontWeight: AppFontWeight.light,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xff2E3141),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: AppTextStyle.priceStyle.copyWith(
                              fontWeight: AppFontWeight.semibold,
                            ),
                          ),
                          Text(
                            priceFormat(
                                number: state.totalPrice,
                                decimalDigit: 0,
                                locale: 'id',
                                symbol: 'IDR '),
                            style: AppTextStyle.priceStyle.copyWith(
                              fontWeight: AppFontWeight.semibold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // NOTE: CHECKOUT BUTTON
                SizedBox(
                  height: AppSpacer.defaultMargin,
                ),

                BlocConsumer<TransactionBloc, TransactionState>(
                  listener: (context, stateTransaction) {
                    if (stateTransaction is TransactionLoaded) {
                      context.goNamed('checkout-success',
                          extra: stateTransaction.transactions.last);
                    }

                    if (stateTransaction is TransactionFailed) {
                      showCustomSnackbar(context, stateTransaction.message);
                    }
                  },
                  builder: (context, stateTransaction) {
                    if (stateTransaction is TransactionLoading) {
                      return const CustomButtonLoading();
                    }
                    return CustomBtn(
                        text: 'Pesan Sekarang',
                        onPressed: () {
                          context.read<TransactionBloc>().add(CheckoutEvent(
                              address: user.address,
                              totalPrice: state.totalPrice,
                              carts: state.carts));
                        });
                  },
                ),
              ],
            );
          },
        ));
  }
}
