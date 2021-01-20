import 'package:flutter/material.dart';
import 'package:flutter_ecomerce/auth/screens/login_screen.dart';
import 'package:flutter_ecomerce/auth/screens/register_screen.dart';
import 'package:flutter_ecomerce/models/app_state.dart';
import 'package:flutter_ecomerce/pages/cart_screen.dart';
import 'package:flutter_ecomerce/products/product_screen.dart';
import 'package:flutter_ecomerce/reducer/app_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({Key key, this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.cyan.shade400,
          accentColor: Colors.deepOrange.shade200,
          textTheme: TextTheme(
            bodyText2: const TextStyle(fontSize: 18.0),
            headline5:
                const TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            headline2:
                const TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductScreen(),
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          ProductScreen.routeName: (context) => ProductScreen(),
          CartScreen.routeName: (context) => CartScreen(),
        },
      ),
    );
  }
}
