import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../tools/constants.dart';
import '../view_model/home_page_view_model.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text("E COMMERCE",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
      backgroundColor: Colors.red,
      centerTitle: true,

    );
  }

  _buildBody() {
    return Consumer<HomePageViewModel>(builder: (context, viewModel, child) {
     return PageView.builder(physics: const NeverScrollableScrollPhysics(),controller: viewModel.controller,itemCount: viewModel.widgetList.length,itemBuilder: (context, index) {
       return viewModel.widgetList[index];
     },);
    },);
  }

  _buildBottomNavigationBar(BuildContext context){

  return Consumer<HomePageViewModel>(builder:  (context, viewModel, child) {

    return BottomNavigationBar(


        selectedItemColor: Constants.bottomSelectedItemColor,

        iconSize: 30,
        selectedIconTheme: const IconThemeData(size: 40),

        onTap: (value) {
          viewModel.changeIndex(value);
          viewModel.controller.animateToPage(value, duration: const Duration(milliseconds: 500), curve: Curves.easeOutBack);
        },

        backgroundColor: Colors.red,
        currentIndex: viewModel.selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildBottomNavigationBarItem(const Icon(Icons.home_outlined,), const Icon(Icons.home)),
          _buildBottomNavigationBarItem(const Icon(Icons.favorite_border,), const Icon(Icons.favorite)),
          _buildBottomNavigationBarItem(const Icon(Icons.shopping_bag_outlined,), const Icon(Icons.shopping_bag)),
          _buildBottomNavigationBarItem(const Icon(Icons.person_2_outlined,), const Icon(Icons.person)),
        ]);
  },);
  }
  _buildBottomNavigationBarItem(Icon icon,Icon activedIcon){
    return BottomNavigationBarItem(icon: icon,label: "",activeIcon: activedIcon);
  }
}
