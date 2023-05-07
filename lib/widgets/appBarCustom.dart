import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  String title;
  AppBarCustom({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title:  Text("title"),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50)),
      ),
    );
  }
}
