import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:rope_access/blocs/auth/auth_bloc.dart';
import 'package:rope_access/blocs/product/product_bloc.dart';

import 'package:rope_access/theme.dart';
import 'package:rope_access/widgets/card_product.dart';
import 'package:rope_access/widgets/custom_header.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<ProductBloc>().add(GetAllProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProductBloc>().add(GetAllProduct());
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Container(
            margin: EdgeInsets.all(AppSpacer.defaultMargin),
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is Authenthicated) {
                return CustomHeader(
                  title: state.user.name,
                  subtitle: state.user.email,
                );
              }
              return const CustomHeader();
            }),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: AppSpacer.defaultPadding),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Produk',
                style: AppTextStyle.primaryStyle.copyWith(
                    fontSize: 22,
                    fontWeight: AppFontWeight.semibold,
                    color: Colors.black),
              ),
              SizedBox(height: AppSpacer.defaultMargin),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductFailed) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProductLoaded) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.products.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              childAspectRatio: .8,
                              mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.pushNamed('product',
                                extra: state.products[index]);
                          },
                          child: CardProduct(
                            productModel: state.products[index],
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
