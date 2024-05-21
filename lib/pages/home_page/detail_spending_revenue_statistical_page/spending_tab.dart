import 'package:flutter/material.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/chart_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/utils/progress_bar.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';
import '../../../constant/font.dart';
import '../../../utils/currency_format.dart';
import '../../../utils/percentageFormat.dart';
import '../../../widgets/charts/pie_chart.dart';
import '../../../widgets/vnd_icon.dart';
class SpendingTab extends StatefulWidget {
  const SpendingTab({
    super.key
  });

  @override
  State<SpendingTab> createState() => _SpendingTabState();
}

class _SpendingTabState extends State<SpendingTab> {
  double totalSpendingMoney = 0;
  Map<String, dynamic> expenseDataForChart= {};
  List<dynamic> spendingMoneyData = [];

  int countIndex = -1;

  @override
  void initState() {
    expenseDataForChart = context.read<ChartProvider>().expenseRecordForChart;
    if(expenseDataForChart.isNotEmpty){
      spendingMoneyData = expenseDataForChart['result']['spending_money'];
      for(var e in spendingMoneyData){
        totalSpendingMoney+= double.parse(e['total_money'][r'$numberDecimal']);
      }
    }
    super.initState();
  }
  @override
  void dispose() {
    countIndex = -1;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
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
                Map<String, double> data = value.filteredSpendingDataForPieChartHomePage;
                return Visibility(
                  visible: data.isNotEmpty,
                  child: Container(
                    height: 240,
                    color: secondaryColor,
                    child: Center(
                      child: MyPieChart(
                        dataMap: data,
                        isShowLegend: false,
                        isShowChartValue: false,
                        isShowPercentageValue: true,
                        height: 200,
                      )
                    ),
                  ),
                );
              },
            ),
            spaceColumn,
            Container(
                color: secondaryColor,
                child: Column(
                  children: spendingMoneyData.asMap().map((i, e)=>MapEntry(i,
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
                  )).values.toList()
              )
            )
          ],
        ),
      ),
    );
  }
}
