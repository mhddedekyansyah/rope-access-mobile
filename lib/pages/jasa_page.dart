import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rope_access/blocs/jasa/jasa_bloc.dart';
import 'package:rope_access/theme.dart';
import 'package:rope_access/widgets/card_jasa.dart';

class Jasa extends StatefulWidget {
  const Jasa({Key? key}) : super(key: key);

  @override
  State<Jasa> createState() => _JasaState();
}

class _JasaState extends State<Jasa> {
  @override
  void initState() {
    context.read<JasaBloc>().add(GetAllJasa());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: AppColors.background3,
        appBar: AppBar(
          title: Text(
            'Jasa',
            style: AppTextStyle.primaryStyle.copyWith(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<JasaBloc, JasaState>(builder: (context, state) {
            if (state is JasaFailed) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is JasaLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is JasaLoaded) {
              return GridView.builder(
                padding: EdgeInsets.all(AppSpacer.defaultMargin),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.jasas.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  childAspectRatio: .7,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        context.pushNamed('jasa-detail',
                            extra: state.jasas[index]);
                      },
                      child: CardJasa(
                        jasa: state.jasas[index],
                      ));
                },
              );
            }
            return const SizedBox();
          }),
        ));
  }
}
