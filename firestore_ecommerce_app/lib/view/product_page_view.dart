import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../tools/constants.dart';
import '../view_model/product_page_view_model.dart';
import 'basket_page_view.dart';

class ProductPageView extends StatefulWidget {
  const ProductPageView({super.key});

  @override
  State<ProductPageView> createState() => _ProductPageViewState();
}

class _ProductPageViewState extends State<ProductPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: Consumer<ProductPageViewModel>(
          builder: (context, value, child) {
            return AppBar(
              iconTheme: const IconThemeData(color: Colors.white,),
              title: value.textFieldState
                  ? CupertinoSearchTextField(
                      onChanged: (myValue) {
                        value.getSearchingData(myValue);
                      },
                      backgroundColor: Colors.white,
                    )
                  :  Text("Products",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: Constants.getFontSize(25)),),
              backgroundColor: Colors.red,
              actionsIconTheme: const IconThemeData(
                size: 35,
                color: Colors.white,
                applyTextScaling: true,
              ),
              actions: [
                Stack(
                  children: [
                    ButtonBar(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              value.changeFieldState(value.textFieldState);
                            },
                            icon: value.textFieldState
                                ? const Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  )
                                : const Icon(Icons.search)),
                        IconButton(
                            onPressed: () {
                              value.goBasketPage(context);
                            },
                            icon: const Icon(Icons.shopping_cart_outlined)),
                      ],
                    ),
                    Positioned(
                        top: 5,
                        right: 5,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.white,
                          child: Text(value.productCount.toString(),style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                        )),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            );
          },
        ));
  }

  _buildBody() {
    return Consumer<ProductPageViewModel>(
      builder: (context, value, child) {
        if (value.products.isNotEmpty) {
          return GridView.builder(
            padding: Constants.normalPadding(),
            itemCount: value.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 300,
                mainAxisSpacing: 5,
                crossAxisSpacing: 15),
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: value.products[index],
                child: _buildListItem(context, index, value),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }
      },
    );
  }

  _buildListItem(
      BuildContext context, int index, ProductPageViewModel viewModel) {
    return Consumer<ProductModel>(
      builder: (context, product, child) {
        viewModel.isFavorited(product);
        return GestureDetector(
          onTap: () {
            viewModel.goDetailPage(context, product);
          },
          child: Stack(
            children: [
              Container(
                color: Colors.blueGrey.shade50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image(
                      image: NetworkImage(product.productImage),
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Image.asset(
                            Constants.basketPagePlaceHolderImageAdress,
                            fit: BoxFit.contain,
                          );
                        }
                      },
                      height: 200,
                    ),
                    Text(Constants.getSpliceWord(product.productName)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${product.productPrice} TL",
                          style: Constants.productMoneyTextStyle(),
                        ),
                        IconButton(
                            onPressed: () {
                              viewModel.addBasketByProduct(product);
                            },
                            icon: const Icon(
                              Icons.shopping_basket_outlined,
                              color: Colors.orange,
                              size: 30,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                      iconSize: 40,
                      onPressed: () {
                        if (product.isFavorited == false) {
                          viewModel.addFavoritesByProduct(product);
                        }

                        viewModel.deleteFavorited(product);
                      },
                      icon: product.isFavorited
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.red,
                            )))
            ],
          ),
        );
      },
    );
  }
}
