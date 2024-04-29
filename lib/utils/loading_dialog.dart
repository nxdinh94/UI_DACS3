import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

showCustomLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(
                'assets/lotties/Animation - 1714286918881.json',
                width: 120,
              ),
            ],
          ),
        ),
      );
    },
  );
}

hideCustomLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}
