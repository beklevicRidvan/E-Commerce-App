
import 'package:firestore_ecommerce_app/model/user_model.dart';

import '../model/product_model.dart';

abstract class DatabaseBase{
  Future<dynamic> getCategories();
  Future<dynamic> getUser();
  Future<dynamic> getProducts(dynamic categoryId);
  Future<dynamic> addProductForBasket(dynamic userId,ProductModel productModel);
  Future<dynamic> getProductsInBasket(dynamic userId);
  Future<dynamic> deleteProductForBasket(dynamic userId,ProductModel productModel);
  Future<dynamic> addFavorites(dynamic userId,ProductModel productModel);
  Future<dynamic> getProductsInFavorites(dynamic userId);
  Future<dynamic> deleteFavorites(dynamic userId,ProductModel productModel);

}