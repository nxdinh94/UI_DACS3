import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:practise_ui/constant/color.dart';

import '../../models/collum_chart_model.dart';
class MyColumnChart extends StatefulWidget {
  const MyColumnChart({Key? key, required this.data}) : super(key: key);
  final List<CollumChartModel>data;
  @override
  State<MyColumnChart> createState() => _MyColumnChartState();
}

class _MyColumnChartState extends State<MyColumnChart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        margin:  const EdgeInsets.only( right: 12),
        enableAxisAnimation: true,

        primaryXAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(width: 0),
          majorGridLines: MajorGridLines(
            width: 0
          ),
          labelStyle: TextStyle(
            color: Colors.transparent, // Hide x-axis labels
          ),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(
              width: 0
          ),
          isVisible: false, // Hide Y-axis

        ),



        series: <CartesianSeries<CollumChartModel, int>>[
          // Renders column chart
          ColumnSeries<CollumChartModel, int>(
            dataSource: widget.data,
            xValueMapper: (CollumChartModel data, _) => data.x,
            yValueMapper: (CollumChartModel data, _) => data.y,
            width: 0.6,
            spacing: 0,

            trackPadding: 0,
            pointColorMapper: (CollumChartModel data, _) => data.color, // Set column color
            isTrackVisible: false,
            dataLabelSettings: const DataLabelSettings(isVisible: false),

          )
        ],
      ),
    );
  }
}

