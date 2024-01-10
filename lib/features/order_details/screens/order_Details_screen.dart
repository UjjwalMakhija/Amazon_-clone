import 'package:amazon_clone/commom/widgets/custom_button.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/home/search/screens/search_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orderdetailscreen extends StatefulWidget {
  static const String routeName = "/order-details";
  final Order order;
  const Orderdetailscreen({super.key, required this.order});

  @override
  State<Orderdetailscreen> createState() => _OrderdetailscreenState();
}

class _OrderdetailscreenState extends State<Orderdetailscreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();
  void navigateToSearchScren(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentStep = widget.order.status;
    // setState(() {

    // });
  }

  //   Admin side usage only
  void changeorderstatus(int status) {
    adminServices.changeorderstatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(() {
          currentStep += 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appbarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScren,
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(
                                  Icons.search_sharp,
                                  color: Colors.black,
                                  size: 23,
                                )),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 1,
                              )),
                          hintText: "Search Amazon.in",
                          hintStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                )),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.mic,
                    color: Colors.black,
                    size: 25,
                  ),
                )
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "View order details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Date :       ${widget.order.orderedAt}'),
                      Text('Order ID :           ${widget.order.id}'),
                      Text('Order Total :      \$${widget.order.totalPrice}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Purchase details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                  width: double.infinity,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < widget.order.products.length; i++)
                        Row(
                          children: [
                            Image.network(
                              widget.order.products[i].images[0],
                              height: 120,
                              width: 120,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.order.products[i].name,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                Text('Qty : ${widget.order.quantity[i]}')
                              ],
                            ))
                          ],
                        ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Tracking",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black,
                  )),
                  child: Stepper(
                      currentStep: currentStep,
                      controlsBuilder: ((context, details) {
                        if (user.type == 'admin') {
                          return Custom_button(text: 'Done', onTap:()=> changeorderstatus(details.currentStep));
                        }
                        return const SizedBox();
                      }),
                      steps: [
                        Step(
                          title: const Text('Pending'),
                          content:
                              const Text('Your order is yet to be delivered'),
                          isActive: currentStep > 0,
                          state: currentStep > 0
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          isActive: currentStep > 1,
                          title: const Text('Completed'),
                          content: const Text(
                              'Your order had been delivered, you are yet to sign'),
                          state: currentStep > 1
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                            isActive: currentStep > 2,
                            state: currentStep > 2
                                ? StepState.complete
                                : StepState.indexed,
                            title: const Text('Received'),
                            content: const Text(
                                'Your order has been delivered and signed by you ')),
                        Step(
                            isActive: currentStep >= 3,
                            state: currentStep >= 3
                                ? StepState.complete
                                : StepState.indexed,
                            title: const Text('Delivered'),
                            content: const Text(
                                'Your order has been delivered and signed by you ')),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
