import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/widgets/rounded_checkbox_icon.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../utils/currency_format.dart';
import '../../widgets/back_toolbar_button.dart';
class ChooseAccountWalletPage extends StatelessWidget {
  const ChooseAccountWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: primaryColor,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            'Chọn tài khoản',
            style: TextStyle(
                color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
            ),
          ),
          centerTitle: true,
          leading: const BackToolbarButton(),
        ),
        body: Consumer<UserProvider>(
          builder: (BuildContext context, UserProvider value, Widget? child) {
            List<dynamic> accountWalletList = value.accountWalletList;
            return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: accountWalletList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder:(BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                          leading: Image.asset(accountWalletList[index]['money_type_information']['icon'],
                            width: 40, height: 40,),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 7.0),
                            child: Text(accountWalletList[index]['name']),
                          ),
                          titleTextStyle: const TextStyle(color: textColor, fontSize: textSize, fontWeight: FontWeight.w500),
                          trailing: SizedBox(),
                          subtitle: RichText(
                            text: TextSpan(
                                text: formatCurrencyVND(double.parse(accountWalletList[index]['account_balance'][r'$numberDecimal'])),
                                style: const TextStyle(color: labelColor, fontSize: textSmall),
                                children: [
                                  WidgetSpan(
                                      child: SvgPicture.asset('assets/svg/dong-svg-repo.svg', width: 12, height: 12,
                                          colorFilter: const ColorFilter.mode(labelColor, BlendMode.srcIn)
                                      ),
                                      alignment: PlaceholderAlignment.middle
                                  )]
                            ),
                          ),
                          subtitleTextStyle: const TextStyle(color: labelColor,fontSize: textSize),
                          horizontalTitleGap: 10,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                          onTap: (){
                            Map<String, dynamic> resultToReturn = {
                              'id' : accountWalletList[index]['_id'],
                              'icon' : 'assets/another_icon/question-mark.png',
                              'name' : accountWalletList[index]['name'],
                            };
                            Navigator.pop(context, resultToReturn);
                          }
                      ),
                      const Divider(color: underLineColor, height: 0,)
                    ],
                  );
                }
            );
          }
        ),
      ),
    );
  }
}
