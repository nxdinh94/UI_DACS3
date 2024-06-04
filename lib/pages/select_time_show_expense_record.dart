
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/divider.dart';
import 'package:practise_ui/constant/font.dart';
import '../constant/range_time/range_time_for_expense_record.dart';
import '../utils/date_time_range_picker.dart';
import '../widgets/back_toolbar_button.dart';
class SelectTimeShowExpenseRecord extends StatefulWidget {
  const SelectTimeShowExpenseRecord({super.key});

  @override
  State<SelectTimeShowExpenseRecord> createState() => _SelectTimeShowExpenseRecordState();
}

class _SelectTimeShowExpenseRecordState extends State<SelectTimeShowExpenseRecord> {

  String startCustomDate = '--/--/----';
  String endCustomDate = '--/--/----';
  String fullCustomDate = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text('Chọn thời gian', style: TextStyle(color: secondaryColor, fontSize: textSize, fontWeight: FontWeight.w500),),
        leading: const BackToolbarButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: (){
                if(startCustomDate.contains('0') && endCustomDate.contains('0')){
                  fullCustomDate = '$startCustomDate/$endCustomDate';
                  Map<String, dynamic> dataToPop =   {'title': fullCustomDate, 'value': fullCustomDate};
                  Navigator.pop(context, dataToPop);
                }
              },
              child: SvgPicture.asset(
                'assets/svg/tick.svg',
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                width: 38, // Adjust the width as needed
                height: 38, // Adjust the height as needed
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: secondaryColor,
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
              Column(
                children: [
                  ListTile(
                    onTap: () async {
                      List<DateTime>? dateTimeList = await dateTimeRangePicker(context);
                      if(dateTimeList!.isNotEmpty){
                        setState(() {
                          startCustomDate = DateFormat('dd-MM-yyyy').format(dateTimeList[0]);
                          endCustomDate =  DateFormat('dd-MM-yyyy').format(dateTimeList[1]);
                        });
                      }
                    },
                    title: const Text('Tùy chọn'),
                    titleTextStyle: defaultTextStyle,
                    subtitle: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Từ       ',
                              style: labelTextStyle,
                              children: [
                                TextSpan(text: startCustomDate, style: defaultTextStyle)
                              ]
                            )
                          ),
                          RichText(
                              text: TextSpan(
                                  text: 'Đến    ', style: labelTextStyle,
                                  children: [
                                    TextSpan(text: endCustomDate, style: defaultTextStyle)
                                  ]
                              )
                          ),
                        ],
                      ),
                    ),
                    isThreeLine: true,
                  ),
                  defaultDivider
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
