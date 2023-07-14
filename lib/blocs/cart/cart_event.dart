// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  // final AddToCartModel data;
  // const AddToCart({
  //   required this.data,
  // });
  final int productId;
  final int quantity;
  const AddToCart({
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object> get props => [productId, quantity];
}

class CartInitialEvent extends CartEvent {}

class GetAllCart extends CartEvent {}

class IncrementQuantityCart extends CartEvent {
  final CartModel cartModel;
  const IncrementQuantityCart({
    required this.cartModel,
  });

  @override
  List<Object> get props => [cartModel];
}

class DecrementQuantityCart extends CartEvent {
  final CartModel cartModel;
  const DecrementQuantityCart({
    required this.cartModel,
  });

  @override
  List<Object> get props => [cartModel];
}

class RemoveCart extends CartEvent {
  final CartModel cartModel;
  const RemoveCart({
    required this.cartModel,
  });

  @override
  List<Object> get props => [cartModel];
}
