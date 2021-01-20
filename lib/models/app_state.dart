import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../models/user_model.dart';
import '../reducer/app_reducer.dart';

@immutable
class AppState {
  final User user;
  final Load isLoading;
  final List<Product> product;

  AppState({@required this.user, this.isLoading, this.product});

  factory AppState.initial() {
    return AppState(user: null, isLoading: Load.Fetched, product: []);
  }

  @override
  String toString() =>
      'AppState(user: $user, isLoading: $isLoading, product: $product)';
}
