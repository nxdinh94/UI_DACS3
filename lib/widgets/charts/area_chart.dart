import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyAreaChart extends StatefulWidget {
  const MyAreaChart({super.key});

  @override
  State<MyAreaChart> createState() => _MyAreaChartState();
}

class _MyAreaChartState extends State<MyAreaChart> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(1, 0),
      ChartData(3, 1000),
      ChartData(4, 120),
      ChartData(5, 60),
      ChartData(6, 60),
      ChartData(8, 33),
      ChartData(10, 100),
      ChartData(9, 800),
      ChartData(12, 2000),
      ChartData(13, 300),
      ChartData(14, 350),
      ChartData(16, 370),
      ChartData(18, 480),
      ChartData(19, 410),
      ChartData(21, 600),
      ChartData(23, 520),
      ChartData(25, 700),
      ChartData(27, 1000),
      ChartData(29, 405),
      ChartData(31, 4000),
    ];
    final List<Color> color = <Color>[];
    color.add(Colors.blue[50]!);
    color.add(Colors.blue[200]!);
    color.add(Colors.blue);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors =
    LinearGradient(colors: color, stops: stops);

    return Container(
        height: 500,
        color: secondaryColor,
        child: SfCartesianChart(
            isTransposed: true,
            title: const ChartTitle(
              text: 'Biểu đồ chi tiêu',
              textStyle: TextStyle(
                color: textColor,
                fontSize: textSmall,
              ),
              alignment: ChartAlignment.near,
            ),


            primaryYAxis: const NumericAxis(
              labelFormat: '{value}đ',
              title: AxisTitle(
                text: '(Đơn vị:Trăm nghìn)',
                alignment: ChartAlignment.far,
                textStyle: TextStyle(
                  color: labelColor,
                  fontSize: 13
                )
              ),
            ),

            series: <CartesianSeries>[
              // Renders area chart
              AreaSeries<ChartData, int>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                gradient: gradientColors,



              )
            ]
        )
    );
  }
}
class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}