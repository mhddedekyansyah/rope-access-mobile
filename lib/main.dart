import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rope_access/blocs/app_bloc_observer.dart';
import 'package:rope_access/blocs/auth/auth_bloc.dart';
import 'package:rope_access/blocs/cart/cart_bloc.dart';
import 'package:rope_access/blocs/jasa/jasa_bloc.dart';
import 'package:rope_access/blocs/page/page_bloc.dart';
import 'package:rope_access/blocs/product/product_bloc.dart';
import 'package:rope_access/blocs/transaction/transaction_bloc.dart';
import 'package:rope_access/pages/profile1.dart';
import 'package:rope_access/repositories/auth/auth_repository.dart';
import 'package:rope_access/repositories/cart/cart_repository.dart';
import 'package:rope_access/repositories/jasa/jasa_repository.dart';
import 'package:rope_access/repositories/product/product_repository.dart';
import 'package:rope_access/repositories/transaction/transaction_repository.dart';
import 'package:rope_access/routes/app_router.dart';
import 'package:rope_access/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  Bloc.observer = AppBlocObserver();
  runApp(MyApp(
    appRouter: AppRouter(),
    appTheme: AppTheme(),
  ));
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  final AppTheme appTheme;
  const MyApp({Key? key, required this.appRouter, required this.appTheme})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => AuthRepository()),
          RepositoryProvider(create: (context) => ProductRepository()),
          RepositoryProvider(create: (context) => JasaRepository()),
          RepositoryProvider(create: (context) => CartRepository()),
          RepositoryProvider(create: (context) => TransactionRepository()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => PageBloc()),
            BlocProvider(
              create: (context) =>
                  AuthBloc(authRepository: context.read<AuthRepository>())
                    ..add(
                      GetCurrentUser(),
                    ),
            ),
            BlocProvider(
                create: (context) => ProductBloc(
                    productRepository: context.read<ProductRepository>())),
            BlocProvider(
                create: (context) =>
                    JasaBloc(jasaRepository: context.read<JasaRepository>())),
            BlocProvider(
                create: (context) =>
                    CartBloc(cartRepository: context.read<CartRepository>())),
            BlocProvider(
                create: (context) => TransactionBloc(
                    transactionRepository:
                        context.read<TransactionRepository>())),
          ],
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Profile1(),
          ),
          // child: MaterialApp.router(
          //   theme: widget.appTheme.dark,
          //   themeMode: ThemeMode.dark,
          //   debugShowCheckedModeBanner: false,
          //   routeInformationProvider:
          //       widget.appRouter.router.routeInformationProvider,
          //   routeInformationParser:
          //       widget.appRouter.router.routeInformationParser,
          //   routerDelegate: widget.appRouter.router.routerDelegate,
          // ),
        ));
  }

  @override
  void dispose() {
    widget.appRouter.router.dispose();
    super.dispose();
  }
}
