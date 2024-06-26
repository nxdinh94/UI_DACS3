import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/widgets/empty_value_screen.dart';
import 'package:practise_ui/widgets/rich_text/right_arrow_rich_text.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/range_time/range_time_for_expense_record.dart';
import '../../providers/user_provider.dart';
import '../../utils/custom_navigation_helper.dart';
import '../../widgets/back_toolbar_button.dart';
import '../../widgets/loading_animation.dart';
import '../account_wallet/detail_account_wallet_page.dart';
class NoteHistory extends StatefulWidget {
  const NoteHistory({super.key});

  @override
  State<NoteHistory> createState() => _NoteHistoryState();
}

class _NoteHistoryState extends State<NoteHistory> {
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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 52,
        leading: const BackToolbarButton(),
        title: const Text('Lịch sử ghi chép',style: TextStyle(color: secondaryColor, fontSize: textSize)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: ()async{
                Map<String, dynamic> result = await CustomNavigationHelper.router.push(
                    '${CustomNavigationHelper.homePath}/'
                        '${CustomNavigationHelper.selectTimeShowExpenseRecordPath}') as Map<String, dynamic>;
                if(!context.mounted){return;}
                if(result.isNotEmpty){
                  setState(() {
                      selectedTimeToShow  = result['title'];
                  });
                  await Provider.of<UserProvider>(context, listen: false)
                      .getAllExpenseRecordForNoteHistoryProvider(result['value']);
                }
              },
              child: Container(
                color: secondaryColor,
                padding: paddingAll12,
                child: Center(
                    child: RightArrowRichText(
                        text: selectedTimeToShow, color: primaryColor, fontWeight: FontWeight.w500
                    )
                ),
              ),
            ),
            spaceColumn,
            Consumer<UserProvider>(
              builder: (context, value, child) {
                Map<String, dynamic> data = value.expenseRecordDataForNoteHistory;
                String totalRevenueMoney = '0';
                String totalSpendingMoney = '0';
                if(data.isNotEmpty){
                  totalRevenueMoney = data['response_revenue_money'][r'$numberDecimal'];
                  totalSpendingMoney = data['response_spending_money'][r'$numberDecimal'];
                }
                // print(data);
                return Container(
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
                );
              },
            ),
            spaceColumn,
            Consumer<UserProvider>(
              builder: (context, value, child) {
                Map<String, dynamic> data = value.expenseRecordDataForNoteHistory;
                List<dynamic> records = data['response_expense_record'] ?? [];
                if(value.isLoadingExpenseRecordDataForNoteHistory){
                  return const Center(
                    child: LoadingAnimation(
                      iconSize: 80,
                      containerHeight: 500,
                    ),
                  );
                }
                if(records.isEmpty){
                  return const  EmptyValueScreen(title: 'Không có dữ liệu!', isAccountPage: false);
                }
                return BodyOfPage(records: records, dashBorder: dashBorder);
              },
            )
          ],
        ),
      ),
    );
  }
}
