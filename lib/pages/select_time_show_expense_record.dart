
import 'package:flutter/material.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/divider.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';

import '../constant/range_time/range_time_for_expense_record.dart';
import '../widgets/back_toolbar_button.dart';
class SelectTimeShowExpenseRecord extends StatefulWidget {
  const SelectTimeShowExpenseRecord({super.key});

  @override
  State<SelectTimeShowExpenseRecord> createState() => _SelectTimeShowExpenseRecordState();
}

class _SelectTimeShowExpenseRecordState extends State<SelectTimeShowExpenseRecord> {
  int currentYear = DateTime.now().year + 1;
  List<String>listYear= [];
  String selectedDate = '';
  String selectedYear = '2024';
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
        leading: const BackToolbarButton(),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: rangeTimeForExpenseRecord.map((e){
                return Column(
                  children: [
                    ListTile(
                      onTap: (){
                        Navigator.pop(context, e);
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
    );
  }
}
