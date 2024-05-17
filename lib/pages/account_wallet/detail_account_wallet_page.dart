import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/utils/currency_format.dart';
import 'package:practise_ui/widgets/back_toolbar_button.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
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
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(top: 10),
      color: primaryColor,
      child: Scaffold(
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
                  child: RichText(
                  text: TextSpan(
                    text: '30 ngày gần nhất',
                    style: const TextStyle(
                        color: primaryColor, fontSize: textSize, fontWeight: FontWeight.w500
                    ),
                    children: [
                      const WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(Icons.keyboard_arrow_right, size: 30, color: primaryColor,)
                      )
                    ]
                  )),
                ),
              ),
              spaceColumn,
              Container(
                color: secondaryColor,
                padding: paddingAll12,
                child: Row(
                  children: [
                    Expanded(
                      child: TotalRevenueOrSpendingItem(
                        title: 'Tổng thu', amountOfMoney: formatCurrencyVND(0), foreground: revenueMoneyColor,
                      ),
                    ),
                    Container(
                      width: 2,
                      color: underLineColor,
                      child: const VerticalDivider(
                        width: 20,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: TotalRevenueOrSpendingItem(
                        title: 'Tổng chi', amountOfMoney: formatCurrencyVND(0), foreground: spendingMoneyColor,
                      ),
                    ),
                  ],
                ),
              ),
              spaceColumn,
              Container(
                color: secondaryColor,
                padding: paddingAll12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Số dư hiện tại',style: TextStyle(color: labelColor, fontSize: textSize)),
                    RichText(
                      text: TextSpan(
                        text:  formatCurrencyVND(double.parse(widget.accountWalletData['account_balance'][r'$numberDecimal'])),
                        style: const TextStyle(fontSize: textBig, fontWeight: FontWeight.w700, color: textColor),
                        children: [
                          WidgetSpan(
                            child: SvgPicture.asset('assets/svg/dong-svg-repo.svg', width: 15,
                            colorFilter:const ColorFilter.mode(textColor, BlendMode.srcIn),),
                            alignment: PlaceholderAlignment.middle
                          )
                        ]
                      )
                    )
                  ]
                ),
              )
            ],
          ),
        ),
      ),
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
        spaceColumn6,
        RichText(
          text: TextSpan(
            text: '0',
            style: TextStyle(color: foreground, fontSize: textSize, fontWeight: FontWeight.w500),
            children: [
              WidgetSpan(
                child: SvgPicture.asset(
                  'assets/svg/dong-svg-repo.svg', width: 15,
                  colorFilter: ColorFilter.mode(foreground, BlendMode.srcIn),
                ),
                alignment: PlaceholderAlignment.middle
              )
            ]
          )
        )
      ],
    );
  }
}
