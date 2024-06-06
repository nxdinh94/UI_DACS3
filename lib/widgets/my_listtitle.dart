import 'package:flutter/material.dart';
import 'package:practise_ui/constant/side.dart';

import '../constant/color.dart';
import '../constant/font.dart';
class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    required this.leading,
    required this.centerText,
    required this.trailing,
    required this.onTap,
    this.horizontalTitleGap = 35,
    this.vertiCalPadding = 0,
    this.leftPadding = 20,
  });
  final Widget leading;
  final String centerText;
  final Widget trailing;
  final VoidCallback onTap;
  final double horizontalTitleGap;
  final double vertiCalPadding;
  final double leftPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2, left: leftPadding),
      child: ListTile(
        // dense: true,
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: vertiCalPadding),
        horizontalTitleGap: horizontalTitleGap,
        leading: leading,
        title: Text(
          centerText,
          style: const TextStyle(fontSize: textSize, color: textColor),
        ),

        trailing: trailing,
      ),
    );
  }
}
