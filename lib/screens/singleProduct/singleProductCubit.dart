import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/commn/endPoints.dart';
import 'package:ecommerce_app/network/dioHelper.dart';
import 'package:ecommerce_app/screens/singleProduct/singleProductStates.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SingleProductCubit extends Cubit<SingleProductStates> {
  SingleProductCubit() : super(SingleProductInitialState());

  static SingleProductCubit get(context) => BlocProvider.of(context);

  var Product;

  void GetDataProduct(int id) {
    emit(SingleProductLoadingState());
    DioHelper.getData(
      url: "$products/$id",
    ).then((value) {
      Product = value.data;
      print(Product);
      print(Product["title"]);
      emit(SingleProductSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SingleProductErrorState(error.toString()));
    });
  }

  void showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
    emit(SingleProductShowMessageState());
  }
}
