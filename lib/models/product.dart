import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  dynamic id;
  String name;
  String description;
  dynamic picture;
  double price;
  Product({
    @required this.id,
    @required this.name,
    @required this.description,
    this.picture,
    @required this.price,
  });

  Product copyWith({
    dynamic id,
    String name,
    String description,
    String picture,
    double price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      picture: picture ?? this.picture,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'picture': picture,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      picture: map['picture'][0]["formats"]["thumbnail"]["url"],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
