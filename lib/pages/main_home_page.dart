import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rope_access/blocs/cart/cart_bloc.dart';
import 'package:rope_access/blocs/page/page_bloc.dart';
import 'package:rope_access/pages/history_page.dart';
import 'package:rope_access/pages/home_page.dart';
import 'package:rope_access/pages/jasa_page.dart';
import 'package:rope_access/pages/profile_page.dart';
import 'package:rope_access/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  void initState() {
    context.read<CartBloc>().add(GetAllCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          // backgroundColor:
          //     currentIndex == 0 ? AppColors.background : AppColors.background3,
          body: IndexedStack(
            index: currentIndex,
            children: const [Home(), Jasa(), History(), Profile()],
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.pushNamed('cart');
              },
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(elevation: 0.0),
                position: badges.BadgePosition.topEnd(top: -11, end: -8),
                badgeContent: BlocBuilder<CartBloc, CartState>(
                  // buildWhen: (previous, current) => previous == CartLoaded,
                  builder: (context, state) {
                    if (state is CartFailed) {
                      return Center(
                        child: Expanded(
                          child: Text(
                            state.message,
                            style: AppTextStyle.primaryStyle
                                .copyWith(fontSize: 12),
                          ),
                        ),
                      );
                    }

                    if (state is CartLoaded) {
                      return Text(
                        state.carts.length.toString(),
                        style: AppTextStyle.primaryStyle.copyWith(fontSize: 12),
                      );
                    }

                    return const SizedBox();
                  },
                ),
                child: const Icon(
                  Icons.shopping_bag_rounded,
                  color: AppColors.primary,
                ),
              )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            notchMargin: 10,
            shape: const CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,
            elevation: 0.0,
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                elevation: 0.0,
                selectedItemColor: AppColors.purple,
                unselectedItemColor: AppColors.secondary,
                currentIndex: currentIndex,
                onTap: (index) {
                  context.read<PageBloc>().add(
                        SetPageEvent(currentIndex: index),
                      );
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: 'home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_add_alt_1_rounded),
                    label: 'jasa',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history_rounded),
                    label: 'history',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded),
                    label: 'profile',
                  ),
                ]),
          ),
        );
      },
    );
  }
}
