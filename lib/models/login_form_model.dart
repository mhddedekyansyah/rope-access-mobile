// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginFormModel {
  final String email;
  final String password;
  LoginFormModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
