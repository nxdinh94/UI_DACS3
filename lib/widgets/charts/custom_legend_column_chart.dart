import 'package:flutter/material.dart';
class CustomLegendColumnChart extends StatelessWidget {
  const CustomLegendColumnChart({super.key, required this.color, required this.text});
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 12,
            height: 12,
            color: color,
          ),
        ),
        SizedBox(width: 7,),
        Text(text, style: TextStyle(
          fontSize: 17
        ))
      ],
    );
  }
}
