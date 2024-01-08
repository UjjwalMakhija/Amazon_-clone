import 'package:amazon_clone/commom/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pay/pay.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalamount;
  const AddressScreen({super.key, required this.totalamount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressformkey = GlobalKey<FormState>();
  final TextEditingController flatbuildingcontroller = TextEditingController();
  final TextEditingController areaStreetcontroller = TextEditingController();
  final TextEditingController pincodecontroller = TextEditingController();
  final TextEditingController townorcitycontroller = TextEditingController();
  String addresstobeused = "";
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();
  @override
  void initState() {
    paymentItems.add(PaymentItem(
        amount: widget.totalamount,
        label: 'Total amount',
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    super.dispose();
    flatbuildingcontroller.dispose();
    areaStreetcontroller.dispose();
    pincodecontroller.dispose();
    townorcitycontroller.dispose();
  }

  void OnGpayresult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveuseraddress(
          context: context, address: addresstobeused);
    }
    addressServices.placeOrder(
        context: context,
        address: addresstobeused,
        totalSum: widget.totalamount as double);
  }

  void onpaypresse(String addressfromprovider) {
    addresstobeused = "";
    bool isForm = flatbuildingcontroller.text.isNotEmpty ||
        areaStreetcontroller.text.isNotEmpty ||
        pincodecontroller.text.isNotEmpty ||
        townorcitycontroller.text.isNotEmpty;
    if (isForm) {
      if (_addressformkey.currentState!.validate()) {
        addresstobeused =
            '${flatbuildingcontroller.text},${areaStreetcontroller.text},${townorcitycontroller.text},${pincodecontroller.text}';
      } else {
        throw Exception("Please enter all the values and valid values");
      }
    } else if (addressfromprovider.isEmpty) {
      addresstobeused = addressfromprovider;
    } else {
      showsnackbar(context, 'ERROR');
    }
    print(addresstobeused);
  }

  @override
  Widget build(BuildContext context) {
    final Future<PaymentConfiguration> _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('gpay.json');
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appbarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black12,
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'OR',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              Form(
                key: _addressformkey,
                child: Column(
                  children: [
                    Customformfield(
                        controller: flatbuildingcontroller,
                        hintText: "Flat,House no, Building"),
                    const SizedBox(
                      height: 10,
                    ),
                    Customformfield(
                        controller: areaStreetcontroller,
                        hintText: "Area,Street"),
                    const SizedBox(
                      height: 10,
                    ),
                    Customformfield(
                        controller: pincodecontroller, hintText: "Pincode"),
                    const SizedBox(
                      height: 10,
                    ),
                    Customformfield(
                        controller: townorcitycontroller,
                        hintText: "Town/City"),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              FutureBuilder<PaymentConfiguration>(
  future: _googlePayConfigFuture,
   builder: (context, snapshot) => snapshot.hasData ?
              GooglePayButton(
                onPressed: () => onpaypresse(address),
                onPaymentResult: OnGpayresult,
                paymentItems: paymentItems,
                paymentConfiguration: snapshot.data!,
                width: double.infinity,
                type: GooglePayButtonType.buy,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                height: 50,
                margin: const EdgeInsets.only(top: 15),
              )
              :const SizedBox.shrink())
            ],
          ),
        ),
      ),
    );
  }
}
