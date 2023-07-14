import 'dart:convert';

import 'package:rope_access/api/api_constant.dart';
import 'package:rope_access/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:rope_access/storage/app_storage.dart';

class ProductRepository {
  Future<List<ProductModel>> getAllProduct() async {
    try {
      final String token = await AppStorage().read('token');
      final res = await http.get(
        Uri.parse(ApiConstant.product),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return List.from(jsonDecode(res.body)['data']['products'])
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
