import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/widgets/back_toolbar_button.dart';
import 'package:practise_ui/widgets/rich_text/right_arrow_rich_text.dart';
import 'package:practise_ui/widgets/rich_text/vnd_rich_text.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../constant/range_time/range_time_for_expense_record.dart';
import '../../utils/function/show_the_day_of_the_week.dart';
import '../../widgets/dash_line_painter/dash_line_painter.dart';
class DetailAccountWalletPage extends StatefulWidget {
  const DetailAccountWalletPage({
    super.key,
    required this.accountWalletData,
  });
  final Map<String,dynamic> accountWalletData;
  @override
  State<DetailAccountWalletPage> createState() => _DetailAccountWalletPageState();
}

class _DetailAccountWalletPageState extends State<DetailAccountWalletPage> {
  String selectedTimeToShow = '';
  @override
  void initState() {
    selectedTimeToShow = rangeTimeForExpenseRecord.first['title'];

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    const Border dashBorder = DashedBorder(
      dashLength: 5, left: BorderSide(color: underLineColor, width: 1),
    );
    return  Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 52,
        leading: const Padding(
          padding:  EdgeInsets.only(bottom: 8.0),
          child: BackToolbarButton(),
        ),
        title: Text(widget.accountWalletData['name'], style: const TextStyle(
            color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 55,
              padding: paddingAll12,
              color: secondaryColor,
              child: Center(
                child: GestureDetector(
                  onTap: ()async{
                    Map<String, dynamic> result = await CustomNavigationHelper.router.push(
                        '${CustomNavigationHelper.accountWalletPath}/'
                        '${CustomNavigationHelper.selectTimeShowExpenseRecordPath}') as Map<String, dynamic>;
                    if(!context.mounted){return;}
                    if(result.isNotEmpty){
                      setState(() {
                        selectedTimeToShow = result['title'];
                      });
                      await Provider.of<UserProvider>(context, listen: false)
                          .getAllExpenseRecordByAccountWalletProvider(widget.accountWalletData['_id'], result['value']);
                    }
                  },
                  child: RightArrowRichText(
                      text: selectedTimeToShow, color: primaryColor, fontWeight: FontWeight.w500
                  ),
                )
              ),
            ),
            spaceColumn,
            Consumer<UserProvider>(
              builder: (context, value, child) {
                Map<String, dynamic> data = value.expenseRecordDataByAccountWallet;
                String totalRevenueMoney = data['response_revenue_money'][r'$numberDecimal'];
                String totalSpendingMoney = data['response_spending_money'][r'$numberDecimal'];
                // print(data);
                return Visibility(
                  // appear if both != 0
                  visible: !(totalSpendingMoney == '0' && totalRevenueMoney == '0'),
                  child: Column(
                    children: [
                      Container(
                        color: secondaryColor,
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: paddingAll12,
                                  child: TotalRevenueOrSpendingItem(
                                    title: 'Tổng thu',
                                    amountOfMoney: totalRevenueMoney,
                                    foreground: revenueMoneyColor,
                                  ),
                                ),
                              ),
                              const VerticalDivider(thickness: 1, color: underLineColor),
                              Expanded(
                                child: Padding(
                                  padding: paddingAll12,
                                  child: TotalRevenueOrSpendingItem(
                                    title: 'Tổng chi',
                                    amountOfMoney: totalSpendingMoney,
                                    foreground: spendingMoneyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      spaceColumn,
                    ],
                  ),
                );
              },
            ),
            Container(
              padding: paddingAll12,
              color: secondaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Số dư hiện tại', style: TextStyle(
                      color: labelColor, fontSize: textSize
                  )),
                  VndRichText(
                    value: double.parse(widget.accountWalletData['account_balance'][r'$numberDecimal']),
                    iconSize: 15,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
            ),
            spaceColumn,
            Consumer<UserProvider>(
              builder: (context, value, child) {
                Map<String, dynamic> data = value.expenseRecordDataByAccountWallet;
                List<dynamic> records = data['response_expense_record'];
                return BodyOfPage(records: records, dashBorder: dashBorder);
              },
            )
          ],
        ),
      ),
    );
  }
}

class BodyOfPage extends StatelessWidget {
  const BodyOfPage({
    super.key,
    required this.records,
    required this.dashBorder,
  });

  final List records;
  final Border dashBorder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: records.map((e){
        String date = e['date'];//yyyy-MM-dd
        String dayOfTheWeekOfItem = showTheDayOFTheWeek(date);

        final dateSplited = date.split('-');//[yyyy, mm , dd]
        final String transformDay = dateSplited[2];
        final String transformMonth = dateSplited[1];
        final String transformYear = dateSplited[0];
        List<dynamic> records = e['records'];
        //init value
        double totalRevenueMoney = 0;
        double totalSpendingMoney = 0;
        for(var e in records){
          if(e['cash_flow_type'] == 0){
            totalSpendingMoney += double.parse(e['amount_of_money'][r'$numberDecimal']);
          }else {
            totalRevenueMoney += double.parse(e['amount_of_money'][r'$numberDecimal']);
          }
        }

        return Column(
          children: [
            //whole items
            Container(
              color: secondaryColor,
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  //DateTime section
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        const VerticalDivider(color: primaryColor,width: 0,thickness: 6),
                        //day
                        Padding(
                          padding: sidePadding,
                          child: Text(transformDay, style: const TextStyle(
                            color: textColor, fontSize: 35, fontWeight: FontWeight.w700
                          )),
                        ),
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(dayOfTheWeekOfItem, style: const TextStyle(color: textColor, fontSize: textSize, fontWeight: FontWeight.w500)),
                            subtitle: Text(
                                '$transformMonth/$transformYear',
                                style: const TextStyle(color: labelColor, fontSize: textSmall)
                            ),
                            trailing: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                VndRichText(
                                  value: totalRevenueMoney,
                                  iconSize: 15,
                                  color: revenueMoneyColor,
                                ),
                                VndRichText(
                                  value: totalSpendingMoney,
                                  iconSize: 15,
                                  color: spendingMoneyColor,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //record
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: underLineColor))
                      ),
                      child: Column(
                        children: records.map((e){
                          return Container(
                            decoration: BoxDecoration(
                                border: dashBorder
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20, // Adjust the width as needed
                                  child: CustomPaint(
                                    size: const Size(20, 1), // Set the width and height for the dashed line
                                    painter: HorizontalDashedLinePainter(),
                                  ),
                                ),
                                Expanded(

                                  child: ListTile(
                                    onTap: (){
                                      CustomNavigationHelper.router.push(
                                        CustomNavigationHelper.updateWorkSpacePath,
                                        extra: e
                                      );
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    leading: Image.asset(
                                      e['icon'],
                                      width: 35,
                                    ),
                                    title: Text(e['name'], style: const TextStyle(fontSize: textSize, fontWeight: FontWeight.w500, color: textColor)),
                                    trailing: VndRichText(
                                      value: double.parse(e['amount_of_money'][r'$numberDecimal']), iconSize: 15,color: e['cash_flow_type'] == 0? spendingMoneyColor: revenueMoneyColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )

                ],
              ),
            ),
            spaceColumn
          ],
        );
      }).toList() ,
    );
  }
}
class TotalRevenueOrSpendingItem extends StatelessWidget {
  const TotalRevenueOrSpendingItem({
    super.key,
    required this.title,
    required this.amountOfMoney,
    required this.foreground,
  });
  final String title;
  final String amountOfMoney;
  final Color foreground;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const  TextStyle(color: textColor, fontSize: textSmall, fontWeight: FontWeight.w500)),
        VndRichText(
          value: double.parse(amountOfMoney),
          color: foreground, fontSize: textBig, iconSize: 15,
        )
      ],
    );
  }
}
