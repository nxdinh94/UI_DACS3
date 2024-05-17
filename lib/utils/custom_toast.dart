import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';

void showCustomErrorToast(BuildContext context, String message, int duration) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: errorToastColor,
      boxShadow:const [
         BoxShadow(
          color: Colors.grey,
          blurRadius: 4,
          offset: Offset(3, 7), // Shadow position
        ),
      ],
    ),
    child: Row(
      // mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset('assets/danger.png', width: 60,),
        Expanded(
            child: Text(
              message,
              style: const TextStyle(color: whiteColor, fontSize: textSize),
            ),
        ),
      ],
    ),
  );
  fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: duration),
      gravity: ToastGravity.TOP
  );
}

void showCustomSuccessToast(BuildContext context, String message, {int duration = 3}) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: successToastColor,
    ),
    child: Row(
      // mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset('assets/check.png', width: 60,),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: whiteColor, fontSize: textSize),
          ),
        ),
      ],
    ),
  );
  fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: duration),
      fadeDuration: const Duration(seconds: 1),
      gravity: ToastGravity.TOP
  );
}