import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rope_access/models/jasa_model.dart';
import 'package:rope_access/models/product_model.dart';
import 'package:rope_access/models/transaction_model.dart';
import 'package:rope_access/pages/cart_page.dart';
import 'package:rope_access/pages/checkout_success_page.dart';
import 'package:rope_access/pages/detail_jasa_page.dart';
import 'package:rope_access/pages/detail_product_page.dart';
import 'package:rope_access/pages/checkout_page.dart';
import 'package:rope_access/pages/history_page.dart';
import 'package:rope_access/pages/home_page.dart';
import 'package:rope_access/pages/jasa_page.dart';
import 'package:rope_access/pages/main_home_page.dart';
import 'package:rope_access/pages/profile_page.dart';
import 'package:rope_access/pages/signIn_page.dart';
import 'package:rope_access/pages/signUp_page.dart';
import 'package:rope_access/pages/splash_page.dart';

class AppRouter {
  final GoRouter _router = GoRouter(routes: <RouteBase>[
    GoRoute(
        name: 'splash',
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: Splash());
        }),
    GoRoute(
        name: 'sign-in',
        path: '/sign-in',
        pageBuilder: (context, state) {
          return MaterialPage(child: SignIn());
        }),
    GoRoute(
        name: 'sign-up',
        path: '/sign-up',
        pageBuilder: (context, state) {
          return MaterialPage(child: SignUp());
        }),
    GoRoute(
        name: 'main-home',
        path: '/main-home',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: MainHome(),
          );
        }),
    GoRoute(
        name: 'home',
        path: '/home',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: Home(),
          );
        }),
    GoRoute(
      name: 'jasa',
      path: '/jasa',
      pageBuilder: (context, state) {
        return const MaterialPage(child: Jasa());
      },
      routes: [
        GoRoute(
          name: 'jasa-detail',
          path: 'jasa-detail',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: DetailJasa(
              jasaModel: state.extra as JasaModel,
            ));
          },
        ),
      ],
    ),
    GoRoute(
        name: 'history',
        path: '/history',
        pageBuilder: (context, state) {
          return const MaterialPage(child: History());
        }),
    GoRoute(
        name: 'profile',
        path: '/profile',
        pageBuilder: (context, state) {
          return const MaterialPage(child: Profile());
        }),
    GoRoute(
        name: 'cart',
        path: '/cart',
        pageBuilder: (context, state) {
          return const MaterialPage(child: Cart());
        }),
    GoRoute(
        name: 'product',
        path: '/product',
        pageBuilder: (context, state) {
          return MaterialPage(
              child: DetailProduct(
            productModel: state.extra as ProductModel,
          ));
        }),
    GoRoute(
        name: 'checkout',
        path: '/checkout',
        pageBuilder: (context, state) {
          return const MaterialPage(child: Checkout());
        }),
    GoRoute(
        name: 'checkout-success',
        path: '/checkout-success',
        pageBuilder: (context, state) {
          return  MaterialPage(child: CheckoutSuccess(transaction: state.extra as TransactionModel,));
        }),
  ]);

  GoRouter get router => _router;
}
