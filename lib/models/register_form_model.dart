import 'package:equatable/equatable.dart';

class RegisterFormModel extends Equatable {
  final String name;
  final String email;
  final String address;
  final String handphone;
  final String password;

  const RegisterFormModel({
    required this.name,
    required this.email,
    required this.address,
    required this.handphone,
    required this.password,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'handphone': handphone,
      'password': password
    };
  }

  @override
  List<Object?> get props => [name, email, address, handphone, password];
}
