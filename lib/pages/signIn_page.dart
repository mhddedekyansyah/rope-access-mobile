import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rope_access/blocs/auth/auth_bloc.dart';
import 'package:rope_access/models/login_form_model.dart';
import 'package:rope_access/shared/shared_method.dart';
import 'package:rope_access/theme.dart';
import 'package:rope_access/widgets/custom_btn.dart';
import 'package:rope_access/widgets/custom_btn_loading.dart';
import 'package:rope_access/widgets/custom_header.dart';
import 'package:rope_access/widgets/custom_textformfield.dart';
import 'package:go_router/go_router.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const CustomHeader(
                      title: 'Login',
                      subtitle: 'Login untuk melanjutkan',
                    ),
                    Center(
                      child: Column(
                        children: [
                          CustomFormField(
                            title: 'signIn',
                            label: 'Email',
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            assetIcon: 'assets/icons/ic_email.svg',
                            hintText: 'Alamat Email Anda',
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomFormField(
                              title: 'signIn',
                              label: 'Kata Sandi',
                              controller: passwordController,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              assetIcon: 'assets/icons/ic_password.svg',
                              hintText: 'Kata Sandi Anda'),
                          const SizedBox(
                            height: 24,
                          ),
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is Authenthicated) {
                                context.goNamed('main-home');
                              }

                              if (state is AuthFailed) {
                                showCustomSnackbar(context, state.message);
                              }
                            },
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return const CustomButtonLoading();
                              }
                              return CustomBtn(
                                text: 'Login',
                                formKey: _formKey,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(LoginEvent(
                                        data: LoginFormModel(
                                            email: emailController.text,
                                            password:
                                                passwordController.text)));
                                  }
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya akun? ',
              style: AppTextStyle.secondaryStyle.copyWith(fontSize: 12),
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed('sign-up');
              },
              child: Text(
                'Daftar',
                style: AppTextStyle.purpleStyle.copyWith(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
