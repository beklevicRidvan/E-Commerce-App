import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../repository/database_repository.dart';
import '../tools/locator.dart';
import '../view/product_page_view.dart';
import 'product_page_view_model.dart';

class CategoriesPageViewModel with ChangeNotifier{
  List<CategoryModel> _categories=[];

  List<CategoryModel> get categories => _categories;

  final DatabaseRepository _repo = locator<DatabaseRepository>();


  CategoriesPageViewModel(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }


  void getData()async{
    _categories = await _repo.getCategories();
    notifyListeners();
  }

  void goProductsByCategoryId(BuildContext context,dynamic categoryId){
    MaterialPageRoute  pageRoute = MaterialPageRoute(builder: (context) {
      return ChangeNotifierProvider(create: (context) => ProductPageViewModel(categoryId: categoryId),child: const ProductPageView(),);

    },);
    Navigator.push(context, pageRoute);
  }
}