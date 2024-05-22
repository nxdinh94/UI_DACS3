import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/range_time_value.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/widgets/rich_text/right_arrow_rich_text.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../providers/user_provider.dart';
import '../../widgets/back_toolbar_button.dart';
import '../account_wallet/detail_account_wallet_page.dart';
class Notehistory extends StatefulWidget {
  const Notehistory({super.key});

  @override
  State<Notehistory> createState() => _NotehistoryState();
}

class _NotehistoryState extends State<Notehistory> {

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
            Container(
              color: secondaryColor,
              padding: paddingAll12,
              child: Center(
                child: RightArrowRichText(
                  text: rangeTimeData[0]['title'],
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            spaceColumn,
            Consumer<UserProvider>(
              builder: (context, value, child) {
                Map<String, dynamic> data = value.expenseRecordDataForNoteHistory;
                String totalRevenueMoney = data['response_revenue_money'][r'$numberDecimal'];
                String totalSpendingMoney = data['response_spending_money'][r'$numberDecimal'];
                // print(data);
                return Visibility(
                  // appear if both != 0
                  visible: !(totalSpendingMoney == '0' && totalRevenueMoney == '0'),
                  child: Container(
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
                );
              },
            ),
            spaceColumn,
            Consumer<UserProvider>(
              builder: (context, value, child) {
                Map<String, dynamic> data = value.expenseRecordDataForNoteHistory;
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
