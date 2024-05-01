import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../repository/database_repository.dart';
import '../tools/constants.dart';
import '../tools/locator.dart';

class BasketPageViewModel with ChangeNotifier{
  late Stream<List<ProductModel>> _stream;
  List<ProductModel> _productsInBasket=[];


  final DatabaseRepository _repository = locator<DatabaseRepository>();

  BasketPageViewModel(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }


  void getData()async{
    _stream = await _repository.getProductsInBasket(Constants.userId);
    _stream.listen((data) {
      _productsInBasket = data;
      notifyListeners();
    });

  }

  void deleteData(int index)async{
    await _repository.deleteProductForBasket(Constants.userId, productsInBasket[index]);
  }



  List<ProductModel> get productsInBasket => _productsInBasket;
}