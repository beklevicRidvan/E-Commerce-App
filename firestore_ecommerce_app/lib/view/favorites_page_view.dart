import 'package:firestore_ecommerce_app/model/product_model.dart';
import 'package:firestore_ecommerce_app/view_model/favorites_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../tools/constants.dart';

class FavoritesPageView extends StatelessWidget {
  const FavoritesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesPageViewModel>(
      builder: (context, value, child) {
        if (value.productInFavorites.isNotEmpty) {
          return ListView.builder(
            itemCount: value.productInFavorites.length,
            itemBuilder: (context, index) {
              var currentElement = value.productInFavorites[index];
              return _buildListItem(currentElement, value, index);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Constants.circularProgressColor,
            ),
          );
        }
      },
    );
  }

  Widget _buildListItem(
      ProductModel currentElement, FavoritesPageViewModel value, int index) {
    return Dismissible(
      key: Key(currentElement.productId),
      onDismissed: (direction) => value.deleteFavorite(index),
      child: Container(
        padding: Constants.normalPadding(),
        color: Colors.blueGrey.shade50.withOpacity(0.4),
        margin: const EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(
                  height: 200,
                  fit: BoxFit.contain,
                  image: NetworkImage(currentElement.productImage),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Image.asset(
                        Constants.basketPagePlaceHolderImageAdress,
                        height: 100,
                      );
                    }
                  },
                ),
                Column(
                  children: [
                    Text(
                      Constants.getSpliceWord(currentElement.productName),
                      style: Constants.getNormalTextStyle(15),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text("${currentElement.productPrice} TL"),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
