import 'package:firestore_ecommerce_app/tools/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../view_model/product_page_view_model.dart';

class ProductDetailPageView extends StatelessWidget {
  final ProductModel product;
  const ProductDetailPageView({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.red,
      title: const Text("DETAİL PAGE"),
    );
  }

  _buildBody(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                height: 500,
                image: NetworkImage(product.productImage),
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : Image.asset(
                            Constants.basketPagePlaceHolderImageAdress),
              ),
              Text(
                product.productName,
                style: Constants.getNormalTextStyle(16),
              ),
              ChangeNotifierProvider.value(
                value: product,
                child: _buildBasketConsumer(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildBasketConsumer(BuildContext context) {
    ProductPageViewModel value =
        Provider.of<ProductPageViewModel>(context, listen: false);
    return Consumer<ProductModel>(
      builder: (context, product, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${product.counter != 0 ? (product.productPrice * product.counter).toStringAsFixed(3) : product.productPrice} TL",
              style: Constants.productMoneyTextStyle(),
            ),
            ElevatedButton(
                onPressed: () {
                  value.changeButtonState(value.stateValue);
                },
                child: value.stateValue
                    ? Row(
                        children: [
                          IconButton(
                              onPressed: () => product.reduce(),
                              icon: const Icon(CupertinoIcons.minus)),
                          Text(product.counter.toString()),
                          IconButton(
                              onPressed: () => product.increase(),
                              icon: const Icon(Icons.add)),
                          IconButton(
                              onPressed: () {
                                value.changeButtonState(value.stateValue);
                                if (product.counter != 0) {
                                  value.addBasketByProduct(product);
                                }
                              },
                              icon: const Icon(Icons.check))
                        ],
                      )
                    : const Text("SEPETE EKLE"))
          ],
        );
      },
    );

  }

}
