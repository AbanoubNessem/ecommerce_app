import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce_app/commn/colors.dart';
import 'package:ecommerce_app/commn/commnWidget.dart';
import 'package:ecommerce_app/screens/addProduct/addProductCubit.dart';
import 'package:ecommerce_app/screens/addProduct/addProductStates.dart';
import 'package:ecommerce_app/screens/home/homeCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKeyAddProduct = GlobalKey<FormState>();
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AddProductCubit()
            ..GetCatProduct()
            ..cat,
        ),
        BlocProvider(
          create: (context) => HomeCubit()
            ..GetDataProducts()
            ..Products,
        )
      ],
      child: BlocConsumer<AddProductCubit, AddProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // var catList = AddProductCubit.get(context).cat;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Add Product"),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
              ),
            ),
            body: Container(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
              margin:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
              child: SingleChildScrollView(
                child: Form(
                  key: formKeyAddProduct,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AddProductCubit.get(context).imageSelect != null
                          ? Image.file(
                              AddProductCubit.get(context).imageSelect!,
                              width: 250,
                              height: 250)
                          : Image.asset('assets/Image.jpg',
                              width: 250, height: 250),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                print('gallery');
                                AddProductCubit.get(context)
                                    .GetImage(ImageSource.gallery);
                              },
                              style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                        vertical:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                  ),
                                  backgroundColor: MaterialStatePropertyAll(
                                      ColorsApp.mainColor)),
                              child: Row(
                                children: [
                                  Icon(Icons.image_outlined),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("pick gallery"),
                                ],
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                print('camera');
                                AddProductCubit.get(context)
                                    .GetImage(ImageSource.camera);
                              },
                              style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                        vertical:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                  ),
                                  backgroundColor: MaterialStatePropertyAll(
                                      ColorsApp.mainColor)),
                              child: Row(
                                children: [
                                  Icon(Icons.camera_alt_outlined),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("pick camera"),
                                ],
                              ))
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      defaultTExtField(
                        controller: titleController,
                        passValue: false,
                        type: TextInputType.name,
                        text: "Title",
                        icons: Icons.title_outlined,
                        validate: "Enter Title of Product",
                        context: context,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      defaultTExtField(
                        controller: priceController,
                        passValue: false,
                        type: TextInputType.number,
                        text: "Price",
                        icons: Icons.attach_money_outlined,
                        validate: "Enter Price of Product",
                        context: context,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      defaultTExtField(
                        controller: descriptionController,
                        passValue: false,
                        type: TextInputType.multiline,
                        text: "Description",
                        icons: Icons.description_outlined,
                        validate: "Enter Description of Product",
                        context: context,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: const [
                              Icon(
                                Icons.list,
                                size: 16,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: AddProductCubit.get(context)
                              .cat
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 55,
                            width: 160,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.black,
                              ),
                              color: Colors.grey[200],
                            ),
                            elevation: 0,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            iconSize: 14,
                            iconEnabledColor: Colors.black,
                            // iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            width: 200,
                            padding: null,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.grey[200],
                            ),
                            elevation: 8,
                            offset: const Offset(10, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! AddProductLoadingState,
                          builder: (context) => ElevatedButton(
                              onPressed: () {
                                if (formKeyAddProduct.currentState!
                                    .validate()) {
                                  print(
                                      "list ${HomeCubit.get(context).Products.length}");
                                  AddProductCubit.get(context).AddProduct(

                                      title: titleController.text,
                                      price: priceController.text,
                                      category: selectedValue.toString(),
                                      description: descriptionController.text,
                                      image: AddProductCubit.get(context).imageSelect!.path,
                                      context: context,
                                    listProducts: HomeCubit.get(context).Products,
                                  );
                                }
                              },
                              style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        vertical:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                  ),
                                  backgroundColor: MaterialStatePropertyAll(
                                      ColorsApp.mainColor)),
                              child: Text("Add")),
                          fallback: (context) => CircularProgressIndicator(),
                        ),
                      ),
                    ],
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
