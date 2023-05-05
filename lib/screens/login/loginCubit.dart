import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/commn/endPoints.dart';
import 'package:ecommerce_app/commn/routes.dart';
import 'package:ecommerce_app/network/dioHelper.dart';
import 'package:ecommerce_app/screens/login/loginStates.dart';
import 'package:ecommerce_app/screens/home/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static bool passValue = true;

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String username,
    required String password,
    required BuildContext context,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: login,
      data: {"username": username, "password": password},
    ).then((value) {
      print(value.data);
      emit(LoginSuccessState());
      Navigator.pushReplacementNamed(context, Routes.routeHome);
    }).catchError((error) {
      showMessage(error.toString(), context);
      emit(LoginErrorState(error.toString()));
    });
  }

  void visablePass() {
    if (passValue == true) {
      passValue = false;
    } else {
      passValue = true;
    }
    emit(visablePassState());
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
    emit(LoginShowMessageState());
  }
}
