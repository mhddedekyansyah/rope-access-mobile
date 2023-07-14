import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rope_access/api/api_constant.dart';
import 'package:rope_access/models/cart_model.dart';
import 'package:rope_access/storage/app_storage.dart';

class CartRepository {
  Future<bool> addToCart(
      {required int productId, required int quantity}) async {
    try {
      final String token = await AppStorage().read('token');
      final res = await http.post(
        Uri.parse(ApiConstant.addToCart),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({'product_id': productId, 'quantity': quantity}),
      );

      if (res.statusCode != 200) {
        // print('${'-' * 100}from cart repository');
        print(jsonDecode(res.body)['data']);
        // print('-' * 100);
        // throw jsonDecode(res.body)['message'];
        throw jsonDecode(res.body)['data'];
      }
      // CartModel cart = CartModel.fromJson(jsonDecode(res.body)['data']);
      // print('${'-' * 100} from cart repository');
      // print(cart);
      print(jsonDecode(res.body));
      // print('-' * 100);
      // return cart;
      return jsonDecode(res.body)['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeCart(CartModel cartModel) async {
    try {
      final String token = await AppStorage().read('token');
      final res = await http.post(
        Uri.parse(ApiConstant.removeCart),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({'id': cartModel.id}),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body);
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> incrementQuantityCart(CartModel cartModel) async {
    try {
      final String token = await AppStorage().read('token');
      final res = await http.post(
        Uri.parse(ApiConstant.incrementQuantityCart),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'id': cartModel.id,
          'user_id': cartModel.userId,
          'product_id': cartModel.product.id,
          'quantity': 1
        }),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body);
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> decrementQuantityCart(CartModel cartModel) async {
    try {
      final String token = await AppStorage().read('token');
      final res = await http.post(
        Uri.parse(ApiConstant.decrementQuantityCart),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'id': cartModel.id,
          'user_id': cartModel.userId,
          'product_id': cartModel.product.id,
          'quantity': 1
        }),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body);
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CartModel>> getAllCart() async {
    try {
      final String token = await AppStorage().read('token');
      final res = await http.get(
        Uri.parse(ApiConstant.cart),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return List.from(jsonDecode(res.body)['data'])
          .map((cart) => CartModel.fromJson(cart))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
