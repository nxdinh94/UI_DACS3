import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/side.dart';
import '../constant/color.dart';
import '../constant/font.dart';
import '../utils/custom_navigation_helper.dart';
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
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: const Icon(
                    Icons.keyboard_arrow_left, color: secondaryColor, size: 43
                ),
                onPressed: () {
                  CustomNavigationHelper.router.pop();
                },
              );
            }
        ),

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
                    if(myList[e]['ischosen'] != myList[index]['ischosen']){
                      myList[e]['ischosen'] = false;
                    }
                  }
                  myList[index]['ischosen'] = true;
                  CustomNavigationHelper.router.pop(myList[index]['title']);
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
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.green,
                  child: SvgPicture.asset('assets/tick.svg', width: 20, color: secondaryColor,),
                ),
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
