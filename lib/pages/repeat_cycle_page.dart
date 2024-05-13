import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/widgets/rounded_checkbox_icon.dart';
import '../constant/color.dart';
import '../constant/font.dart';
import '../utils/custom_navigation_helper.dart';
import '../widgets/back_toolbar_button.dart';
class RepeatCyclePage extends StatefulWidget {
  RepeatCyclePage({super.key});

  @override
  State<RepeatCyclePage> createState() => _RepeatCyclePageState();
}

class _RepeatCyclePageState extends State<RepeatCyclePage> {
  final List<Map<String, dynamic>> myList = [
    {'title': 'Không lặp lại', 'ischosen': false },
    {'title': 'Hàng ngày', 'ischosen': false },
    {'title': 'Hàng tuần', 'ischosen': false },
    {'title': 'Hàng tháng', 'ischosen': false },
    {'title': 'Hàng quý', 'ischosen': true },
    {'title': 'Hàng năm', 'ischosen': false },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Lặp lại',
          style: TextStyle(
              color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        leading: const BackToolbarButton(),
      ),
      body: Container(
        padding: sidePadding,
        color: secondaryColor,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              onTap: (){
                setState(() {
                  for (int e = 0 ;e< myList.length; e++) {
                      myList[e]['ischosen'] = false;
                  }
                  myList[index]['ischosen'] = true;
                  Navigator.pop(context, myList[index]['title'].toString());
                });
              },
              title: Text(
                myList[index]['title'],
                style: const TextStyle(
                  fontSize: textSize, color: textColor
                ),
              ),
              trailing: Visibility(
                visible: myList[index]['ischosen'],
                child: RoundedCheckboxIcon(),
              ),
              dense: true,
              contentPadding: EdgeInsets.zero,
            );
          },
          itemCount: myList.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: underLineColor,);
          },


        ),
      ),
    );
  }
}
