import 'package:flutter/material.dart';
import '../helpers/final_and_const.dart';
import '../models/app_state.dart';
import '../models/product.dart';
import '../pages/product_details.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProductItem extends StatelessWidget {
  final Product item;
  ProductItem({this.item});

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = BASE_URL + item.picture;
    return InkWell(
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return ProductDetailPage(item: item);
      })),
      child: GridTile(
        footer: GridTileBar(
            title: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(item.name, style: TextStyle(fontSize: 20.0))),
            subtitle: Text("\$${item.price}", style: TextStyle(fontSize: 16.0)),
            backgroundColor: Color(0xBB000000),
            trailing: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (_, state) {
                  return state.user != null
                      ? IconButton(
                          icon: Icon(Icons.shopping_cart),
                          color: Colors.white,
                          onPressed: () => print('pressed'))
                      : Text('');
                })),
        child: Hero(
          tag: item,
          child: Image.network(pictureUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
