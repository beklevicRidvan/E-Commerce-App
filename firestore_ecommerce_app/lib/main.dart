import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_ecommerce_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tools/locator.dart';
import 'view/home_page_view.dart';
import 'view_model/basket_page_view_model.dart';
import 'view_model/categories_page_view_model.dart';
import 'view_model/favorites_page_view_model.dart';
import 'view_model/home_page_view_model.dart';
import 'view_model/profile_page_view_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => HomePageViewModel(),),
        ChangeNotifierProvider(create: (context) => CategoriesPageViewModel(),),
        ChangeNotifierProvider(create: (context) => FavoritesPageViewModel(),),
        ChangeNotifierProvider(create: (context) => BasketPageViewModel(),),
        ChangeNotifierProvider(create: (context) => ProfilePageViewModel(),),
      ],child: const HomePageView(),)
    );
  }
}
