import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/widgets/back_toolbar_button.dart';
import 'package:practise_ui/widgets/charts/area_chart.dart';
import 'package:practise_ui/widgets/rich_text/vnd_rich_text.dart';
import 'package:practise_ui/widgets/spendingLimit/spendingLimitItems.dart';
import 'package:provider/provider.dart';

import '../../constant/dataForAreaChart.dart';
import '../../widgets/custom_tooltip.dart';
class DetailSpendingLimitItem extends StatefulWidget {
  const DetailSpendingLimitItem({super.key, required this.dataToPassSpendingLimitItemWidget});
  final Map<String, dynamic> dataToPassSpendingLimitItemWidget;
  @override
  State<DetailSpendingLimitItem> createState() => _DetailSpendingLimitItemState();
}

class _DetailSpendingLimitItemState extends State<DetailSpendingLimitItem> {
  final TextStyle labelStyle = const TextStyle(fontSize: 15, color: labelColor);
  String name = '';
  @override
  void initState() {
    name = widget.dataToPassSpendingLimitItemWidget['name'];
    super.initState();
  }
  List<List<dynamic>> groupSameElementsByDay(List<dynamic> inputList) {
    // Map to store lists of elements
    Map<String, List<dynamic>> elementGroups = {};

    // Populate the map with elements from the input list
    for (var element in inputList){
      if (elementGroups.containsKey(element['occur_date'])) {
        elementGroups[element['occur_date']]!.add({
          'occur_date':'${element['occur_date']}',
          'amount_of_money': '${element['amount_of_money'][r'$numberDecimal']}'
        });
      } else {
        elementGroups[element['occur_date']] = [
          {
            'occur_date':'${element['occur_date']}',
            'amount_of_money': '${element['amount_of_money'][r'$numberDecimal']}'
          }
        ];
      }
    }

    // Extract the values from the map and return as a list of lists
    return elementGroups.values.toList();
  }
  List<List<dynamic>> groupSameElementsByCategoryParent(List<dynamic> inputList) {
    // Map to store lists of elements
    Map<String, List<dynamic>> elementGroups = {};

    // Populate the map with elements from the input list
    for (var element in inputList){
      if (elementGroups.containsKey(element['cash_flow_category_id'])) {
        elementGroups[element['cash_flow_category_id']]!.add(element);
      } else {
        elementGroups[element['cash_flow_category_id']] = [element];
      }
    }

    // Extract the values from the map and return as a list of lists
    return elementGroups.values.toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: secondaryColor,
              fontSize: textBig,
              fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        leading: const BackToolbarButton(),
        actions: [
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset('assets/svg/pen-appbar.svg'),
            ),
          )
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, value, child) {
          Map<String, dynamic> thisSpendingLimit = value.specificSpendingLimit;
          List<ChartData> areaChartData = [];
          areaChartData = initialChartData;
          if(thisSpendingLimit.isEmpty){
            return const SizedBox(
              height: 150,
              child: Center(
                child: Text('Không có bản ghi', style: labelTextStyle),
              ),
            );
          }
          double initialMoney = double.parse(thisSpendingLimit['amount_of_money'][r'$numberDecimal']) ;
          double actualSpending = double.parse(thisSpendingLimit['actual_spending'][r'$numberDecimal']) ;
          double shouldSpending = double.parse(thisSpendingLimit['should_spending'][r'$numberDecimal']) ;
          double expectedSpending = double.parse(thisSpendingLimit['expected_spending'][r'$numberDecimal']) ;

          List<dynamic> expenseRecord = thisSpendingLimit['expense_records'];

          List<List<dynamic>> transformExpenseRecordByDay = groupSameElementsByDay(expenseRecord);//[[a,a,a],[b,b,b]]
          List<List<dynamic>> transformExpenseRecordByCateParent = groupSameElementsByCategoryParent(expenseRecord);//[[a,a,a],[b,b,b]]

          for(final item1 in transformExpenseRecordByDay){
            double totalGroupMoney = 0;
            int day = 0;
            for(final item2 in item1){
              DateTime occurDate = DateTime.parse(item2['occur_date']);
              day = occurDate.day;
              totalGroupMoney+=double.parse(item2['amount_of_money']);
            }
            areaChartData[day] = ChartData(day, totalGroupMoney);
          }

          return Container(
            color: backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: secondaryColor,
                    padding: paddingV6H12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Hạn mức', style: TextStyle(color: textColor, fontSize: textSmall)),
                        VndRichText(
                          value: initialMoney,
                          fontSize: textBig,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                          iconSize: 16,
                        )
                      ],
                    ),
                  ),
                  spaceColumn,
                  Container(
                    color: secondaryColor,
                    padding: paddingAll12,
                    child: SpendingLimitItems(itemSpendingLimit: widget.dataToPassSpendingLimitItemWidget),
                  ),
                  spaceColumn,
                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    color: secondaryColor,
                    child:  ListTile(
                      onTap: (){
                        CustomNavigationHelper.router.push(
                          '${CustomNavigationHelper.detailSpendingLimitItemPath}/${CustomNavigationHelper.detailSpendingInSpendingLimitPath}',
                          extra: transformExpenseRecordByCateParent
                        );
                      },
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      title: const Text('Chi tiết khoản chi', style: defaultTextStyle),
                      trailing: const Icon(Icons.keyboard_arrow_right, color: iconColor, size: 33),),
                  ),
                  spaceColumn,
                  Container(
                    color: secondaryColor,
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      children: [
                        MyAreaChart(areaChartData: areaChartData),
                        const Divider(height: 1, color: underLineColor,indent: 30,endIndent: 30,),
                        spaceColumn6,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RichText(
                              text:  TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Thực tế chi tiêu",
                                      style: labelStyle
                                  ),
                                  const TextSpan(text: ' '),
                                  const WidgetSpan(
                                      child: CustomToolTip(
                                        tooltipText: 'ST đã chi / Khoảng thời gian chi tiêu',
                                      ),
                                      alignment: PlaceholderAlignment.middle
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Nên chi",
                                      style: labelStyle
                                  ),
                                  const TextSpan(text: ' '),
                                  const WidgetSpan(
                                      child: CustomToolTip(
                                        tooltipText: 'ST còn lại / Số ngày còn lại',
                                      ),
                                      alignment: PlaceholderAlignment.middle
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                        spaceColumn,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                      child: VndRichText(
                                        value: actualSpending,
                                        iconSize: 15, fontSize: textSmall,
                                      ),
                                      alignment: PlaceholderAlignment.middle
                                  ),
                                  const TextSpan(text: ' '),
                                  const TextSpan(text: '/ngày',  style: TextStyle(fontSize: 15, color: labelColor)),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                      child: VndRichText(
                                        value: shouldSpending,
                                        iconSize: 15, fontSize: textSmall,
                                      ),
                                      alignment: PlaceholderAlignment.middle
                                  ),
                                  const TextSpan(text: ' '),
                                  const TextSpan(text: '/ngày',  style: TextStyle(fontSize: 15, color: labelColor)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        spaceColumn6,
                        const Divider(height: 1, color: underLineColor,indent: 30,endIndent: 30,),
                        spaceColumn6,
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Dự kiến chi tiêu",
                                    style: labelStyle
                                ),
                                const TextSpan(text: ' '),
                                const WidgetSpan(
                                    child: CustomToolTip(
                                      tooltipText: 'Thực tế chi tiêu * Số ngày còn lại \n + ST đã chi',
                                    ),
                                    alignment: PlaceholderAlignment.middle
                                ),
                              ],
                            ),
                          ),
                        ),
                        spaceColumn,
                        Center(
                          child: VndRichText(
                            value: expectedSpending,
                            color: revenueMoneyColor,
                            iconSize: 15,
                            fontSize: textSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}

