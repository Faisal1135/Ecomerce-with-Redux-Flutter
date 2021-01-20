// Users Actions

import 'package:flutter_ecomerce/helpers/final_and_const.dart';
import 'package:flutter_ecomerce/models/cart_model.dart';
import 'package:flutter_ecomerce/models/product.dart';
import 'package:flutter_ecomerce/models/user_model.dart';
import 'package:flutter_ecomerce/reducer/app_reducer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  store.dispatch(Load.Loading);
  final pref = await SharedPreferences.getInstance();
  final storeUser = pref.getString("user");
  final user = storeUser != null ? User.fromJson(storeUser) : null;

  store.dispatch(GetUser(user));
  store.dispatch(Load.Fetched);
};

ThunkAction<AppState> getProducts = (Store<AppState> store) async {
  store.dispatch(Load.Loading);
  List<Product> parseItem = [];
  await dio.get('/products').then((res) {
    final fetchedProd = List.from(res.data);
    fetchedProd.forEach((element) {
      parseItem.add(Product.fromMap(element));
      store.dispatch(Load.Fetched);
    });
    store.dispatch(GetProducts(parseItem));
  });
};

ThunkAction<AppState> toogleCartAction(Product product) {
  return (Store<AppState> store) {
    final cartItem = CartItem.cartFromProduct(product);
    final storeCart = store.state.carts;
    final currentCartitem = [...storeCart.products];
    int index = currentCartitem.indexWhere((cart) => cart.id == cartItem.id);

    if (index > -1) {
      currentCartitem.removeAt(index);
      var newQty = storeCart.products[index].qty + 1;

      var newItem = cartItem.copyWith(qty: newQty);
      print(newItem.toString());
      currentCartitem.insert(index, newItem);
      final newCarts = storeCart.copyWith(products: currentCartitem);
      store.dispatch(AddToCart(newCarts));
    } else {
      currentCartitem.add(cartItem);

      final newCarts = storeCart.copyWith(products: [
        ...currentCartitem,
      ]);

      store.dispatch(AddToCart(newCarts));
    }
  };
}

class AddToCart {
  final Carts _carts;
  Carts get carts => this._carts;

  AddToCart(this._carts);
}

class GetProducts {
  final List<Product> _product;
  get product => this._product;

  GetProducts(this._product);
}

class GetUser {
  final User _user;

  get user => this._user;

  GetUser(this._user);
}

ThunkAction<AppState> logoutUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');
  User user;
  store.dispatch(LogoutUserAction(user));
};

class LogoutUserAction {
  final User _user;

  User get user => this._user;

  LogoutUserAction(this._user);
}
