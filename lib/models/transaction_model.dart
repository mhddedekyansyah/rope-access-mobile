// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:rope_access/models/product_model.dart';

class TransactionModel extends Equatable {
  final dynamic id;
  final dynamic userId;
  final String address;
  final String status;
  final dynamic totalPrice;
  final List<TransactionItem> transactionItem;

  const TransactionModel({
    required this.id,
    required this.userId,
    required this.address,
    required this.status,
    required this.totalPrice,
    required this.transactionItem,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        id: json['id'],
        userId: json['users_id'],
        address: json['address'],
        status: json['status'],
        totalPrice: json['total_price'],
        transactionItem: json['items'] != null
            ? List.from(json['items'])
                .map((transaction) => TransactionItem.fromJson(transaction))
                .toList()
            : <TransactionItem>[]);
  }

  @override
  List<Object?> get props =>
      [id, userId, address, status, totalPrice, transactionItem];
}

class TransactionItem extends Equatable {
  final dynamic id;
  final dynamic userId;
  final dynamic productsId;
  final dynamic transactionsId;
  final dynamic quantity;
  final ProductModel product;

  const TransactionItem({
    required this.id,
    required this.userId,
    required this.productsId,
    required this.transactionsId,
    required this.quantity,
    required this.product,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
        id: json['id'],
        userId: json['users_id'],
        productsId: json['products_id'],
        transactionsId: json['transactions_id'],
        quantity: json['quantity'],
        product: ProductModel.fromJson(json['product']));
  }
  @override
  List<Object?> get props => [id, userId, productsId, transactionsId, product];
}
