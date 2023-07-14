// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String address;
  final String handphone;

  final String token;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.handphone,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      handphone: json['handphone'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'handphone': handphone,
      'token': token,
    };
  }

  @override
  List<Object?> get props => [id, name, email, address, handphone, token];
}
