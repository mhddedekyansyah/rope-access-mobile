import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rope_access/api/api_constant.dart';
import 'package:rope_access/blocs/cart/cart_bloc.dart';
import 'package:rope_access/models/cart_model.dart';
import 'package:rope_access/shared/shared_method.dart';
import 'package:rope_access/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rope_access/widgets/custom_btn.dart';
import 'package:shimmer/shimmer.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Keranjang',
          style: AppTextStyle.primaryStyle.copyWith(
              fontSize: 18,
              fontWeight: AppFontWeight.medium,
              color: Colors.black),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          // if (state is CartLoaded) {

          // }
          if (state is CartFailed) {
            showCustomSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is CartLoaded) {
            return state.carts.isNotEmpty
                ? ListView.separated(
                    primary: false,
                    itemCount: state.carts.length,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSpacer.defaultMargin),
                    separatorBuilder: (_, index) => const SizedBox(
                      height: 15,
                    ),
                    itemBuilder: (context, index) {
                      CartModel cart = state.carts[index];
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // color: AppColors.background2,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 4,
                                color: Colors.grey.shade200)
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "${ApiConstant.publicUrl}${cart.product.image}",
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
                                  width: 12,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cart.product.name,
                                        style: AppTextStyle.primaryStyle
                                            .copyWith(
                                                fontWeight:
                                                    AppFontWeight.semibold,
                                                color: Colors.black),
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
                                Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          context.read<CartBloc>().add(
                                              IncrementQuantityCart(
                                                  cartModel: cart));
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: AppColors.purple,
                                        )),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      cart.quantity.toString(),
                                      style: AppTextStyle.primaryStyle.copyWith(
                                          fontWeight: AppFontWeight.medium,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    cart.quantity > 1
                                        ? GestureDetector(
                                            onTap: () {
                                              context.read<CartBloc>().add(
                                                    DecrementQuantityCart(
                                                      cartModel: cart,
                                                    ),
                                                  );
                                            },
                                            child: const Icon(
                                              Icons.remove,
                                              color: AppColors.secondary,
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<CartBloc>()
                                    .add(RemoveCart(cartModel: cart));
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.delete_forever_rounded,
                                    color: AppColors.red,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Hapus',
                                    style: AppTextStyle.primaryStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: AppFontWeight.light,
                                        color: AppColors.red),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('keranjang kosong'),
                  );
          }

          if (state is CartFailed) {
            return Center(
              child: Text(state.message),
            );
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            return state.carts.isNotEmpty
                ? Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: AppSpacer.defaultMargin, vertical: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'subtotal',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              priceFormat(
                                  number: state.totalPrice,
                                  locale: 'id',
                                  symbol: 'IDR ',
                                  decimalDigit: 0),
                              style: AppTextStyle.priceStyle,
                            )
                          ],
                        ),
                        SizedBox(
                          height: AppSpacer.defaultMargin * 2,
                        ),
                        CustomBtn(
                            text: 'pesan',
                            onPressed: () {
                              context.pushNamed('checkout');
                            }),
                      ],
                    ),
                  )
                : const SizedBox();
          }

          return const SizedBox();
        },
      ),
    );
  }
}
