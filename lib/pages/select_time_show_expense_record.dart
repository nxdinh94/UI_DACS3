import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/divider.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/range_time_value.dart';
import 'package:practise_ui/constant/side.dart';
class SelectTimeShowExpenseRecord extends StatefulWidget {
  const SelectTimeShowExpenseRecord({super.key});

  @override
  State<SelectTimeShowExpenseRecord> createState() => _SelectTimeShowExpenseRecordState();
}

class _SelectTimeShowExpenseRecordState extends State<SelectTimeShowExpenseRecord> {
  int currentYear = DateTime.now().year + 1;
  List<String>listYear= [];
  String selectedDate = '';
  String selectedYear = 'yyyy';
  String selectedMonth = 'mm';
  @override
  void initState() {
    selectedDate = '$selectedMonth-$selectedYear';
    listYear = List.generate(4, (e)=> (currentYear-=1 ).toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text('Chọn thời gian', style: TextStyle(color: secondaryColor, fontSize: textSize, fontWeight: FontWeight.w500),),
        leading: const SizedBox(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text('$selectedMonth-$selectedYear',
              style: const TextStyle(color: secondaryColor, fontSize: textSize),),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.grey.shade100,
                padding: paddingAll12,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: listYear.map((String e){
                      return TextButton(
                          onPressed: (){
                            setState(() {
                              selectedYear = e;
                            });
                            if(selectedYear != 'yyyy' && selectedMonth != 'mm'){
                              selectedDate = '$selectedMonth-$selectedYear';
                              Navigator.pop(context, selectedDate);
                            }
                          },
                          style: TextButton.styleFrom(
                            elevation: 0,
                            backgroundColor: primaryColor
                          ),
                          child: Text(e,
                            style: const TextStyle(fontSize: textSmall,fontWeight: FontWeight.w500, color: secondaryColor),));
                    }).toList()
                ),
              ),
              Column(
                children: rangeTimeData.map((e){
                  return Column(
                    children: [
                      ListTile(
                        onTap: (){
                          setState(() {
                            selectedMonth = e['value'];
                            selectedDate = '$selectedMonth-$selectedYear';
                          });
                          if(selectedYear != 'yyyy' && selectedMonth != 'mm'){
                            Navigator.pop(context, selectedDate);
                          }
                          if(selectedMonth == 'all'){
                            Navigator.pop(context, 'all');
                          }
                        },
                        title: Text(e['title']),
                        titleTextStyle: defaultTextStyle,
                      ),
                      defaultDivider
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
