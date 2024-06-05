import 'package:flutter/material.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyAreaChart extends StatefulWidget {
  const MyAreaChart({super.key, required this.areaChartData});
  final List<ChartData> areaChartData;
  @override
  State<MyAreaChart> createState() => _MyAreaChartState();
}

class _MyAreaChartState extends State<MyAreaChart> {
  @override
  Widget build(BuildContext context) {

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
                dataSource: widget.areaChartData,
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