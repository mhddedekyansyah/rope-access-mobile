import 'dart:convert';

import 'package:rope_access/api/api_constant.dart';
import 'package:rope_access/models/cart_model.dart';
import 'package:rope_access/models/transaction_model.dart';
import 'package:http/http.dart' as http;
import 'package:rope_access/storage/app_storage.dart';

class TransactionRepository {
  Future<TransactionModel> checkout(
      {required String address,
      required int totalPrice,
      required List<CartModel> carts}) async {
    print(address);
    print(totalPrice);
    print(carts);
    try {
      final String token = await AppStorage().read('token');
      final res = await http.post(Uri.parse(ApiConstant.checkout),
          headers: {
            'Content-type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(
            {
              'address': address,
              'items': carts
                  .map((cart) =>
                      {'id': cart.product.id, 'quantity': cart.quantity})
                  .toList(),
              'status': 'PENDING',
              'total_price': totalPrice,
            },
          ));

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
      print(jsonDecode(res.body));
      TransactionModel transactionModel =
          TransactionModel.fromJson(jsonDecode(res.body)['data']);

      print('-' * 100);
      print(transactionModel);
      print('-' * 100);
      return transactionModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionModel>> getAllTransaction() async {
    try {
      final String token = await AppStorage().read('token');
      final res = await http.get(Uri.parse(ApiConstant.transactions), headers: {
        'Accept-type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (res.statusCode != 200) {
        print('-' * 100);
        print('${jsonDecode(res.body)} data transaction');
        print('-' * 100);
        throw jsonDecode(res.body)['message'];
      }
      print('-' * 100);
      print('${jsonDecode(res.body)} data transaction');
      print('-' * 100);
      return List.from(jsonDecode(res.body)['data'])
          .map((transaction) => TransactionModel.fromJson(transaction))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
