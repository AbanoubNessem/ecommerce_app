import 'package:ecommerce_app/commn/colors.dart';
import 'package:ecommerce_app/commn/commnWidget.dart';
import 'package:ecommerce_app/commn/routes.dart';
import 'package:ecommerce_app/screens/home/homeCubit.dart';
import 'package:ecommerce_app/screens/home/homeStates.dart';
import 'package:ecommerce_app/screens/singleProduct/singleProductScreen.dart';
import 'package:ecommerce_app/widgets/cardItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..GetDataProducts(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is HomeSuccessState) print("done");
        },
        builder: (context, state) {
          if (HomeCubit.get(context).Products.isEmpty) {
            HomeCubit.get(context).GetDataProducts();
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Home"),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: (){
                  print("FloatingActionButton");
                  Navigator.pushNamed(context, Routes.routeAddProduct);
                },
                child: Icon(Icons.add),
            ),
            body: HomeCubit.get(context).Products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.015),
                    margin: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.015),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: defaultTExtField(
                                  controller: search,
                                  type: TextInputType.text,
                                  text: "Search",
                                  icons: Icons.search_outlined,
                                  context: context,
                                  passValue: false,
                                  validate: "Enter word"),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            InkWell(
                              onTap: () {
                                HomeCubit.get(context).GetDataProducts();
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: ColorsApp.mainColor,
                                  ),
                                  child: const Icon(
                                    Icons.search_outlined,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        const Text(
                          "Products",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 0.9,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemCount: HomeCubit.get(context).Products.length,
                              itemBuilder: (BuildContext context, index) {
                                return CardItemWidget(index: index);
                              }),
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class ProductArg {
  int id;
  int index;
  ProductArg({required this.id, required this.index});
}
