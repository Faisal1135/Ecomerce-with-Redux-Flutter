import 'package:flutter/material.dart';
import '../helpers/final_and_const.dart';
import '../models/app_state.dart';
import '../pages/product_item.dart';
import '../reducer/actions.dart';
import '../reducer/app_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = "productScren";

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    StoreProvider.of<AppState>(context).dispatch(getProducts);
    StoreProvider.of<AppState>(context).dispatch(getUserAction);
    return Scaffold(
      appBar: kappBar,
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                  child: state.isLoading == Load.Loading
                      ? CircularProgressIndicator()
                      : SafeArea(
                          top: false,
                          bottom: false,
                          child: GridView.builder(
                            itemCount: state.product.length,
                            itemBuilder: (BuildContext context, int index) {
                              final prod = state.product[index];
                              return ProductItem(item: prod);
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: orientation ==
                                            Orientation.portrait
                                        ? 2
                                        : 3,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0,
                                    childAspectRatio:
                                        orientation == Orientation.portrait
                                            ? 1.0
                                            : 1.3),
                          ),
                        )),
            ],
          );
        },
      ),
    );
  }
}
