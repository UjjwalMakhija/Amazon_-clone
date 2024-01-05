import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/account/widgets/product.dart';
import 'package:amazon_clone/features/admin/screens/add_new_product.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<Product12>? products;
  final AdminServices adminservices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminservices.fetchAllProducts(context);
    setState(() {});
  }

  void addproducts() {
    Navigator.pushNamed(context, AddProduct.routename);
  }

  void deleteproduct(Product12 product, int index) {
    adminservices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {
            
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: Product(
                          image: productData.images[0],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Text(
                            productData.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )),
                          IconButton(
                              onPressed: () => deleteproduct(productData,index), icon: const Icon(Icons.delete))
                        ],
                      )
                    ],
                  );
                }),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 15, 20, 20),
              onPressed: addproducts,
              child: Icon(
                Icons.add_circle_sharp,
                color: Colors.black,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
          );
  }
}
