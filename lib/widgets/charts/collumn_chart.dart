import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:practise_ui/constant/color.dart';
class MyColumnChart extends StatefulWidget {
  const MyColumnChart({Key? key}) : super(key: key);

  @override
  State<MyColumnChart> createState() => _MyColumnChartState();
}

class _MyColumnChartState extends State<MyColumnChart> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(1, 35, chartCollumn1),
      ChartData(2, 23, chartCollumn2),
    ];
    return Container(
      height: 250,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,

        margin:  EdgeInsets.only(top: 12, right: 12, bottom: 12),
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



        series: <CartesianSeries<ChartData, int>>[
          // Renders column chart
          ColumnSeries<ChartData, int>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            width: 0.5,
            spacing: 0.1,
            pointColorMapper: (ChartData data, _) => data.color, // Set column color
            isTrackVisible: false,
            dataLabelSettings: DataLabelSettings(isVisible: false),

          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final int x;
  final double y;
  final Color color;
}
