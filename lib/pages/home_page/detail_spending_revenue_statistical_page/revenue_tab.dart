import 'package:flutter/material.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/chart_provider.dart';
import 'package:practise_ui/utils/progress_bar.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';
import '../../../constant/font.dart';
import '../../../utils/function/currency_format.dart';
import '../../../utils/custom_navigation_helper.dart';
import '../../../utils/function/percentage_format.dart';
import '../../../widgets/charts/pie_chart.dart';
import '../../../widgets/vnd_icon.dart';
import '../../account_wallet/account_page.dart';
class RevenueTab extends StatefulWidget {
  const RevenueTab({
    super.key
  });

  @override
  State<RevenueTab> createState() => _RevenueTabState();
}

class _RevenueTabState extends State<RevenueTab> {
  double totalSpendingMoney = 0;
  Map<String, dynamic> expenseDataForChart= {};
  List<dynamic> revenueMoneyData = [];

  int countIndex = 0;

  @override
  void initState() {
    countIndex = -1;

    expenseDataForChart = context.read<ChartProvider>().expenseRecordForChart;
    if(expenseDataForChart.isNotEmpty){
      revenueMoneyData = expenseDataForChart['result']['revenue_money'];
      for(var e in revenueMoneyData){
        totalSpendingMoney+= double.parse(e['total_money'][r'$numberDecimal']);
      }
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: secondaryColor,
            padding: paddingAll12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tổng chi', style: TextStyle(color: labelColor, fontSize: textSize),),
                RichText(
                  text: TextSpan(
                      text: formatCurrencyVND(totalSpendingMoney),
                      style: const TextStyle(fontSize: textSize, color: textColor, fontWeight: FontWeight.bold),
                      children: const [
                        WidgetSpan(
                            child: VndIcon(color: textColor, size: textSmall),
                            alignment: PlaceholderAlignment.middle
                        )
                      ]
                  ),
                ),
              ],
            ),
          ),
          spaceColumn,
          Consumer<ChartProvider>(
            builder: (context, value, child){
              Map<String, double> revenueData = value.filteredRevenueDataForPieChartHomePage;
              if(revenueData.isEmpty){
                return NoAccountCase();
              }
              return Container(
                height: 240,
                color: secondaryColor,
                child: Center(
                  child: MyPieChart(
                    dataMap: revenueData,
                    isShowLegend: false,
                    isShowChartValue: false,
                    isShowPercentageValue: true,
                    height: 200,
                  )
                ),
              );
            },
          ),
          spaceColumn,
          Container(
              color: secondaryColor,
              child: Column(
                children: revenueMoneyData.asMap().map((i, e)=> MapEntry(i,
                  Column(
                    children: [
                      Container(
                        padding: sidePadding,
                        child: Column(
                          children: [
                            ListTile(
                              onTap: (){
                                CustomNavigationHelper.router.push(
                                    '${CustomNavigationHelper.homePath}/${CustomNavigationHelper.detailCashFlowCategoryParentPath}',
                                    extra: e
                                );
                              },
                              dense: true,

                              leading: Image.asset(e['parent_icon'], width: 28),
                              title: Text(e['parent_name'], style: defaultTextStyle,),
                              contentPadding: EdgeInsets.zero,
                              horizontalTitleGap: 4,
                              trailing: RichText(
                                text: TextSpan(
                                  text: formatCurrencyVND(double.parse(e['total_money'][r'$numberDecimal'])),
                                    style: const TextStyle(fontSize: textSmall, color: textColor),
                                    children: [
                                      const WidgetSpan(
                                          child: VndIcon(color: textColor, size: 13),
                                          alignment: PlaceholderAlignment.middle
                                      ),
                                      TextSpan(
                                          text:'( ${e['percentage']} )',
                                          style: const TextStyle(color: labelColor, fontSize: textSmall)
                                      ),
                                      const WidgetSpan(
                                          alignment: PlaceholderAlignment.middle,
                                          child:  Icon(
                                            Icons.keyboard_arrow_right, color: iconColor, size: 23,
                                          ))
                                    ]
                                ),
                              ),
                            ),
                            MyProgressBar(
                              percentage: percentageStringToDouble(e['percentage'])/100,
                              color: pieChartColorList[i],
                              lineHeight: 7,
                            )
                          ],
                        ),
                      ),
                    const Divider(color: underLineColor,)
                  ],
                  )
                )).values.toList(),
            )
          )
        ],
      ),
    );
  }
}
