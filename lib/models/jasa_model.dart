import 'package:equatable/equatable.dart';

class JasaModel extends Equatable {
  int? id;
  String? name;
  dynamic price;
  String? description;
  String? handphone;
  List<Galleries>? galleries;

  JasaModel({
    this.id,
    this.name,
    this.price,
    this.handphone,
    this.galleries,
    this.description,
  });

  factory JasaModel.fromJson(Map<String, dynamic> json) {
    return JasaModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        description: json['description'],
        handphone: json['handphone'],
        galleries: json['galleries'] != null
            ? List.from(json['galleries'])
                .map((gallery) => Galleries.fromJson(gallery))
                .toList()
            : <Galleries>[]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['handphone'] = handphone;
    if (galleries != null) {
      data['galleries'] = galleries!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props =>
      [id, name, price, description, handphone, galleries];
}

class Galleries {
  int? id;
  dynamic jasaId;

  String? image;

  Galleries({
    this.id,
    this.jasaId,
    this.image,
  });

  factory Galleries.fromJson(Map<String, dynamic> json) {
    return Galleries(
        id: json['id'], jasaId: json['jasa_id'], image: json['image']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['jasa_id'] = jasaId;
    data['image'] = image;
    return data;
  }
}
