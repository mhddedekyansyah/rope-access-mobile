import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rope_access/blocs/auth/auth_bloc.dart';
import 'package:rope_access/blocs/page/page_bloc.dart';
import 'package:rope_access/theme.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: AppColors.background3,
        body: SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenthicated) {
            context.goNamed('sign-in');
          }
        },
        builder: (context, state) {
          if (state is Authenthicated) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text(
                    'Nama Lengkap',
                    style: TextStyle(
                        color: Colors.black, fontWeight: AppFontWeight.bold),
                  ),
                  subtitle: Text(
                    state.user.name,
                    style: AppTextStyle.secondaryStyle
                        .copyWith(color: Colors.black),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.black, fontWeight: AppFontWeight.bold),
                  ),
                  subtitle: Text(
                    state.user.email,
                    style: AppTextStyle.secondaryStyle,
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Keluar',
                    style: TextStyle(
                        color: Colors.black, fontWeight: AppFontWeight.bold),
                  ),
                  trailing: const Icon(
                    Icons.logout_rounded,
                    color: AppColors.red,
                  ),
                  onTap: () {
                    context
                        .read<AuthBloc>()
                        .add(LogoutEvent(token: state.user.token));
                    context
                        .read<PageBloc>()
                        .add(const SetPageEvent(currentIndex: 0));
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    ));
  }
}
