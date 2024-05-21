
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/widgets/custom_popup_menu.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../providers/user_provider.dart';
import '../../utils/function/currency_format.dart';
import '../../utils/custom_navigation_helper.dart';
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
            return value.accountWalletList.isNotEmpty? HaveAccountCase(accountWalletData: value.accountWalletList): const NoAccountCase();
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
    return RefreshIndicator(
      onRefresh: ()async{
        await Provider.of<UserProvider>(context, listen: false).getAllAccountWallet();
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
                    TextSpan(text: formatCurrencyVND(totalMoney), style: const  TextStyle(fontWeight: FontWeight.bold)),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SvgPicture.asset(
                        'assets/svg/dong-svg-repo.svg', width: 15,
                        colorFilter: const ColorFilter.mode(Colors.black , BlendMode.srcIn),
                      ),
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
                        onTap:(){
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

class NoAccountCase extends StatelessWidget {
  const NoAccountCase({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Image.asset('assets/another_icon/grey-coin.png', width: 100,),
            spaceColumn,
            const Text('Bạn chưa có tài khoản nào',style: TextStyle(
              color: labelColor, fontSize: textSize
            )),
            spaceColumn6,
            GestureDetector(
              onTap: (){
                CustomNavigationHelper.router.push(
                  '${CustomNavigationHelper.accountWalletPath}/${CustomNavigationHelper.addAccountWalletPath}'
                );
              },
              child: RichText(
                text: const TextSpan(
                  text: '+',
                  style: TextStyle(color: primaryColor, fontSize: 22),
                  children: [
                    TextSpan(text: 'Thêm tài khoản', style:  TextStyle(
                        color: primaryColor, fontSize: textSize
                    ))
                  ]
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
