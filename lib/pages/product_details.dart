import 'package:flutter/material.dart';
import '../helpers/final_and_const.dart';
import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product item;
  ProductDetailPage({this.item});

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = BASE_URL + item.picture;
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Container(
        decoration: kgradientBackground,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Hero(
                  tag: item,
                  child: Image.network(pictureUrl,
                      width: orientation == Orientation.portrait ? 600 : 250,
                      height: orientation == Orientation.portrait ? 400 : 200,
                      fit: BoxFit.cover)),
            ),
            Text(item.name, style: Theme.of(context).textTheme.headline5),
            Text('\$${item.price}',
                style: Theme.of(context).textTheme.bodyText1),
            Flexible(
                child: SingleChildScrollView(
                    child: Padding(
                        child: Text(item.description),
                        padding: EdgeInsets.only(
                            left: 32.0, right: 32.0, bottom: 32.0))))
          ],
        ),
      ),
    );
  }
}
