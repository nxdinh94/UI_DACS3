import 'package:flutter/material.dart';
import 'package:practise_ui/constant/divider.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/widgets/back_toolbar_button.dart';
import 'package:practise_ui/widgets/my_listtitle.dart';
import 'package:practise_ui/widgets/rich_text/vnd_rich_text.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
class CurrentFinances extends StatefulWidget {
  const CurrentFinances({super.key});

  @override
  State<CurrentFinances> createState() => _CurrentFinancesState();
}

class _CurrentFinancesState extends State<CurrentFinances> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Tài chính hiện tại'),
        leading: const BackToolbarButton(),
        titleTextStyle: appBarTitleTextStyle,
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Consumer<UserProvider>(
        builder: (context, value, child) {
          List<dynamic> accountWalletList = value.accountWalletList;
          double totalMoney = 0;
          for(var item in accountWalletList){
            totalMoney += double.parse(item['account_balance'][r'$numberDecimal']);
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: paddingAll12,
                  color: secondaryColor,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tài chính hiện tại', style: defaultTextStyle),
                        VndRichText(value: totalMoney, fontSize: textBig, iconSize: 16, fontWeight: FontWeight.w700,),
                      ]
                  ),
                ),
                spaceColumn,spaceColumn,
                Container(
                  padding: sidePadding,
                  color: secondaryColor,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Tổng có', style: defaultTextStyle),
                              VndRichText(value: totalMoney, fontSize: textBig, iconSize: 16, fontWeight: FontWeight.w700,),
                            ]
                        ),
                      ),
                      defaultDivider
                    ],
                  ),
                ),
                Container(
                  color: secondaryColor,
                  padding: sidePadding,
                  child: Column(
                    children: accountWalletList.map((e){
                      double accountBalance = double.parse(e['account_balance'][r'$numberDecimal']);
                      return Column(
                        children: [
                          MyListTile(
                              leading: Image.asset(e['money_type_information']['icon'], width: 40,),
                              centerText: e['name'],
                              trailing: VndRichText(value: accountBalance, iconSize: 16),
                              horizontalTitleGap: 15,
                              leftPadding: 0,
                              onTap: (){

                              }
                          ),
                          defaultDivider
                        ],
                      );
                    }).toList(),
                  )
                )
              ],
            ),
          );
        },

      ),
    );
  }
}
