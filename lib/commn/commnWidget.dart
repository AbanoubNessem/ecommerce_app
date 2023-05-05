import 'package:ecommerce_app/commn/colors.dart';
import 'package:ecommerce_app/screens/login/loginCubit.dart';
import 'package:flutter/material.dart';

Widget defaultTExtField({
  required TextEditingController controller,
  required TextInputType type,
  required String text,
  required IconData icons,
  required BuildContext context,
  IconData? iconData,
  required bool passValue,
  required String validate,
  Function()? onSubmit,
  Function()? onTap,
  bool isPassword = false,
}) =>
    TextFormField(
      decoration: InputDecoration(
          hintText: text,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorsApp.mainColor)),
          filled: true,
          suffixIcon: InkWell(
            onTap: () {
              LoginCubit.get(context).visablePass();
            },
            child: Icon(iconData, color: ColorsApp.mainColor),
          ),
          prefixIcon: Icon(icons, color: ColorsApp.mainColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.grey))),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return validate;
        }
        return null;
      },
      controller: controller,
      obscureText: passValue,
      keyboardType: type,
      onTap: onTap,
    );

Widget defaultTextButton({
  required Function() function,
  required String text,
}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: ColorsApp.mainColor),
        ));
