import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/widgets/listtitle_textfield.dart';
import 'package:practise_ui/widgets/my_listtitle.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../utils/custom_navigation_helper.dart';
import '../../widgets/input_money_textfield.dart';
class AddAccountWalletPage extends StatefulWidget {
  const AddAccountWalletPage({super.key});

  @override
  State<AddAccountWalletPage> createState() => _AddAccountWalletPageState();
}

class _AddAccountWalletPageState extends State<AddAccountWalletPage> {

  final TextEditingController moneyTextFieldController  = TextEditingController();
  final TextEditingController describeTextFieldController  = TextEditingController();
  final TextEditingController nameWalletTextFieldController  = TextEditingController();
  bool isNotReport = false;
  String idMoneyAccountType = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const divider =  Divider(height: 0, color: underLineColor,);
    const trailing =  Icon( Icons.keyboard_arrow_right, color: iconColor, size: 33);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Thêm tài khoản',
          style: TextStyle(
              color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: const Icon(
                    Icons.keyboard_arrow_left, color: secondaryColor, size: 43
                ),
                onPressed: () {
                  CustomNavigationHelper.router.pop();
                },
              );
            }
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputMoneyTextField(
              title: 'Số dư ban đầu', controller: moneyTextFieldController,
            ),
            spaceColumn,
            Container(
              color: secondaryColor,
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  ListTitleTextField(
                    leading: Image.asset('assets/account_type/credit.png',width: 40, height: 40,),
                    hintText: 'Tên tài khoản',
                    controller: nameWalletTextFieldController,
                    paddingLeftLeading: 20,
                  ),
                  divider,
                  MyListTile(
                    leading: Image.asset(
                      'assets/another_icon/question-mark.png', width: 40, height: 40,
                    ),
                    centerText: 'Tiền mặt',
                    trailing: trailing,
                    horizontalTitleGap: 19,
                    vertiCalPadding: 5,
                    onTap: (){}
                  ),
                  divider,
                  ListTitleTextField(
                    leading: SvgPicture.asset(
                      'assets/svg/text-align-left.svg', width: 30, height: 30,
                      colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
                    ),
                    hintText: 'Diễn giải',
                    controller: describeTextFieldController,
                    paddingLeftLeading: 21,
                    horizontalTitleGap: 30,
                  ),
                  divider,
                  // is include in report?
                  Container(
                    color: secondaryColor,
                    child: ListTile(
                      title: const  Text(
                        'Không tính vào báo cáo',
                        style: TextStyle(color: textColor, fontSize: textSize),
                      ),
                      subtitle: const Text(
                          'Ghi chép này sẽ không được thống kê vào TẤT CẢ các '
                              'báo cáo(trừ báo cáo Tài chính hiện tại)'
                      ),
                      subtitleTextStyle: const TextStyle(color: labelColor),
                      trailing: Switch(
                        value: isNotReport,
                        activeColor: switchColorButton,
                        trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),

                        thumbColor: const MaterialStatePropertyAll<Color>(secondaryColor),
                        onChanged: (bool value) {
                          setState(() {isNotReport = value;});

                        },
                      ),
                      contentPadding: const EdgeInsets.only(left: 16, top: 0, bottom: 0, right: 12),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 75,
              padding: paddingAll12,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  elevation: 0
                ),
                onPressed: (){
                  // print(nameWalletTextFieldController.text);
                  // print(moneyTextFieldController.text);
                  // print(describeTextFieldController.text);
                  // print(isNotReport);
                },
                child: const Text('LƯU', style: TextStyle(
                  color: secondaryColor, fontSize: textBig, letterSpacing: 2
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}


