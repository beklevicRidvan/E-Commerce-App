import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../tools/constants.dart';
import '../view_model/basket_page_view_model.dart';

class BasketPageView extends StatelessWidget {
  const BasketPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BasketPageViewModel>(
      builder: (context, value, child) {
        if (value.productsInBasket.isNotEmpty) {
          return ListView.builder(
            itemCount: value.productsInBasket.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                  value: value.productsInBasket[index],
                  child: _buildListItem(context, index));
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        }
      },
    );
  }

  _buildListItem(BuildContext context, int index) {
    return Consumer<ProductModel>(
      builder: (context, productInBasket, child) {
        return Dismissible(
          onDismissed: (direction) => context.read<BasketPageViewModel>().deleteData(index),
          key: Key(productInBasket.productId.toString()),
          child: Container(
            padding: Constants.normalPadding(),
            margin: const EdgeInsets.only(bottom: 5),
            color: Colors.blueGrey.shade50.withOpacity(0.4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image(
                      height: 200,
                        fit: BoxFit.contain,
                        image: NetworkImage(productInBasket.productImage),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Image.asset(
                                Constants.basketPagePlaceHolderImageAdress,height: 100,);
                          }
                        }),
                    Column(
                      children: [
                        Text(Constants.getSpliceWord(productInBasket.productName)),
                        const SizedBox(height: 30,),
                        Text(productInBasket.productPrice.toString()),
                      ],
                    )

                  ],
                ),

              ],

            ),
          ),
        );
      },
    );
  }
}
