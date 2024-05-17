import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/widgets/listtitle_textfield.dart';
import 'package:practise_ui/widgets/my_listtitle.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../utils/custom_navigation_helper.dart';
import '../../utils/custom_toast.dart';
import '../../widgets/back_toolbar_button.dart';
import '../../widgets/input_money_textfield.dart';
class AddAccountWalletPage extends StatefulWidget {
  const AddAccountWalletPage({super.key});

  @override
  State<AddAccountWalletPage> createState() => _AddAccountWalletPageState();
}

class _AddAccountWalletPageState extends State<AddAccountWalletPage> {
  //mainly variable
  final TextEditingController moneyTextFieldController  = TextEditingController();
  final TextEditingController creditTextFieldController  = TextEditingController();
  final TextEditingController describeTextFieldController  = TextEditingController();
  final TextEditingController nameWalletTextFieldController  = TextEditingController();
  bool isNotReport = false;
  String idMoneyAccountType = '';
  int idChosenBank = 0;

  //another variable
  Map<String, dynamic> resultChosenMoneyAccountType = {};
  Map<String, dynamic> resultChosenBank = {};
  String nameChosenAccountWalletType = '';
  bool alertNullNameWallet = false;
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
        leading:  const BackToolbarButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputMoneyTextField(
              title: 'Số dư ban đầu', controller: moneyTextFieldController,
            ),
            spaceColumn,
            
            Visibility(
              visible: nameChosenAccountWalletType.toLowerCase().contains('thẻ tín dụng'),
              maintainState: false,
              child: Column(
                children: [
                  InputMoneyTextField(
                    title: 'Hạn mức tín dụng', controller: creditTextFieldController,
                  ),
                  spaceColumn,
                ],
              )
            ),
            
            Container(
              color: secondaryColor,
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  ListTitleTextField(
                    leading: Image.asset('assets/another_icon/purse.png',width: 40, height: 40,),
                    hintText: 'Tên tài khoản',
                    controller: nameWalletTextFieldController,
                    paddingLeftLeading: 20,
                    alertWarming: alertNullNameWallet,
                  ),
                  divider,
                  MyListTile(
                    leading: Image.asset(
                      idMoneyAccountType.isNotEmpty ?
                      resultChosenMoneyAccountType['icon']:
                      'assets/another_icon/question-mark.png', width: 40, height: 40,
                    ),
                    centerText: idMoneyAccountType.isNotEmpty ?
                                resultChosenMoneyAccountType['name']:
                                'Chọn loại tài khoản',
                    trailing: trailing,
                    horizontalTitleGap: 19,
                    vertiCalPadding: 5,
                    onTap: ()async{
                      Map<String, dynamic> result = await CustomNavigationHelper.router.push(
                          '${CustomNavigationHelper.accountWalletPath}/'
                          '${CustomNavigationHelper.addAccountWalletPath}/'
                          '${CustomNavigationHelper.selectAccountWalletTypePath}',
                      ) as  Map<String, dynamic>;
                      if(!context.mounted){ return ; }
                      if(result.isNotEmpty){
                        setState(() {
                          resultChosenMoneyAccountType  = result;
                          idMoneyAccountType = result['_id'];
                          nameChosenAccountWalletType = result['name'];
                        });
                      }
                    }
                  ),
                  divider,
                  Visibility(
                    maintainState: false,
                    visible:
                    nameChosenAccountWalletType.toLowerCase().contains('tài khoản ngân hàng') ||
                    nameChosenAccountWalletType.toLowerCase().contains('thẻ tín dụng') ,
                    child: Column(
                      children: [
                        MyListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            child: ClipOval(
                              child: Image.network(
                                resultChosenBank.isNotEmpty ? resultChosenBank['logo'] :
                                'https://icones.pro/wp-content/uploads/2021/10/symbole-bancaire-gris.png',
                                width: 45,
                              ),
                            ),
                          ),
                          centerText: resultChosenBank['shortName'] ?? 'Ngân hàng',
                          trailing: trailing,
                          horizontalTitleGap: 20,
                          vertiCalPadding: 5,
                          onTap: ()async{
                            Map<String, dynamic> result = await CustomNavigationHelper.router.push(
                                '${CustomNavigationHelper.accountWalletPath}/'
                                    '${CustomNavigationHelper.addAccountWalletPath}/'
                                    '${CustomNavigationHelper.selectBankPath}'
                            ) as  Map<String, dynamic>;
                            if(!context.mounted){ return ; }
                            if(result.isNotEmpty){
                              resultChosenBank = result;
                              idChosenBank = result['id'];
                            }
                          }
                        )
                      ],
                    )
                  ),
                  divider,
                  ListTitleTextField(
                    leading: SvgPicture.asset(
                      'assets/svg/text-align-left.svg', width: 30, height: 30,
                      colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
                    ),
                    hintText: 'Diễn giải',
                    controller: describeTextFieldController,
                    paddingLeftLeading: 22,
                    horizontalTitleGap: 28,
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
                onPressed: () async {
                  Map<String, String> dataToPass = {
                    "name":"",
                    "account_balance": '0',
                    "money_account_type_id":"",
                    "description":"",
                    "report":'0',
                    "credit_limit_number" : '0',
                  };
                  dynamic result ;
                  //if 3 required field is not empty
                  if(nameWalletTextFieldController.text.isNotEmpty &&
                    moneyTextFieldController.text.isNotEmpty &&
                    idMoneyAccountType.isNotEmpty){

                    dataToPass.update('name', (value)=>nameWalletTextFieldController.text);
                    dataToPass.update('account_balance', (value)=>moneyTextFieldController.text);
                    dataToPass.update('money_account_type_id', (value)=>idMoneyAccountType);
                    dataToPass.update('description', (value)=>describeTextFieldController.text);
                    dataToPass.update('report', (value)=> isNotReport == true ? '1': '0');
                    if(
                        nameChosenAccountWalletType.toLowerCase().contains('tài khoản ngân hàng') ||
                        nameChosenAccountWalletType.toLowerCase().contains('thẻ tín dụng')
                    ){
                      dataToPass['select_bank'] = idChosenBank.toString();
                    }else {
                      dataToPass.remove('select_bank');
                    }

                    if(nameChosenAccountWalletType.toLowerCase().contains('thẻ tín dụng')){
                      if(creditTextFieldController.text.isNotEmpty){
                        dataToPass.update('credit_limit_number', (value) => creditTextFieldController.text);
                      }else {
                        dataToPass.update('credit_limit_number', (value) => '0');
                        showCustomErrorToast(context, 'Hạn mức tín dụng phải lớn hơn 0!', 3);
                        return;
                      }
                    //doesnot credit money type option
                    }else {
                      dataToPass.remove('credit_limit_number');
                      // showCustomSuccessToast(context, dataToPass['credit_limit_number'].toString());
                    }
                    result = await Provider.of<UserProvider>(context, listen: false).addMoneyAccount(dataToPass);

                    if(result['status']== 422){
                      print(dataToPass);
                      showCustomErrorToast(context, result['result'], 2);

                    }else if(result['status'] == 200){
                      showCustomSuccessToast(context, result['result']);
                      //trigger getData from db to update ui
                      await Provider.of<UserProvider>(context, listen: false).getAllAccountWallet();
                      setState(() {
                        moneyTextFieldController.text = '0';
                        creditTextFieldController.text = '0';
                        nameWalletTextFieldController.text = '';
                        describeTextFieldController.text = '';
                      });
                    }

                  //if 3 required field is empty
                  }else {
                    if(nameWalletTextFieldController.text.isEmpty){
                      setState(() {
                        alertNullNameWallet = true;
                      });
                    }
                    if(moneyTextFieldController.text.isEmpty){
                      showCustomErrorToast(context, 'Số tiền phải lớn hơn 0', 3);
                    }
                    if(idMoneyAccountType.isEmpty){
                      showCustomErrorToast(context, 'Vui lòng chọn loại tài khoản', 2);
                    }
                  }
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


