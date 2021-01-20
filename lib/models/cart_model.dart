import 'package:flutter/foundation.dart';

import 'package:flutter_ecomerce/models/product.dart';

class Carts {
  final dynamic id;
  List<CartItem> products;

  Carts({this.id, @required this.products});

  set addToCart(CartItem product) {
    this.products = [...this.products, product];
  }

  removeFromCart(CartItem product) {
    final searchprod =
        this.products.firstWhere((element) => element == product);
    if (searchprod != null) {
      final newProd = [...this.products];
      newProd.remove(searchprod);
      this.products = [...newProd];
    }
  }

  bool isInCart(dynamic id) =>
      this.products.indexWhere((prod) => prod.id == id) > -1;

  double get total {
    if (this.products.isEmpty) {
      return 0;
    }
    return this
        .products
        .map((prod) => prod.price * prod.qty)
        .reduce((price, nextprice) => price + nextprice);
  }

  factory Carts.init() {
    return Carts(products: [], id: DateTime.now().microsecondsSinceEpoch);
  }

  Carts copyWith({
    dynamic id,
    List<CartItem> products,
  }) {
    return Carts(
      id: id ?? this.id,
      products: products ?? this.products,
    );
  }

  @override
  String toString() => 'Carts(id: $id, products: $products)';
}

class CartItem {
  final dynamic id;
  final String name;
  final double price;
  final String imageUrl;
  int qty;

  CartItem({this.id, this.name, this.price, this.imageUrl, this.qty});

  factory CartItem.cartFromProduct(Product product) {
    return CartItem(
        id: product.id,
        price: product.price,
        name: product.name,
        imageUrl: product.picture,
        qty: 1);
  }

  CartItem copyWith({
    dynamic id,
    String name,
    double price,
    String imageUrl,
    int qty,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      qty: qty ?? this.qty,
    );
  }

  @override
  String toString() {
    return 'CartItem(id: $id, name: $name, price: $price, imageUrl: $imageUrl, qty: $qty)';
  }
}
