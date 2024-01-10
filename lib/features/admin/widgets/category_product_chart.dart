import 'package:amazon_clone/features/admin/models/sales_model.dart';
import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

class Categoryproductchart extends StatefulWidget {
  final List<charts.Series<Sales, String>> seriesList;
  const Categoryproductchart({super.key, required this.seriesList});

  @override
  State<Categoryproductchart> createState() => _CategoryproductchartState();
}

class _CategoryproductchartState extends State<Categoryproductchart> {
  @override
  Widget build(BuildContext context) {
    return  charts.BarChart(
      
      widget.seriesList,
      animate: true,

    );
  }
}
