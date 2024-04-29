import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practise_ui/constant/color.dart';

void showCustomErrorToast(BuildContext context, String message) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: errorToastColor,
    ),
    child: Row(
      // mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset('assets/danger.png', width: 60,),
        Expanded(
            child: Text(
              '$message',
              style: TextStyle(color: whiteColor, fontSize: 16),
            ),
        ),
      ],
    ),
  );
  fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 3),
      gravity: ToastGravity.TOP
  );
}

void showCustomSuccessToast(BuildContext context, String message) {
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
            '$message',
            style: TextStyle(color: whiteColor, fontSize: 16),
          ),
        ),
      ],
    ),
  );
  fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 3),
      gravity: ToastGravity.TOP
  );
}