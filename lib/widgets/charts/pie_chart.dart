import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:practise_ui/constant/color.dart';
class MyPieChart extends StatelessWidget {
  Map<String, double> dataMap;

  MyPieChart({Key? key, required this.dataMap}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      // color: Colors.grey,
      height: 200,
      width: MediaQuery.of(context).size.width * 0.94,
      child: FittedBox(
        child: PieChart(
          dataMap: dataMap,
          animationDuration: const Duration(milliseconds: 1500),
          chartLegendSpacing: 80,
          chartRadius: MediaQuery.of(context).size.width / 3.2,
          initialAngleInDegree: 0,
          chartType: ChartType.ring,
          ringStrokeWidth: 40,
          // centerText: "HYBRID",
          colorList: pieChartColorList,
          // Pass gradient to PieChart
          emptyColorGradient: const [
            Color(0xff6c5ce7),
            Colors.blue,
          ],

          legendOptions: const LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              color: labelColor,
            ),
        
          ),

          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            chartValueBackgroundColor: WidgetStateColor.transparent,
            showChartValuesInPercentage: true,
            showChartValuesOutside: false,
            decimalPlaces: 2,
            chartValueStyle: TextStyle(color: textColor)
          ),
        ),
      ),
    );
  }
}