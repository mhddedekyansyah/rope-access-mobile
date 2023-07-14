import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rope_access/api/api_constant.dart';
import 'package:rope_access/blocs/cart/cart_bloc.dart';
import 'package:rope_access/models/product_model.dart';
import 'package:rope_access/shared/shared_method.dart';
import 'package:rope_access/theme.dart';
import 'package:rope_access/widgets/custom_btn.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;
  const DetailProduct({super.key, required this.productModel});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is AddToCartSuccess) {
          showCustomSnackbar(context, 'tambah keranjang success',
              color: Colors.green);
          context.read<CartBloc>().add(GetAllCart());
        }
        if (state is AddToCartFailed) {
          showCustomSnackbar(
            context,
            'add to cart failed',
          );
          context.read<CartBloc>().add(GetAllCart());
        }
      },
      builder: (context, state) {
        return Scaffold(
          // backgroundColor: AppColors.background3,
          body: Stack(
            children: [
              SafeArea(
                child: SizedBox(
                  width: width,
                  height: height,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CarouselSlider(
                              items: [
                                Container(
                                  width: width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${ApiConstant.publicUrl}${widget.productModel.image}'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                              options: CarouselOptions(
                                scrollPhysics:
                                    const NeverScrollableScrollPhysics(),
                                height: height * .5,
                                initialPage: currentIndex,
                                onPageChanged: (index, reason) {
                                  setState(
                                    () {
                                      currentIndex = index;
                                    },
                                  );
                                },
                                autoPlay: false,
                                viewportFraction: 1,
                              ),
                            ),
                            Positioned(
                              top: 15,
                              left: 15,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () => context.pop(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nama Barang',
                                        style: AppTextStyle.primaryStyle
                                            .copyWith(
                                                fontWeight:
                                                    AppFontWeight.semibold,
                                                color: Colors.black,
                                                fontSize: 18),
                                      ),
                                      Text(
                                        widget.productModel.name.toString(),
                                        style: AppTextStyle.secondaryStyle,
                                      ),
                                      Text(
                                        'stok : ${widget.productModel.stok}',
                                        style: AppTextStyle.secondaryStyle,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Harga',
                                        style: AppTextStyle.primaryStyle
                                            .copyWith(
                                                fontWeight:
                                                    AppFontWeight.semibold,
                                                color: Colors.black,
                                                fontSize: 18),
                                      ),
                                      Text(
                                        priceFormat(
                                            number: widget.productModel.price,
                                            locale: 'id',
                                            decimalDigit: 0,
                                            symbol: 'IDR '),
                                        style: AppTextStyle.priceStyle,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: CustomBtn(
                    text: 'Tambah ke Keranjang',
                    onPressed: () async {
                      context.read<CartBloc>().add(
                          // AddToCart(
                          //   data: AddToCartModel(
                          //       productId: widget.productModel.id,
                          //       quantity: 1),
                          // ),
                          AddToCart(
                              productId: widget.productModel.id, quantity: 1));
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
