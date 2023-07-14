import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rope_access/blocs/transaction/transaction_bloc.dart';
import 'package:rope_access/theme.dart';
import 'package:rope_access/widgets/custom_header.dart';
import 'package:rope_access/widgets/custom_tabbar.dart';
import 'package:rope_access/widgets/in_progress_order.dart';
import 'package:rope_access/widgets/pass_order.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int? selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(const GetAllTransaction());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TransactionBloc>().add(const GetAllTransaction());
      },
      child: Scaffold(
        // backgroundColor: AppColors.background3,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Container(
            margin: EdgeInsets.all(AppSpacer.defaultMargin),
            child: const CustomHeader(
              title: 'Transaksi',
              subtitle: 'Transaksi Anda',
            ),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              CustomTabbar(
                titles: const [
                  'Dalam Proses',
                  'Transaksi yang lalu',
                ],
                selectedIndex: selectedIndex!,
                selectTab: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  primary: false,
                  child: Column(
                    children: [
                      BlocBuilder<TransactionBloc, TransactionState>(
                          builder: (context, state) {
                        if (state is TransactionLoaded) {
                          return selectedIndex == 0
                              ? InProgress(
                                  transactions: state.transactions
                                      .where((transaction) =>
                                          transaction.status == 'PENDING')
                                      .toList(),
                                )
                              : selectedIndex == 1
                                  ? PassOrder(
                                      transactions: state.transactions
                                          .where((transaction) =>
                                              transaction.status == 'SUCCESS' ||
                                              transaction.status == 'CANCEL')
                                          .toList(),
                                    )
                                  : const Text('transaksi kosong');
                        }

                        if (state is TransactionFailed) {
                          return Center(
                            child: Text(state.message),
                          );
                        }

                        return const SizedBox();
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
