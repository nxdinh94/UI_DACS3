import 'package:flutter/material.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/chart_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/utils/progress_bar.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';
import '../../../constant/font.dart';
import '../../../utils/function/currency_format.dart';
import '../../../utils/function/percentage_format.dart';
import '../../../widgets/charts/pie_chart.dart';
import '../../../widgets/empty_value_screen.dart';
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

  @override
  void initState() {
    if(expenseDataForChart.isNotEmpty){
      spendingMoneyData = expenseDataForChart['result']['spending_money'];
      for(var e in spendingMoneyData){
        totalSpendingMoney+= double.parse(e['total_money'][r'$numberDecimal']);
      }
    }
    super.initState();
  }
  @override

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<ChartProvider>(
        builder: (context, value, child) {
          expenseDataForChart = value.expenseRecordForChart;
          if(expenseDataForChart.isNotEmpty){
            spendingMoneyData = expenseDataForChart['result']['spending_money'];
            for(var e in spendingMoneyData){
              totalSpendingMoney+= double.parse(e['total_money'][r'$numberDecimal']);
            }
          }
          return Column(
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
                  Map<String, double> spendingData = value.filteredSpendingDataForPieChartHomePage;
                  if(spendingData.isEmpty){
                    return const EmptyValueScreen(
                      title: 'Không có bản ghi',
                      isAccountPage: false,
                      iconSize: 75,
                    );
                  }
                  return Container(
                    height: 240,
                    color: secondaryColor,
                    child: Center(
                        child: MyPieChart(
                          dataMap: spendingData,
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
          );
        },
      ),
    );
  }
}
