import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:practise_ui/constant/divider.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/widgets/dash_line_painter/dash_line_painter.dart';
import 'package:practise_ui/widgets/rich_text/right_arrow_rich_text.dart';
import 'package:practise_ui/widgets/rich_text/vnd_rich_text.dart';

import '../../constant/color.dart';
import '../../utils/function/currency_format.dart';
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
                  text: 'Tháng này',
                  color: primaryColor,
                ),
              ),
            ),
            spaceColumn,
            Container(
              color: secondaryColor,
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: paddingAll12,
                        child: TotalRevenueOrSpendingItem(
                          title: 'Tổng thu', amountOfMoney: formatCurrencyVND(0), foreground: revenueMoneyColor,
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      color: underLineColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: paddingAll12,
                        child: TotalRevenueOrSpendingItem(
                          title: 'Tổng chi', amountOfMoney: formatCurrencyVND(0), foreground: spendingMoneyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            spaceColumn,
            Container(
              color: secondaryColor,
              padding: sidePadding,
              child: Column(
                children: [
                  Container(
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
                            size: Size(20, 1), // Set the width and height for the dashed line
                            painter: HorizontalDashedLinePainter(),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Image.asset(
                              'assets/icon_category/spending_money_icon/anUong/breakfast.png',
                              width: 30,
                            ),
                            title: Text('Ăn uống'),
                            trailing: VndRichText(value: 999999),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                            size: Size(20, 1), // Set the width and height for the dashed line
                            painter: HorizontalDashedLinePainter(),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Image.asset(
                              'assets/icon_category/spending_money_icon/anUong/breakfast.png',
                              width: 30,
                            ),
                            title: Text('Ăn uống'),
                            trailing: VndRichText(value: 999999),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                            size: Size(20, 1), // Set the width and height for the dashed line
                            painter: HorizontalDashedLinePainter(),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Image.asset(
                              'assets/icon_category/spending_money_icon/anUong/breakfast.png',
                              width: 30,
                            ),
                            title: Text('Ăn uống'),
                            trailing: VndRichText(value: 999999),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
