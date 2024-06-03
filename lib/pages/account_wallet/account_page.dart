
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/widgets/custom_popup_menu.dart';
import 'package:practise_ui/widgets/rich_text/vnd_rich_text.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../constant/range_time/range_time_for_expense_record.dart';
import '../../providers/user_provider.dart';
import '../../utils/function/currency_format.dart';
import '../../utils/custom_navigation_helper.dart';
import '../../widgets/empty_value_screen.dart';
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: primaryColor,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Tài khoản', style: TextStyle(
                color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
            ),
          ),
          centerTitle: true,
          leading: Builder(
              builder: (BuildContext context){
                return IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg/magnifying-glass.svg',
                    height: 22, width: 22,
                  ),
                  onPressed: (){},
                );
              }
          ),
        ),
        body:  Consumer<UserProvider>(
          builder: (context, value, child){
            List<dynamic> accountWalletList = value.accountWalletList;
            return accountWalletList.isNotEmpty?
                  HaveAccountCase(accountWalletData: accountWalletList):
                  const EmptyValueScreen(
                    title: 'Bạn chưa có tài khoản nào',
                  );
            }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            CustomNavigationHelper.router.push(
                '${CustomNavigationHelper.accountWalletPath}/${CustomNavigationHelper.addAccountWalletPath}'
            );
          },
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: SvgPicture.asset('assets/svg/plus.svg', height: 45, width: 45, ),
        ),
      ),
    );
  }
}
class HaveAccountCase extends StatefulWidget {
  const HaveAccountCase({super.key, required this.accountWalletData});
  final List<dynamic> accountWalletData;
  @override
  State<HaveAccountCase> createState() => _HaveAccountCaseState();
}

class _HaveAccountCaseState extends State<HaveAccountCase> {
  double totalMoney = 0;
  @override
  void initState() {
    for(var item in widget.accountWalletData){
      totalMoney += double.parse(item['account_balance'][r'$numberDecimal']);
    }
    super.initState();
  }
  @override
  void didUpdateWidget(covariant HaveAccountCase oldWidget) {
    if(oldWidget.accountWalletData != widget.accountWalletData){
      totalMoney = 0;
      for(var item in widget.accountWalletData){
        totalMoney += double.parse(item['account_balance'][r'$numberDecimal']);
      }
    }
    super.didUpdateWidget(oldWidget);
  }
   TextStyle richText1 = const TextStyle(
      color: textColor, fontSize: textBig, fontWeight: FontWeight.w600
  );
  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      onRefresh: ()async{
        await Provider.of<UserProvider>(context, listen: false).getAllAccountWallet();
      },
      indicatorBuilder: (BuildContext context, IndicatorController controller) {
        return LoadingAnimationWidget.hexagonDots(color: primaryColor, size: 30);
      },
      child: Container(
        color: backgroundColor,
        child: Column(
          children: [
            Container(
              color: secondaryColor,
              padding: paddingAll12,
              child: Center(
                child: RichText(
                  text: TextSpan(
                  text: 'Tổng tiền: ', style: richText1,
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: VndRichText(
                        value: totalMoney,
                        fontWeight: FontWeight.w700,
                        iconSize: 17,
                        fontSize: textBig,
                      )
                    ),
                  ],
                  ),
                )
              ),
            ),
            spaceColumn,
            Container(
              color: secondaryColor,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget.accountWalletData.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder:(BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap:() async{
                          // get data before forward page
                          await Provider.of<UserProvider>(context, listen: false)
                              .getAllExpenseRecordByAccountWalletProvider(widget.accountWalletData[index]['_id'], rangeTimeForExpenseRecord.first['value']!);

                          CustomNavigationHelper.router.push(
                              '${CustomNavigationHelper.accountWalletPath}/${CustomNavigationHelper.detailAccountWalletPath}',
                              extra: widget.accountWalletData[index] as Map<String, dynamic>
                          );
                        },
                        leading: Image.asset(
                          widget.accountWalletData[index]['money_type_information']['icon']
                          , width: 40, height: 40,),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 7.0),
                          child: Text(widget.accountWalletData[index]['name']),
                        ),
                        titleTextStyle: const TextStyle(color: textColor, fontSize: textSize, fontWeight: FontWeight.w500),
                        subtitle: RichText(
                          text: TextSpan(
                            text: formatCurrencyVND(double.parse(widget.accountWalletData[index]['account_balance'][r'$numberDecimal'])),
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
                        trailing: CustomPopupMenu(
                          representationIcon: SvgPicture.asset('assets/svg/three-dots-vertical.svg', width: 18),
                          selectedItemData: widget.accountWalletData[index] as Map<String, dynamic>,
                        ),

                      ),
                      const Divider(color: underLineColor, height: 0,)
                    ],
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

