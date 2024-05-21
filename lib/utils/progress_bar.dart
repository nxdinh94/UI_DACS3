import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/side.dart';

class MyProgressBar extends StatefulWidget {
  const MyProgressBar({
    super.key,
    required this.percentage,
    required this.color,
    this.lineHeight = 15,

  });
  final double percentage;
  final Color color;
  final double lineHeight;
  @override
  State<MyProgressBar> createState() => _MyProgressBarState();
}

class _MyProgressBarState extends State<MyProgressBar> {

  @override
  Widget build(BuildContext context) {
    // String currentRoute = GoRouterState.of(context).uri.toString();
    // bool isDetailSpendingLimitItemPage =
    // currentRoute =='/detailSpendingLimitItem'? true: false;
    return LinearPercentIndicator(
      percent: widget.percentage,
      padding: paddingNone,
      width: MediaQuery.of(context).size.width - 25,
      animation: true,
      lineHeight: widget.lineHeight,
      animationDuration: 1500,
      // center: const Text("80.0%", style: TextStyle( color: Colors.white),),
      barRadius: const Radius.circular(10),
      // onAnimationEnd: () => exit(0),
      progressColor: widget.color,
      backgroundColor: backgroundColor,

    );
  }
}
