import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/features/productdetails/services/product_detail_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class cart_product extends StatefulWidget {
  final int index;
  const cart_product({super.key, required this.index});

  @override
  State<cart_product> createState() => _cart_productState();
}

class _cart_productState extends State<cart_product> {
  final Productdeatilservices productdeatilservices = Productdeatilservices();
  final CartDetailServices cartDetailServices = CartDetailServices();
  void increasequantity(Product12 product) {
    productdeatilservices.addToCart(context: context, product: product);
  }

  void Decreasequantity(Product12 product) {
    cartDetailServices.removefromCart(context: context, product: product);
    (context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product12.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Image.network(
                  product.images[0],
                  fit: BoxFit.fitHeight,
                  height: 135,
                  width: 135,
                ),
                Column(
                  children: [
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text('Eligible for FREE Shipping'),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Text(
                        'In Stock',
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                )
              ],
            )),
        Container(
          margin: const EdgeInsets.all(10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(
                  color: Colors.black12,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: ()=>Decreasequantity(product),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.remove,
                        size: 18,
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1.5),
                        color: Colors.white),
                    child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text(quantity.toString())),
                  ),
                  InkWell(
                    onTap: () => increasequantity(product),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.add,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        )
      ],
    );
  }
}
