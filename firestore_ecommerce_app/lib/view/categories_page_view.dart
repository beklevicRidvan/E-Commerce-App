import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../tools/constants.dart';
import '../view_model/categories_page_view_model.dart';

class CategoriesPageView extends StatelessWidget {
  const CategoriesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesPageViewModel>(
      builder: (context, value, child) {
        if (value.categories.isNotEmpty) {
          return GridView.builder(
              padding: Constants.normalPadding(),
              itemCount: value.categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 300,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                var currentElement = value.categories[index];
                return _buildListItem(context,currentElement);
              });
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

   _buildListItem(BuildContext context,CategoryModel currentElement) {
    CategoriesPageViewModel viewModel = Provider.of<CategoriesPageViewModel>(context,listen: false);
    return GestureDetector(
      onTap: (){
        viewModel.goProductsByCategoryId(context, currentElement.categoryId);
      },
      child: Container(
        color: Colors.blueGrey.shade50.withOpacity(0.4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
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
                image: NetworkImage(currentElement.categoryImage),
                fit: BoxFit.contain),
            Text(currentElement.categoryName,style:  TextStyle(fontWeight: FontWeight.bold,fontSize: Constants.getFontSize(18)),)
          ],
        ),
      ),
    );
  }
}
