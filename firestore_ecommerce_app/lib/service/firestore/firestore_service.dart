import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ecommerce_app/model/product_model.dart';

import 'package:firestore_ecommerce_app/model/user_model.dart';

import '../../model/basket_model.dart';
import '../../model/favorite_model.dart';
import '../database_base_service.dart';

class FirestoreService extends DatabaseBaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future addFavorites(dynamic userId, ProductModel productModel) async {
    var favoritesRef =
        await _firestore.doc("users/$userId").collection("favorites").get();
    var maps = favoritesRef.docs;
    var favoriteList =
        maps.map((e) => FavoriteModel.fromMap(key: e.id, e.data())).toList();

    return await _firestore
        .doc("users/$userId")
        .collection("favorites")
        .doc(favoriteList[0].favoriteId)
        .collection("products")
        .doc(productModel.productId)
        .set(productModel.toMap(
            categoryKey: productModel.productCategory,
            productKey: productModel.productId));
  }

  @override
  Future addProductForBasket(dynamic userId, ProductModel productModel) async {
    var basketRef =
        await _firestore.doc("users/$userId").collection("basket").get();
    var maps = basketRef.docs;
    var basketList =
        maps.map((e) => BasketModel.fromMap(key: e.id, e.data())).toList();
    return await _firestore
        .doc("users/$userId")
        .collection("basket")
        .doc(basketList[0].basketId)
        .collection("products")
        .doc(productModel.productId)
        .set(productModel.toMap(
            productKey: productModel.productId,
            categoryKey: productModel.productCategory));
  }

  @override
  Future deleteFavorites(dynamic userId, ProductModel productModel) async {
    var basketRef =
        await _firestore.doc("users/$userId").collection("favorites").get();
    var maps = basketRef.docs;
    var favoritesList =
        maps.map((e) => FavoriteModel.fromMap(key: e.id, e.data())).toList();
    await _firestore
        .doc("users/$userId")
        .collection("favorites")
        .doc(favoritesList[0].favoriteId)
        .collection("products")
        .doc("${productModel.productId}")
        .delete();
  }

  @override
  Future deleteProductForBasket(
      dynamic userId, ProductModel productModel) async {
    var favoritesRef =
        await _firestore.doc("users/$userId").collection("favorites").get();
    var maps = favoritesRef.docs;
    var basketList =
        maps.map((e) => BasketModel.fromMap(key: e.id, e.data())).toList();
    await _firestore
        .doc("users/$userId")
        .collection("basket")
        .doc(basketList[0].basketId)
        .collection("products")
        .doc("${productModel.productId}")
        .delete();
  }

  @override
  Future getProducts(dynamic categoryId) async {
    List<ProductModel> products = [];
    var productRef = await _firestore
        .doc("categories/$categoryId")
        .collection("products")
        .get();
    var maps = productRef.docs;
    products = maps
        .map((e) => ProductModel.fromMap(productKey: e.id, e.data()))
        .toList();
    return products;
  }

  @override
  Future getProductsInBasket(dynamic userId) async {
    var basketRef =
        await _firestore.doc("users/$userId").collection("basket").get();
    var maps = basketRef.docs;
    var basketList =
        maps.map((e) => BasketModel.fromMap(key: e.id, e.data())).toList();
    return _firestore
        .doc("users/$userId")
        .collection("basket")
        .doc(basketList[0].basketId)
        .collection("products")
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((e) => ProductModel.fromMap(productKey: e.id, e.data()))
            .toList());
  }

  @override
  Future getProductsInFavorites(dynamic userId) async {
    var favoritesRef =
        await _firestore.doc("users/$userId").collection("favorites").get();
    var maps = favoritesRef.docs;
    var favoriteList =
        maps.map((e) => FavoriteModel.fromMap(key: e.id, e.data())).toList();
    return _firestore
        .doc("users/$userId")
        .collection("favorites")
        .doc(favoriteList[0].favoriteId)
        .collection("products")
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((e) => ProductModel.fromMap(productKey: e.id, e.data()))
            .toList());
  }

  @override
  Future getCategories() async {
    List<CategoryModel> categories = [];
    var collectionRef = await _firestore.collection("categories").get();

    var maps = collectionRef.docs;
    categories =
        maps.map((e) => CategoryModel.fromMap(e.data(), key: e.id)).toList();
    return categories;
  }

  @override
  Future getUser() async {
    List<UserModel> users = [];
    var collectionRef = await _firestore.collection("users").get();
    var documents = collectionRef.docs;

    users =
        documents.map((e) => UserModel.fromMap(e.data(), key: e.id)).toList();
    return users;
  }

  static Future<bool> isFavorited(
      dynamic userId, ProductModel productModel) async {
    var element = await FirebaseFirestore.instance
        .doc("users/$userId")
        .collection("favorites")
        .doc("hBiDER7GNnUcRyu6K3u2")
        .collection("products")
        .where("productId", isEqualTo: productModel.productId)
        .get();
    if (element.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<int> basketCount({dynamic categoryId, dynamic userId}) async {
    List<BasketModel> basket = [];
    var basketRef = await FirebaseFirestore.instance
        .doc("users/$userId")
        .collection("basket")
        .get();
    var maps = basketRef.docs;
    basket = maps.map((e) => BasketModel.fromMap(key: e.id, e.data())).toList();
    var element = await FirebaseFirestore.instance
        .doc("users/$userId")
        .collection("basket")
        .doc(basket[0].basketId)
        .collection("products")
        .where("productCategoryId", isEqualTo: categoryId)
        .get();
    var documents = element.docs;

    return documents.length;
  }

  static Future<List<ProductModel>> getSearchingData({dynamic categoryId,required String wantedValue})async{
    List<ProductModel> products= [];
    var collectionRef = await FirebaseFirestore.instance.doc("categories/$categoryId").collection("products").get();
    var maps = collectionRef.docs;
    products = maps.map((e) => ProductModel.fromMap(productKey: e.id,e.data()),).toList();
    List<ProductModel> wantedProducts = [];
    for(var element in products){
      if(element.productName.toLowerCase().contains(wantedValue.toLowerCase())){
        wantedProducts.add(element);
      }
    }
    return wantedProducts;

  }
}
