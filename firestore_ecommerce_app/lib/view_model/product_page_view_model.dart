import 'package:firestore_ecommerce_app/service/firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../repository/database_repository.dart';
import '../tools/constants.dart';
import '../tools/locator.dart';
import '../view/alert_basket_view.dart';
import '../view/product_detail_page_view.dart';
import 'basket_page_view_model.dart';

class ProductPageViewModel with ChangeNotifier {
  dynamic categoryId;
  List<ProductModel> _products = [];
  bool _stateValue=false;
  int _productCount =0;
  bool _textFieldState = false;


  final DatabaseRepository _repository = locator<DatabaseRepository>();

  ProductPageViewModel({this.categoryId}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProductsData(categoryId);
      getProductCount();
    });
  }

  void getProductsData(dynamic categoryId) async {
    _products = await _repository.getProducts(categoryId);
    notifyListeners();
  }

  void isFavorited(ProductModel productModel) async {
    bool value =
        await FirestoreService.isFavorited(Constants.userId, productModel);
    productModel.setIsFavorited(value);
  }

  void deleteFavorited(ProductModel productModel) async {
    await _repository.deleteFavorites(Constants.userId, productModel);
  }

  void addFavoritesByProduct(ProductModel productModel) async {
    await _repository.addFavorites(Constants.userId, productModel);
  }




  void addBasketByProduct(ProductModel productModel) async {
    await _repository.addProductForBasket(Constants.userId, productModel);
  }

  void goDetailPage(BuildContext context, ProductModel product) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => ProductPageViewModel(),
        child: ProductDetailPageView(
          product: product,
        ),
      ),
    );
    Navigator.push(context, pageRoute);
  }

  void goBasketPage(BuildContext context){
   showDialog(context: context, builder: (context) => Dialog(child:  ChangeNotifierProvider(create:(context) =>  BasketPageViewModel(),child: const AlertBasketView(),),));
  }

  void changeButtonState(bool value) {
    _stateValue = !value;
    notifyListeners();
  }

  void changeFieldState(bool value){
    _textFieldState = !value;
    notifyListeners();
  }

  void getProductCount()async{
    _productCount = await FirestoreService.basketCount(categoryId: categoryId,userId: Constants.userId);
    notifyListeners();
  }

  void getSearchingData(String wantedValue,)async{
    _products  = await FirestoreService.getSearchingData(categoryId: categoryId,wantedValue: wantedValue);
    notifyListeners();
  }


  set productCount(int value) {
    _productCount = value;
    notifyListeners();
  }

  List<ProductModel> get products => _products;

  bool get stateValue => _stateValue;

  int get productCount => _productCount;

  bool get textFieldState => _textFieldState;
}
