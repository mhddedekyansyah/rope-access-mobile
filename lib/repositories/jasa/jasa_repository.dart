import 'dart:convert';

import 'package:rope_access/api/api_constant.dart';
import 'package:rope_access/models/jasa_model.dart';
import 'package:http/http.dart' as http;
import 'package:rope_access/storage/app_storage.dart';

class JasaRepository {
  Future<List<JasaModel>> getAllJasa() async {
    try {
      final String token = await AppStorage().read('token');
      final res = await http.get(
        Uri.parse(ApiConstant.jasa),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return List.from(jsonDecode(res.body)['data']['jasas'])
          .map((product) => JasaModel.fromJson(product))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
