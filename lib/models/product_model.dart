// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;

  final int price;
  final int stok;
  final String? image;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stok,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        stok: json['stok'],
        image: json['image'] ?? '');
  }
  @override
  List<Object?> get props => [id, name, price, stok, image];
}
