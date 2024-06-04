import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

Future<List<DateTime>?> dateTimeRangePicker(BuildContext context)async{
  List<DateTime>? result = [];
  result = await showOmniDateTimeRangePicker(
    context: context,
    startInitialDate: DateTime.now(),
    startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
    startLastDate: DateTime.now().add(
      const Duration(days: 3652),
    ),
    endInitialDate: DateTime.now(),
    endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
    endLastDate: DateTime.now().add(
      const Duration(days: 3652),
    ),
    type: OmniDateTimePickerType.date,
    is24HourMode: true,
    isShowSeconds: false,
    minutesInterval: 1,
    secondsInterval: 1,
    isForce2Digits: true,
    borderRadius: const BorderRadius.all(Radius.circular(16)),
    constraints: const BoxConstraints(
      maxWidth: 350,
      maxHeight: 650,
    ),
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: anim1.drive(
          Tween(
            begin: 0,
            end: 1,
          ),
        ),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
    barrierDismissible: true,
    selectableDayPredicate: (dateTime) {
      // Disable 25th Feb 2023
      if (dateTime == DateTime(2023, 2, 25)) {
        return false;
      } else {
        return true;
      }
    },
  );
  return result;
}