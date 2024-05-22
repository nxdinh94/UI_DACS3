import 'package:flutter/material.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
class RightArrowRichText extends StatelessWidget {
  const RightArrowRichText({
    super.key,
    this.color = textColor,
    this.fontSize = textSize,
    this.fontWeight = FontWeight.normal,
    required this.text,
    this.iconSize = 28
  });
  final Color color;
  final double fontSize;
  final double iconSize;
  final FontWeight fontWeight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return  RichText(
      text:  TextSpan(
          text: text,
          style: TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
          children: [
            WidgetSpan(
              child: Icon(Icons.keyboard_arrow_right, size: iconSize, color: color,),
              alignment: PlaceholderAlignment.middle,
            )
          ]
      ),
    );
  }
}
