import 'package:firestore_ecommerce_app/model/product_model.dart';


import '../base/database_base.dart';
import '../service/firestore/firestore_service.dart';
import '../tools/locator.dart';

class DatabaseRepository extends DatabaseBase{

  final FirestoreService _service= locator<FirestoreService>();

  @override
  Future addFavorites(dynamic userId, ProductModel productModel) async{
    // TODO: implement addFavorites
   return await _service.addFavorites(userId, productModel);
  }

  @override
  Future addProductForBasket(dynamic userId, ProductModel productModel) async{
    // TODO: implement addProductForBasket
    return await _service.addProductForBasket(userId, productModel);
  }

  @override
  Future deleteFavorites(dynamic userId, ProductModel productModel) async{
    await _service.deleteFavorites(userId, productModel);
  }

  @override
  Future deleteProductForBasket(dynamic userId, ProductModel productModel) async{
    await _service.deleteProductForBasket(userId, productModel);
  }

  @override
  Future getProducts(dynamic categoryId) async{
    return await _service.getProducts(categoryId);
  }

  @override
  Future getProductsInBasket(dynamic userId) async{
    return await _service.getProductsInBasket(userId);
  }

  @override
  Future getProductsInFavorites(dynamic userId) async{
   return await _service.getProductsInFavorites(userId);
  }

  @override
  Future getCategories() async{
    return await _service.getCategories();
  }

  @override
  Future getUser() async{
    return await _service.getUser();
  }
  

}