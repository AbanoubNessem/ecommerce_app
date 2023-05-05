import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app/commn/colors.dart';
import 'package:ecommerce_app/commn/commnWidget.dart';

import 'package:ecommerce_app/screens/login/loginCubit.dart';
import 'package:ecommerce_app/screens/login/loginStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  var formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) print("done");
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
                  child: Form(
                    key: formKeyLogin,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Login now to continue",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        defaultTExtField(
                          controller: userName,
                          passValue: false,
                          type: TextInputType.name,
                          text: "User Name",
                          icons: Icons.person_outline,
                          validate: "Email in not correct",
                          context: context,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        defaultTExtField(
                          passValue: LoginCubit.passValue,
                          controller: password,
                          type: TextInputType.text,
                          text: "password",
                          context: context,
                          icons: Icons.lock_outline,
                          validate: "Password is too short",
                          iconData: Icons.remove_red_eye_outlined,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => ElevatedButton(
                                onPressed: () {
                                  if (formKeyLogin.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        username: userName.text,
                                        password: password.text,
                                        context: context);
                                  }
                                },
                                style: ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                    ),
                                    backgroundColor: MaterialStatePropertyAll(
                                        ColorsApp.mainColor)),
                                child: Text("Login")),
                            fallback: (context) => CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account ?"),
                            defaultTextButton(
                                function: () {
                                  print("sing up");
                                  LoginCubit.get(context)
                                      .showMessage("soon", context);
                                },
                                text: "SIGN UP")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
