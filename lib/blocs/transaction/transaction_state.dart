// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<TransactionModel> transactions;
  const TransactionLoaded({
    required this.transactions,
  });

  TransactionLoaded copyWith(List<TransactionModel>? newtransactions) {
    return TransactionLoaded(transactions: newtransactions ?? transactions);
  }

  @override
  List<Object> get props => [transactions];
}

class TransactionLoading extends TransactionState {}

class TransactionFailed extends TransactionState {
  final String message;
  const TransactionFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
