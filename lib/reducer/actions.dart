// Users Actions

import 'package:flutter_ecomerce/helpers/final_and_const.dart';
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
