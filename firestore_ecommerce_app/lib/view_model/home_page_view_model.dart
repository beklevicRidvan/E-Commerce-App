import 'package:flutter/material.dart';

import '../view/basket_page_view.dart';
import '../view/categories_page_view.dart';
import '../view/favorites_page_view.dart';
import '../view/profile_page_view.dart';

class HomePageViewModel with ChangeNotifier{

  int _selectedIndex = 0;
  late CategoriesPageView _categoriesPageView;
  late FavoritesPageView _favoritesPageView;
  late BasketPageView _basketPageView;
  late ProfilePageView _profilePageView;
  late List<Widget> _widgetList;
  late final PageController controller;



  void changeIndex(int value){
    _selectedIndex = value;
    notifyListeners();
  }

  HomePageViewModel(){
    controller= PageController(initialPage: _selectedIndex);
    _categoriesPageView = const CategoriesPageView();
    _favoritesPageView = const FavoritesPageView();
    _basketPageView = const BasketPageView();
    _profilePageView = const ProfilePageView();
    _widgetList = [_categoriesPageView,_favoritesPageView,_basketPageView,_profilePageView];
  }

  int get selectedIndex => _selectedIndex;

  List<Widget> get widgetList => _widgetList;

}