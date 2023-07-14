import 'dart:convert';

import 'package:rope_access/api/api_constant.dart';
import 'package:rope_access/models/login_form_model.dart';
import 'package:rope_access/models/register_form_model.dart';
import 'package:rope_access/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  //* NOTE: This Function to use for register user
  Future<UserModel> register(RegisterFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse(ApiConstant.register),
        headers: {
          'Accept': 'application/json',
        },
        body: data.toJson(),
      );
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
      UserModel user = UserModel.fromJson(jsonDecode(res.body)['data']['user']);

      // return UserModel.fromJson(
      //     jsonDecode(res.body)['data']['user'], data.password);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  // * NOTE : This Function to use for login user
  Future<UserModel> login(LoginFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse(ApiConstant.login),
        headers: {
          'Accept': 'application/json',
        },
        body: data.toJson(),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return UserModel.fromJson(jsonDecode(res.body)['data']['user']);
    } catch (e) {
      rethrow;
    }
  }

  // * NOTE : This Function to use for logout user
  Future<void> logout(String token) async {
    try {
      await http.post(Uri.parse(ApiConstant.logout), headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });
    } catch (e) {
      rethrow;
    }
  }
}
