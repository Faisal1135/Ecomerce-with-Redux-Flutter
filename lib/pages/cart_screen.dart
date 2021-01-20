import 'package:flutter/material.dart';
import '../helpers/final_and_const.dart';
import '../models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'cartScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Carts'),
        ),
        body: Container(
          child: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              final carts = state.carts;
              return Column(
                children: [
                  Text('Total'),
                  Text(carts.total.toStringAsFixed(2)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: carts.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final prod = carts.products[index];
                        var netPrice = prod.price * prod.qty;

                        return ListTile(
                          leading: Image.network(BASE_URL + prod.imageUrl),
                          title: Text(prod.name),
                          subtitle: Text(prod.price.toString() +
                              'x' +
                              prod.qty.toString()),
                          trailing: Text(netPrice.toStringAsFixed(2)),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
