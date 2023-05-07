import 'package:ecommerce_app/commn/routes.dart';
import 'package:ecommerce_app/network/dioHelper.dart';
import 'package:ecommerce_app/screens/addProduct/addProductScreen.dart';
import 'package:ecommerce_app/screens/home/homeScreen.dart';
import 'package:ecommerce_app/screens/login/loginScreen.dart';
import 'package:ecommerce_app/screens/singleProduct/singleProductScreen.dart';
import 'package:flutter/material.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.routeLogin: (context)=> LoginScreen(),
        Routes.routeHome : (context)=> HomeScreen(),
        Routes.routeSingleProduct : (context)=> SingleProductScreen(),
        Routes.routeAddProduct : (context)=> AddProductScreen()
      },
      initialRoute: Routes.routeLogin,
    );
  }
}
