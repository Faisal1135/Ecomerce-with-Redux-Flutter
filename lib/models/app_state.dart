import 'package:flutter/foundation.dart';
import 'package:flutter_ecomerce/models/cart_model.dart';

import '../models/product.dart';
import '../models/user_model.dart';
import '../reducer/app_reducer.dart';

@immutable
class AppState {
  final User user;
  final Load isLoading;
  final List<Product> product;
  final Carts carts;

  AppState({@required this.user, this.isLoading, this.product, this.carts});

  factory AppState.initial() {
    return AppState(
        user: null, isLoading: Load.Fetched, product: [], carts: Carts.init());
  }

  @override
  String toString() =>
      'AppState(user: $user, isLoading: $isLoading, product: $product)';
}
