part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class AddToCartSuccess extends CartState {
  const AddToCartSuccess();
}

class AddToCartFailed extends CartState {
  const AddToCartFailed();
}

class CartLoaded extends CartState {
  final int totalPrice;
  final List<CartModel> carts;
  final int totalItems;
  const CartLoaded(
      {required this.carts,
      required this.totalPrice,
      required this.totalItems});

  CartLoaded copyWith(
      {List<CartModel>? carts, int? totalPrice, int? totalItems}) {
    return CartLoaded(
        carts: carts ?? this.carts,
        totalPrice: totalPrice ?? this.totalPrice,
        totalItems: totalItems ?? this.totalItems);
  }

  @override
  List<Object> get props => [carts, totalPrice, totalItems];
}

class CartLoading extends CartState {}

class CartFailed extends CartState {
  final String message;
  const CartFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
