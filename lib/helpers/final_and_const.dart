import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecomerce/auth/screens/register_screen.dart';
import 'package:flutter_ecomerce/models/app_state.dart';
import 'package:flutter_ecomerce/reducer/actions.dart';
import 'package:flutter_redux/flutter_redux.dart';

const BASE_URL = "http://1aa8a900febd.ngrok.io";

final dio = Dio(BaseOptions(baseUrl: BASE_URL));

final kgradientBackground = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        stops: [
      0.1,
      0.3,
      0.5,
      0.7,
      0.9
    ],
        colors: [
      Colors.deepOrange[300],
      Colors.deepOrange[400],
      Colors.deepOrange[500],
      Colors.deepOrange[600],
      Colors.deepOrange[700]
    ]));

final kappBar = PreferredSize(
  preferredSize: Size.fromHeight(30),
  child: StoreConnector<AppState, AppState>(
    converter: (store) => store.state,
    builder: (context, state) {
      return AppBar(
        centerTitle: true,
        title: SizedBox(
            child: state.user != null
                ? Text(state.user.username)
                : FlatButton(
                    child: Text('Register Here',
                        style: Theme.of(context).textTheme.bodyText1),
                    onPressed: () => Navigator.pushNamed(
                        context, RegisterScreen.routeName))),
        leading: state.user != null
            ? IconButton(
                icon: Icon(Icons.store),
                onPressed: () => Navigator.pushNamed(context, '/cart'))
            : Text(''),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: StoreConnector<AppState, VoidCallback>(
              converter: (store) => () => store.dispatch(logoutUserAction),
              builder: (_, callback) {
                return state.user != null
                    ? IconButton(
                        icon: Icon(Icons.exit_to_app), onPressed: callback)
                    : Text('');
              },
            ),
          ),
        ],
      );
    },
  ),
);
