import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:rope_access/blocs/auth/auth_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenthicated) {
          Timer(const Duration(seconds: 3), () => context.goNamed('main-home'));
        } else if (state is UnAuthenthicated) {
          Timer(const Duration(seconds: 3), () => context.goNamed('sign-in'));
        }
      },
      child: Center(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.asset(
              'assets/icons/logo.jpeg',
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            )),
      ),
    ));
  }
}
