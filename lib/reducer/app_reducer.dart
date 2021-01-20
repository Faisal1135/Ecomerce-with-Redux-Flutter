import 'package:flutter_ecomerce/models/app_state.dart';
import 'package:flutter_ecomerce/models/product.dart';
import 'package:flutter_ecomerce/models/user_model.dart';
import 'package:flutter_ecomerce/reducer/actions.dart';

AppState appReducer(state, action) {
  return AppState(
    user: userReducer(state.user, action),
    isLoading: loadingReducer(state.isLoading, action),
    product: productReducer(state.product, action),
    carts: cartReducer(state.carts, action),
  );
}

cartReducer(carts, action) {
  print(carts.toString());
  if (action is AddToCart) {
    return action.carts;
  }
  return carts;
}

productReducer(List<Product> product, action) {
  if (action is GetProducts) {
    return action.product;
  }
  return product;
}

Load loadingReducer(Load isLoading, action) {
  if (action == Load.Loading) {
    return Load.Loading;
  }
  if (action == Load.Fetched) {
    return Load.Fetched;
  }
  if (action == Load.Error) {
    return Load.Error;
  }

  return isLoading;
}

enum Load { Loading, Error, Fetched }

User userReducer(User user, action) {
  if (action is GetUser) {
    return action.user;
  }
  if (action is LogoutUserAction) {
    return action.user;
  }

  return user;
}
