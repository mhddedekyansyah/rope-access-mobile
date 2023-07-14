// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddToCartModel {
  final int productId;
  final int quantity;
  AddToCartModel({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {'product_id': productId, 'quantity': quantity};
  }
}
