
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/utils/custom_toast.dart';
import 'package:practise_ui/widgets/back_toolbar_button.dart';
import 'package:practise_ui/widgets/custom_stack_three_images.dart';
import 'package:practise_ui/widgets/input_money_textfield.dart';
import 'package:provider/provider.dart';
import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../providers/user_provider.dart';
import '../../utils/custom_navigation_helper.dart';
import '../../widgets/dialog/show_limit_to_add_spending_limit.dart';
import '../../widgets/my_listtitle.dart';
class AddSpendingLimitPage extends StatefulWidget {
  const AddSpendingLimitPage({super.key});

  @override
  State<AddSpendingLimitPage> createState() => _AddSpendingLimitPageState();
}

class _AddSpendingLimitPageState extends State<AddSpendingLimitPage> {
  //all value
  late final TextEditingController _moneyInputController  = TextEditingController();
  late final TextEditingController _nameSpendingLitmit    = TextEditingController();
  String firstDayOfMonth = '';
  String endDayOfMonth = '';
  String idRepeatTime = '665aff73d0afad070a580426';
  List<String> idWalletList = [];
  List<dynamic> allSpendingLimit = [];


  bool alertMoneyNull = false;
  bool isNextPeriod = false;
  String repeatTitle = 'Hàng tháng';
  List<String> listNameOfWallet = [];

  DateTime selectedStartDate = DateTime.now();

  //Providing a day value of zero for the next month gives you the previous month's last day
  DateTime nextMonth = DateTime.now();
  DateTime selectedEndDate = DateTime.now();


  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedStartDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        firstDayOfMonth = formattedDate;
      });
    }
  }
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedEndDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        endDayOfMonth = formattedDate;
      });
    }
  }

  @override
  void initState() {

    allSpendingLimit = context.read<UserProvider>().allSpendingLimit;

    firstDayOfMonth = '${DateTime.now().year}-0${DateTime.now().month}-01';
    selectedStartDate = DateFormat('yyyy-MM-dd').parse(firstDayOfMonth);
    nextMonth = DateTime(DateTime.now().year, DateTime.now().month+1, 0);
    endDayOfMonth = '${DateTime.now().year}-0${DateTime.now().month}-${nextMonth.day}';
    selectedEndDate = DateFormat('yyyy-MM-dd').parse(endDayOfMonth);

    //default is all id of accountWallet
    List<dynamic> accountWalletList = context.read<UserProvider>().accountWalletList;

    for(final e in accountWalletList){
      idWalletList.add(e['_id']);
      listNameOfWallet.add(e['name']);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    const Divider divider = Divider(height: 1, color: underLineColor,indent: 85, endIndent: 12,);
    const sidePaddingRL = EdgeInsets.only(right: 12, left: 20);
    const marginRight =  EdgeInsets.only(right: 30);
    const trailing = Icon( Icons.keyboard_arrow_right, color: iconColor, size: 33);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Thêm hạn mức chi",
          style: TextStyle(color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: const BackToolbarButton(),
      ),
      body: Container(
        color: backgroundColor,
        child: ListView(
          children: [
            InputMoneyTextField(
              controller: _moneyInputController,
              title: 'Số tiền',
              alertOnNull: alertMoneyNull,
            ),
            spaceColumn,
            Container(
              padding: const EdgeInsets.only(top: 8),
              color: secondaryColor,
              child: Column(
                children: [
                  Padding(
                    padding: sidePaddingRL,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Wrap the SvgPicture.asset in a SizedBox to give it a fixed size
                        Container(
                          margin: marginRight,
                          width: 35, // Adjust the width as needed
                          height: 35, // Adjust the height as needed
                          child: SvgPicture.asset(
                            'assets/svg/abc.svg',
                            colorFilter: const ColorFilter.mode(labelColor, BlendMode.srcIn),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _nameSpendingLitmit,
                            style: const TextStyle(
                              fontSize: textSize,
                              height: 25 / textSize,
                              color: textColor,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                              border: InputBorder.none,
                              hintText: 'Tên hạn mức',
                              hintStyle: TextStyle(color: labelColor)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  spaceColumn6,
                  divider,
                  MyStackListTile(
                    leading: const StackThreeCircleImages(
                      imageOne: 'assets/icon_category/spending_money_icon/anUong/dinner.png',
                      imageTwo: 'assets/icon_category/spending_money_icon/anUong/cutlery.png',
                      imageThree: 'assets/icon_category/spending_money_icon/anUong/burger_parent.png'
                  ),
                    centerText: 'Tất cả hạng mục',
                    trailing: trailing,
                    onTap: (){},
                  ),
                  divider,
                  MyListTile(
                    leading: SvgPicture.asset(
                      'assets/svg/wallet.svg', height: 30,
                      colorFilter: const ColorFilter.mode(labelColor, BlendMode.srcIn),
                    ),
                    centerText: listNameOfWallet.join(", "),
                    trailing: trailing,
                    onTap: ()async{
                      List<Map<String, dynamic>>result = await CustomNavigationHelper.router.push(
                        '${CustomNavigationHelper.addSpendingLimitPath}/${CustomNavigationHelper.selectWalletSpendingPath}'
                      ) as List<Map<String, dynamic>>;
                      if(!context.mounted){return;}
                      if(result.isNotEmpty){
                        //reset value
                        idWalletList.clear();
                        listNameOfWallet.clear();
                        setState(() {
                          for(final e in result){
                            idWalletList.add(e['_id']);
                            listNameOfWallet.add(e['name']);
                          }
                        });
                      }
                    }
                  ),
                  divider,
                ],
              ),
            ),
            spaceColumn,
            Container(
              color: secondaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyListTile(
                    leading: SvgPicture.asset(
                      'assets/svg/refresh.svg',
                      width: 25,
                      colorFilter: const ColorFilter.mode(labelColor, BlendMode.srcIn),
                    ),
                    centerText: repeatTitle,
                    trailing: trailing,
                    onTap: () async {
                      Map<String, dynamic > result =
                      await CustomNavigationHelper.router.push(
                          '${CustomNavigationHelper.addSpendingLimitPath}/${CustomNavigationHelper.repeatTimeForSpendingLimitPath}'
                      ) as Map<String, dynamic>;
                      if(!context.mounted){return;}
                      if(result.isNotEmpty){
                        setState(() {
                          idRepeatTime = result['_id'];
                          repeatTitle = result['name'];
                        });
                      }
                    }
                  ),
                  divider,
                  MyDateListTile(
                      leading: SvgPicture.asset(
                        'assets/svg/calendar.svg',
                        width: 25,
                        colorFilter: const ColorFilter.mode(labelColor, BlendMode.srcIn),
                      ),
                      title: 'Ngày bắt đầu',
                      subtitle: Text(firstDayOfMonth),
                      trailing: const SizedBox(height: 0),
                      onTap: () async{
                        await _selectStartDate(context);
                      }
                  ),
                  divider,
                  MyDateListTile(
                      leading: SvgPicture.asset(
                        'assets/svg/calendar.svg',
                        width: 25,
                        colorFilter: const ColorFilter.mode(labelColor, BlendMode.srcIn),
                      ),
                      title: 'Ngày kết thúc',
                      subtitle: Text(endDayOfMonth),
                      trailing:  const SizedBox(height: 0),
                      onTap: (){
                        _selectEndDate(context);
                      }
                  ),
                  divider,
                  spaceColumn6,
                  Padding(
                    padding: sidePadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Dồn sang kì sau', style: TextStyle(
                          fontSize: textSize, color: textColor
                        ),),
                        Switch(
                          value: isNextPeriod,
                          activeColor: switchColorButton,
                          trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
                          thumbColor: const WidgetStatePropertyAll<Color>(secondaryColor),
                          onChanged: (bool value) {
                            setState(() {
                              isNextPeriod= value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: sidePadding,
                    child: Text(
                      'Số tiền dư hoặc bội chi sẽ được chuyển sang kì sau',
                      style: TextStyle(color: labelColor, fontSize: textSmall),
                    ),
                  ),
                  spaceColumn
                ],
              ),
            ),
            Container(
              padding: paddingAll12,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: ()async{
                  // if(allSpendingLimit.length == 1){
                  //   showLimitToAddDialog(context);
                  //   return;
                  // }
                  Map<String, dynamic> dataToSubmit = {
                    'amount_of_money': _moneyInputController.text,
                    'name': _nameSpendingLitmit.text,
                    'money_account_id': idWalletList,
                    'cash_flow_category_id':["663a2d6342d9f401e41b0901"],
                    'repeat': idRepeatTime,
                    'start_time': firstDayOfMonth,
                    'end_time': endDayOfMonth
                  };
                  if(_nameSpendingLitmit.text.isNotEmpty && _moneyInputController.text.isNotEmpty){
                    bool result = await Provider.of<UserProvider>(context, listen: false).addSpendingLimitProvider(dataToSubmit);
                    if(result){
                      showCustomSuccessToast(context, 'Đã ghi!', duration: 1);
                      _moneyInputController.text ='';
                      _nameSpendingLitmit.text ='';
                      await Provider.of<UserProvider>(context, listen: false).getAllSpendingLimitProvider();
                      Navigator.pop(context, false);
                    }else{
                      showCustomErrorToast(context, 'Tên hạn mức tồn tại', 1);
                    }
                    setState(() {
                      alertMoneyNull = false;
                    });
                  }else {
                    showCustomErrorToast(context, 'Tên không được trống', 1);
                    setState(() {
                      alertMoneyNull = true;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  backgroundColor: primaryColor,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('LƯU', style:
                    TextStyle(fontSize: textBig,color: secondaryColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyStackListTile extends StatelessWidget {
  const MyStackListTile({
    super.key, required this.leading, required this.centerText, required this.trailing,required this.onTap,
  });
  final Widget leading;
  final String centerText;
  final Widget trailing;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: ListTile(
        // dense: true,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
        horizontalTitleGap: 0,
        leading: leading,
        title: Text(
          centerText,
          style: const TextStyle(fontSize: textSize, color: textColor),
        ),
        trailing: trailing,
      ),
    );
  }
}

class MyDateListTile extends StatelessWidget {
  const MyDateListTile({
    super.key, required this.leading, required this.title, required this.subtitle, required this.trailing,required this.onTap,
  });
  final Widget leading;
  final String title;
  final Widget subtitle;
  final Widget trailing;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    const sidePaddingRL = EdgeInsets.only(right: 2, left: 20);
    return Padding(
      padding: sidePaddingRL,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        horizontalTitleGap: 35,
        // dense: true,
        // isThreeLine: true,
        visualDensity:const VisualDensity(horizontal: 0, vertical: -4),
        leading: leading,
        title: Text(
          title, style: const TextStyle(fontSize: textSmall, color: labelColor),
        ),
        subtitle: subtitle,
        subtitleTextStyle: const TextStyle(fontSize: textSize, color: textColor),
        trailing: trailing,
      ),
    );
  }
}
