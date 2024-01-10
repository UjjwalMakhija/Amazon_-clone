import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/admin/models/sales_model.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/admin/widgets/category_product_chart.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales =  earningData['totalearnings'];
    earnings = earningData['sales'];
     setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null  || totalSales == null ? const Loader():
    Column(
      children: [ 
        Text(
          '\$${totalSales}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
     SizedBox(
      height: 250 ,
       child: Categoryproductchart(seriesList: [
             charts.Series(id: 'Sales', data: earnings!, domainFn:(Sales sales,_)=> sales.label, measureFn:(Sales sales,_)=> sales.earning)
          ]),
     )
      ],
    )
    ;
  }
}
