import 'package:flutter/material.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';


class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo'),
        titleTextStyle: const TextStyle(
          fontSize: textBig, color: secondaryColor, fontWeight: FontWeight.w700),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
    );
  }
}
