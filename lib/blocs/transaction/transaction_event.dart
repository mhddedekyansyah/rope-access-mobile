// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class CheckoutEvent extends TransactionEvent {
  final String address;
  final int totalPrice;
  final List<CartModel> carts;

  const CheckoutEvent({
    required this.address,
    required this.totalPrice,
    required this.carts,
  });
}

class GetAllTransaction extends TransactionEvent {
  const GetAllTransaction();
}
