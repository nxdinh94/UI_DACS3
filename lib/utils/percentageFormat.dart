import 'package:flutter/material.dart';

// 11.11% -> 11.11
double percentageStringToDouble(String value){
  return double.parse(value.substring(0, value.length-1));
}