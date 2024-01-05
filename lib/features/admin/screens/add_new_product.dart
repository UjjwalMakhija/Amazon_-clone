import 'dart:io';

import 'package:amazon_clone/commom/widgets/custom_button.dart';
import 'package:amazon_clone/commom/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/home/widgets/categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  static const String routename = '/add-prouct';
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productname = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final AdminServices adminServices = AdminServices();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productname.dispose();
    description.dispose();
    price.dispose();
    quantity.dispose();
  }

  List<File> images = [];
  final _addproductformkey = GlobalKey<FormState>();
  List<String> productcategories = [
    "Mobile",
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];
  String category = 'Mobile';
  void selectImages() async {
    var res = await pickImage();
    images = res;
  }

  void sellProduct() {
    if (_addproductformkey.currentState!.validate()  && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: productname.text,
          description: description.text,
          price: double.parse(price.text),
          quantity: double.parse(quantity.text),
          category: category,
          images: images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appbarGradient,
              ),
            ),
            title: const Text(
              "Add Product",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _addproductformkey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
              const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        options:
                            CarouselOptions(viewportFraction: 1, height: 200),
                        items: images.map((i) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        }).toList())
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                            strokeCap: StrokeCap.round,
                            dashPattern: const [8, 4],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            strokeWidth: 1,
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open_sharp,
                                    color: Colors.black,
                                    size: 35,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Select Product Image",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey[400]),
                                  )
                                ],
                              ),
                            )),
                      ),
                SizedBox(
                  height: 20,
                ),
                Customformfield(
                  controller: productname,
                  hintText: "Product Name",
                ),
                const SizedBox(
                  height: 10,
                ),
                Customformfield(
                  controller: description,
                  hintText: "Description",
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 10,
                ),
                Customformfield(
                  controller: price,
                  hintText: "Price",
                ),
                const SizedBox(
                  height: 10,
                ),
                Customformfield(
                  controller: quantity,
                  hintText: "Quantity",
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    items: productcategories.map((String item) {
                      return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                          ));
                    }).toList(),
                    onChanged: (String? newvalt) {
                      setState(() {
                        category = newvalt!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Custom_button(text: "Sell", onTap:sellProduct)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
