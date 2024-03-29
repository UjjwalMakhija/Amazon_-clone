import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/account/widgets/product.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/order_details/screens/order_Details_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';


class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();
  // const userprovider = context.watch<Provider>(context,)
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderdata = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Orderdetailscreen.routeName,
                      arguments: orderdata);
                },
                child: SizedBox(
                  height: 140,
                  child: Product(image: orderdata.products[0].images[0]),
                ),
              );
            },
          );
  }
}
