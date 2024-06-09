import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/utils/custom_toast.dart';
import 'package:practise_ui/widgets/back_toolbar_button.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../utils/function/currency_format.dart';
class ChooseWalletPage extends StatefulWidget {
  const ChooseWalletPage({super.key});

  @override
  State<ChooseWalletPage> createState() => _ChooseWalletPageState();
}

class _ChooseWalletPageState extends State<ChooseWalletPage> {
  List<dynamic> convertData = [];
  List<Map<String, String>> chosenWalletList = [];
  @override
  void initState() {
    List<dynamic> accountWalletList = context.read<UserProvider>().accountWalletList;

    for(final e in accountWalletList){
      e['isCheck'] = true;
      convertData.add(e);
      chosenWalletList.add(
          {'_id': e['_id'], 'name': e['name']}
      );
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Chọn tài khoản', style: appBarTitleTextStyle,),
        leading: const BackToolbarButton(),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              if(chosenWalletList.isEmpty){
                showCustomErrorToast(context, 'Vui lòng chọn ví', 1);
                return;
              }
              Navigator.pop(context, chosenWalletList);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset(
                'assets/svg/tick.svg',
                colorFilter: const ColorFilter.mode(secondaryColor, BlendMode.srcIn),
                width: 38,
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: secondaryColor,
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: convertData.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder:(BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    onTap:() async{

                    },
                    leading: Image.asset(
                      convertData[index]['money_type_information']['icon']
                      , width: 40, height: 40,),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 7.0),
                      child: Text(convertData[index]['name']),
                    ),
                    titleTextStyle: const TextStyle(color: textColor, fontSize: textSize, fontWeight: FontWeight.w500),
                    subtitle: RichText(
                      text: TextSpan(
                          text: formatCurrencyVND(double.parse(convertData[index]['account_balance'][r'$numberDecimal'])),
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
                    trailing: Checkbox(
                      activeColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      side: WidgetStateBorderSide.resolveWith(
                            (states) => const BorderSide(width: 1.0, color: iconColor),
                      ),
                      mouseCursor: MouseCursor.uncontrolled,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onChanged: (value){
                        setState(() {
                          convertData[index]['isCheck'] = value;
                          if(value!){
                            chosenWalletList.add(
                                {'_id': convertData[index]['_id'], 'name': convertData[index]['name']}
                            );
                          }else {
                            chosenWalletList.removeAt(index);
                          }
                        });
                      },
                      value: convertData[index]['isCheck'],
                    ),
                  ),
                  const Divider(color: underLineColor, height: 0,)
                ],
              );
            }
        ),
      )
    );
  }
}
