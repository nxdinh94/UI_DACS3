import 'package:flutter/material.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../utils/function/currency_format.dart';
import '../vnd_icon.dart';
class VndRichText extends StatelessWidget {
  const VndRichText({
    super.key,
    required this.value,
    this.color = textColor,
    this.fontSize = textSize,
    this.iconSize = 28,
    this.fontWeight = FontWeight.normal
  });
  final double value;
  final Color color;
  final double fontSize;
  final double iconSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: formatCurrencyVND(value),
          style:  TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
          children:  [
            WidgetSpan(
                child: VndIcon(color: color, size: iconSize),
                alignment: PlaceholderAlignment.middle
            )
          ]
      ),
    );
  }
}
