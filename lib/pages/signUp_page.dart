import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rope_access/blocs/auth/auth_bloc.dart';
import 'package:rope_access/models/register_form_model.dart';
import 'package:rope_access/shared/shared_method.dart';
import 'package:rope_access/theme.dart';
import 'package:rope_access/widgets/custom_btn.dart';
import 'package:rope_access/widgets/custom_btn_loading.dart';
import 'package:rope_access/widgets/custom_header.dart';
import 'package:rope_access/widgets/custom_textformfield.dart';
import 'package:go_router/go_router.dart';
import 'package:rope_access/widgets/custom_textformfield_address.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController addressController =
      TextEditingController(text: '');
  final TextEditingController handphoneController =
      TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                      title: 'Register',
                      subtitle: 'Register dan Semangat Belanja',
                    ),
                    Center(
                      child: Column(
                        children: [
                          CustomFormField(
                              title: 'signUp',
                              label: 'Nama Lengkap',
                              controller: nameController,
                              textInputAction: TextInputAction.next,
                              assetIcon: 'assets/icons/ic_email.svg',
                              hintText: 'Nama Lengkap Anda'),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomFormField(
                              title: 'signUp',
                              label: 'Email',
                              controller: emailController,
                              textInputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              assetIcon: 'assets/icons/ic_email.svg',
                              hintText: 'Email Anda'),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomFormField(
                              title: 'signUp',
                              label: 'No.Hp',
                              textInputType: TextInputType.phone,
                              controller: handphoneController,
                              textInputAction: TextInputAction.next,
                              assetIcon: 'assets/icons/ic_email.svg',
                              hintText: 'No. Hp Anda'),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomFormAddressField(
                              title: 'signUp',
                              label: 'Alamat',
                              textInputType: TextInputType.multiline,
                              controller: addressController,
                              maxLines: 4,
                              textInputAction: TextInputAction.next,
                              assetIcon: 'assets/icons/ic_email.svg',
                              hintText: 'Alamat Anda'),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomFormField(
                              title: 'signUp',
                              label: 'Kata Sandi',
                              obscureText: true,
                              controller: passwordController,
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
                                text: 'Daftar',
                                formKey: _formKey,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(RegisterEvent(
                                        data: RegisterFormModel(
                                            name: nameController.text,
                                            email: emailController.text,
                                            address: addressController.text,
                                            handphone: handphoneController.text,
                                            password:
                                                passwordController.text)));
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 30),
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
              'Sudah punya akun? ',
              style: AppTextStyle.secondaryStyle.copyWith(fontSize: 12),
            ),
            GestureDetector(
              onTap: () {
                context.goNamed('sign-in');
              },
              child: Text(
                'Sign In',
                style: AppTextStyle.purpleStyle.copyWith(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
