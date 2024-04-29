import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/side.dart';

class MyProgressBar extends StatefulWidget {
  const MyProgressBar({super.key});

  @override
  State<MyProgressBar> createState() => _MyProgressBarState();
}

class _MyProgressBarState extends State<MyProgressBar> {

  @override
  Widget build(BuildContext context) {
    String currentRoute = GoRouterState.of(context).uri.toString();
    bool isDetailSpendingLimitItemPage =
    currentRoute =='/detailSpendingLimitItem'? true: false;
    return LinearPercentIndicator(
      percent: 0.7,
      padding: paddingNone,
      width: MediaQuery.of(context).size.width - 25,
      animation: true,
      lineHeight: isDetailSpendingLimitItemPage ? 8: 15.0,
      animationDuration: 1500,
      // center: const Text("80.0%", style: TextStyle( color: Colors.white),),
      barRadius: const Radius.circular(10),
      // onAnimationEnd: () => exit(0),
      progressColor: revenueMoneyColor,
      backgroundColor: Colors.grey[300],

    );
  }
}
