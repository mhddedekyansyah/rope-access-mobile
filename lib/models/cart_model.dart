// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:rope_access/models/product_model.dart';

class CartModel extends Equatable {
  final int id;
  final ProductModel product;
  final int userId;
  final int quantity;
  const CartModel({
    required this.id,
    required this.product,
    required this.userId,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      id: json['id'],
      userId: json['user_id'],
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity']);

  CartModel copyWith({
    int? id,
    ProductModel? product,
    int? userId,
    int? quantity,
  }) {
    return CartModel(
      id: id ?? this.id,
      product: product ?? this.product,
      userId: userId ?? this.userId,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, userId, product, quantity];
}
