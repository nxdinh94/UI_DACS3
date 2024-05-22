import 'package:flutter/material.dart';
import 'package:practise_ui/widgets/vnd_icon.dart';
class HiddenMoneyLabel extends StatelessWidget {
  const HiddenMoneyLabel({
    super.key, required this.fontSize, required this.iconSize, required this.color
  });
  final double fontSize;
  final double iconSize;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: '*** 000',
          style: TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.bold),
          children: [
            WidgetSpan(
                child: VndIcon(color: color, size: iconSize),
                alignment: PlaceholderAlignment.middle
            )
          ]
      ),
    );
  }
}
