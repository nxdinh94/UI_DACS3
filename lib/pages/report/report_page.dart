import 'package:flutter/material.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';


class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Báo cáo'),
        titleTextStyle: const TextStyle(
          fontSize: textBig, color: secondaryColor, fontWeight: FontWeight.w700),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: paddingAll12,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        CustomNavigationHelper.router.push(
                          '${CustomNavigationHelper.reportPath}/${CustomNavigationHelper.currentFinancesPath}'
                        );
                      },
                      child: Container(
                        padding: verticalPadding,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          children: [
                            Image.asset('assets/another_icon/graph.png', width: 66,),
                            spaceColumn6,
                            const Text('Tài chính hiện tại', style: defaultTextStyle,)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
