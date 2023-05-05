import 'package:ecommerce_app/commn/colors.dart';
import 'package:ecommerce_app/screens/home/homeScreen.dart';
import 'package:ecommerce_app/screens/singleProduct/singleProductCubit.dart';
import 'package:ecommerce_app/screens/singleProduct/singleProductStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleProductScreen extends StatefulWidget {
  const SingleProductScreen({Key? key}) : super(key: key);


  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  @override
  Widget build(BuildContext context) {
    ProductArg args = ModalRoute.of(context)!.settings.arguments as ProductArg;
    return BlocProvider(
      create: (BuildContext context) => SingleProductCubit()
        ..GetDataProduct(
          args.id,
        ),
      child: BlocConsumer<SingleProductCubit, SingleProductStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if (SingleProductCubit.get(context).Product == null) {
            SingleProductCubit.get(context).GetDataProduct(args.id);
          }
          return Scaffold(
              appBar: AppBar(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50)),
                ),
                title: SingleProductCubit.get(context).Product == null
                    ? const Center(child: CircularProgressIndicator())
                    :Text(SingleProductCubit.get(context).Product["title"].toString()),
              ),
              body: SingleProductCubit.get(context).Product == null
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.015),
                margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.015),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(SingleProductCubit.get(context).Product["image"],width: 250,height: 250),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.05,
                      ),
                      Text(SingleProductCubit.get(context).Product["title"],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.03,
                      ),
                      Text(SingleProductCubit.get(context).Product["category"].toString(),style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 18)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.attach_money_outlined,size: 20),
                          Text(SingleProductCubit.get(context).Product["price"].toString(),style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 18)),
                          const Spacer(),
                          Text(SingleProductCubit.get(context).Product["rating"]["rate"].toString()),
                          const Icon(Icons.star,color: Colors.amber,)
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.03,
                      ),
                      Text(SingleProductCubit.get(context).Product["description"].toString(),style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 18)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.1,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            SingleProductCubit.get(context).showMessage("Soon", context);
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
                          child: const Text("Add To Cart"))
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
