import 'package:flutter/material.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';
import '../../../constant/font.dart';
import '../../../utils/function/currency_format.dart';
import '../../../utils/function/format_iso_date_to_date.dart';
import '../../../widgets/back_toolbar_button.dart';
import '../../../widgets/vnd_icon.dart';
class DetailCashflowCategoryParent extends StatefulWidget {
  const DetailCashflowCategoryParent({super.key, required this.data});
  final Map<String, dynamic> data;
  @override
  State<DetailCashflowCategoryParent> createState() => _DetailCashflowCategoryParentState();
}

class _DetailCashflowCategoryParentState extends State<DetailCashflowCategoryParent> {

  List<dynamic> subItem = [];
  List<List> transformData = [];//[[a, a. a], [b,b],[c,c,c]]
  double totalMoney = 0;


  List<dynamic> allWalletUserData = [];
  String iconWallet = '';
  String nameWallet = '';
  @override
  void initState() {

    subItem = widget.data['items'];
    //group same element into a list and return a list of list group same element
    transformData = groupSameElements(subItem);

    // get all accountWallet of user
    allWalletUserData = context.read<UserProvider>().accountWalletList;
    super.initState();
  }
  // function group same element into a list and return a list of list group same element
  List<List<dynamic>> groupSameElements(List<dynamic> inputList) {
    // Map to store lists of elements
    Map<String, List<dynamic>> elementGroups = {};

    // Populate the map with elements from the input list
    for (var element in inputList){
      if (elementGroups.containsKey(element['cash_flow_category_id'])) {
        elementGroups[element['cash_flow_category_id']]!.add(element);
      } else {
        elementGroups[element['cash_flow_category_id']] = [element];
      }
    }

    // Extract the values from the map and return as a list of lists
    return elementGroups.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 52,
        leading: const Padding(
          padding:  EdgeInsets.only(bottom: 8.0),
          child: BackToolbarButton(),
        ),
        title: Text(widget.data['parent_name'], style: const TextStyle(
            color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
        )),
        centerTitle: true,

      ),
      body: Column(
        children: transformData.map((e){
            // reset value each loop
            totalMoney = 0;
            // cal total money of each parent
            for(var i in e){
              totalMoney+=double.parse(i['amount_of_money'][r'$numberDecimal']);
            }
            // find type of wallet
            for(var i in allWalletUserData){
              if(e[0]['money_account_id'] == i['_id']){
                iconWallet = i['money_type_information']['icon'];
                nameWallet = i['name'];
              }
            }
            return ColoredBox(
              color: secondaryColor,
              child: Column(
                children: [
                  ExpansionTile(
                    shape: const Border(),
                    title: Row(
                      children: [
                        Image.asset(e[0]['icon'], width: 40),
                        const SizedBox(width: 12,),
                        Text(e[0]['name'], style: const TextStyle(
                            color: textColor, fontSize: textSize, fontWeight: FontWeight.w500),),
                        ],
                    ),
                    trailing: RichText(
                      text: TextSpan(
                          text: formatCurrencyVND(totalMoney),
                          style: const TextStyle(fontSize: textSize, color: spendingMoneyColor),
                          children: const [
                            WidgetSpan(
                                child: VndIcon(color: spendingMoneyColor, size: textSmall),
                                alignment: PlaceholderAlignment.middle
                            )
                          ]
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    children: e.map((e1){
                      setState(() {
                        totalMoney+=double.parse(e1['amount_of_money'][r'$numberDecimal']);
                      });
                      return  ListTile(
                          leading: const SizedBox(),
                          subtitle: Text(e1['description'], style: const TextStyle(color: labelColor, fontSize: textSmall),) ,
                          title: Text(formatDate(e1['occur_date']), style: defaultTextStyle,),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: formatCurrencyVND(double.parse(e1['amount_of_money'][r'$numberDecimal'])),
                                    style: const TextStyle(fontSize: textSize, color: spendingMoneyColor),
                                    children:  const [
                                      WidgetSpan(
                                          child: VndIcon(color: spendingMoneyColor, size: textSmall),
                                          alignment: PlaceholderAlignment.middle
                                      )
                                    ]
                                ),
                              ),
                              const SizedBox(height: 3),
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(nameWallet, style: const TextStyle(color: labelColor, fontSize: 12)),
                                    const SizedBox(width: 2),
                                    Image.asset(iconWallet, width: 18),

                                  ],
                                ),
                              )
                            ],
                          ),
                      );
                    }).toList(),
                  ),
                  const Divider(height: 0, color: underLineColor,)
                ],
              ),
            );
        }).toList(),
      ),
    );
  }
}
