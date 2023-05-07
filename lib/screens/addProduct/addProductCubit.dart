
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/commn/endPoints.dart';
import 'package:ecommerce_app/commn/routes.dart';
import 'package:ecommerce_app/network/dioHelper.dart';
import 'package:ecommerce_app/screens/addProduct/addProductStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddProductCubit extends Cubit<AddProductStates> {
  AddProductCubit() : super(AddProductInitialState());

  static AddProductCubit get(context) => BlocProvider.of(context);


  File? imageSelect;

  Future GetImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if(image == null) return;

    final imageTemporary = File(image.path);
    imageSelect = imageTemporary;
    print(" image path = ${imageSelect}");
    emit(ImageState());

  }


  List<dynamic> cat = [];
  void GetCatProduct() {
    emit(CatLoadingState());
    DioHelper.getData(
      url:catOfProduct ,
    ).then((value) {
      cat = value.data;
      print(cat);
      // print(cat["title"]);
      emit(CatSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CatErrorState(error.toString()));
    });
  }


  // var productAdd ;
  void AddProduct({
    required String title,
    required String price,
    required String category,
    required String description,
    required String image,
    required List<dynamic> listProducts,
    required BuildContext context,
  }) {
    emit(AddProductLoadingState());
    DioHelper.postData(
      url: products,
      data: {
        "title":title,
        "price":price,
        "category":category,
        "description":description,
        "image":image
      },
    ).then((value) {
      print(value.data);
      // productAdd = value.data;
      listProducts.add(value.data);
      Navigator.pushReplacementNamed(context, Routes.routeHome);

      emit(AddProductSuccessState());
    }).catchError((error) {
      showMessage(error.toString(), context);
      print(error);
      emit(AddProductErrorState(error.toString()));
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
    emit(AddShowMessageState());
  }
}