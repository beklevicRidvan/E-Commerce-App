import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../repository/database_repository.dart';
import '../tools/locator.dart';

class FavoritesPageViewModel with ChangeNotifier{
  late Stream<List<ProductModel>>? _stream;
  List<ProductModel> _productInFavorites = [];
  String userId = "rHxujj8j9oGCysm4VJbk";



  final DatabaseRepository _repository = locator<DatabaseRepository>();



  FavoritesPageViewModel(){
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      getData(userId);
    });
  }



  void getData(dynamic userId)async{
    _stream =await _repository.getProductsInFavorites(userId);
    _stream!.listen((data) {
      _productInFavorites = data;
      notifyListeners();
    });

  }

  void deleteFavorite(int index)async{
    ProductModel productModel = _productInFavorites[index];
    await _repository.deleteFavorites(userId, productModel);
  }

  List<ProductModel> get productInFavorites => _productInFavorites;
}