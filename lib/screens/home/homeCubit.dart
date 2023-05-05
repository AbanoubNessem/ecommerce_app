import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/commn/endPoints.dart';
import 'package:ecommerce_app/network/dioHelper.dart';
import 'package:ecommerce_app/screens/home/homeStates.dart';
import 'package:ecommerce_app/screens/home/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<dynamic> Products = [];

  void GetDataProducts() {
    emit(HomeLoadingState());
    DioHelper.getData(
      url: products,
    ).then((value) {
      Products = value.data;
      print(Products);
      print(Products.length);
      print(Products[0]["title"]);
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState(error.toString()));
    });
  }
}
