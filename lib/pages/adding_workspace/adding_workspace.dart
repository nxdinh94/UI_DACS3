
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/divider.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/icon_key_board_arrow_right.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/models/cashs_flow_model.dart';
import 'package:practise_ui/providers/app_provider.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/utils/custom_toast.dart';
import 'package:practise_ui/widgets/adding_workspace/dropdown_adding_workspace.dart';
import 'package:practise_ui/widgets/adding_workspace/pick_contact_listtitle.dart';
import 'package:provider/provider.dart';
import '../../widgets/adding_workspace/expand_input_adding_space.dart';
import '../../widgets/dialog/dialog_ask_user_accept_policy.dart';
import '../../widgets/input_money_textfield.dart';
import '../../widgets/listtitle_textfield.dart';

class AddingWorkspace extends StatefulWidget {
  const AddingWorkspace({super.key});

  @override
  State<AddingWorkspace> createState() => _AddingWorkspaceState();
}

class _AddingWorkspaceState extends State<AddingWorkspace> {

  //initial currentCashFlowOption value
  late CashFlowModel currentCashFlowOption = CashFlowModel(
      id: '', iconPath: '', name: '', isChosen: 0
  );
  late String moneyType = '';// 3 options of dropdown
  List<CashFlowModel> cashFlowData = [];
  Map<String, dynamic> chosenAccountWallet = {};
  late String nameCashFlowCate = '';
  late bool alertOnNullMoneyTextField = false;
  late bool isFee = false;
  Map<String, dynamic> userData = {};


  // all value;
  late String idCashFlowCate = '';
  final TextEditingController moneyEditTextController = TextEditingController();
  final TextEditingController descriptEditTextController = TextEditingController();
  late String idChosenAccountWallet = '';
  String _selectedDate= '';
  late String contactPerson = '';
  final TextEditingController eventEditTextController = TextEditingController();
  late String revenueOrSpendingPerson= '';
  late int isBorrowToPay = 0;
  final TextEditingController costIncurredEditTextController = TextEditingController();
  late String idCostIncuredCategory = '';
  late int isNotIncludeInReport  = 0;


  void onSetIsFee(bool value){
    setState(() {
      isFee = value;
    });
  }
  void onSetIsIncludeInReport(int value){
    setState(() {
      isNotIncludeInReport = value;
    });
  }
  void onSelectCostIncuredCategory(String value, String fakeParames){
    setState(() {
      idCostIncuredCategory = value;
    });
  }
  void onSetIsBorrowToPay(int value){
    setState(() {
      isBorrowToPay = value;
    });
  }

  void onResetChosenContact(){
    setState(() {
      contactPerson = '';
    });
  }
  void onSelectContact(String value){
    setState(() {
      contactPerson = value;
    });
  }
  void onSelectCashFlowCate(String id, String name){

      idCashFlowCate = id;
      nameCashFlowCate = name;
  }

  void onSelectedDropdownItem(CashFlowModel selectedItem){
    setState(() {
      currentCashFlowOption  = selectedItem;
      moneyType = selectedItem.name;

    });
    // print(moneyType);
  }
  DateTime currentDate = DateTime.now();


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100),
    );
    if (picked != null && picked != currentDate) {
      setState(() {
        currentDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        _selectedDate = formattedDate;
      });
    }
  }
  @override
  void initState() {
    //if user doesnot accept policy
    userData = context.read<UserProvider>().meData;
    if(userData['agree_policy'] == 0){
      SchedulerBinding.instance.addPostFrameCallback((_) =>
          showDialogAskUserAccepPolicy(context));
    }
    cashFlowData = context.read<AppProvider>().cashFlowData;
    if(cashFlowData.isNotEmpty){
      currentCashFlowOption = cashFlowData[0];
      moneyType = currentCashFlowOption.name;
      for(var item in cashFlowData){
        if(item.isChosen == 1 ){
          currentCashFlowOption = item;
          moneyType = item.name;
          break;
        }
      }
    }
    _selectedDate = DateFormat('yyyy-MM-dd').format(currentDate);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      color: primaryColor,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          toolbarHeight: 52,
          leading: Padding(
            padding: paddingAll12,
            child: SvgPicture.asset(
              'assets/svg/history.svg', fit: BoxFit.fitWidth,
              colorFilter: const ColorFilter.mode(secondaryColor, BlendMode.srcIn),
            ),
          ),
          title: Padding(
            padding: paddingNone,
            child: cashFlowData.isEmpty
                ? const Text('None', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),)
                : DropDownAddingWorkspace(
                    addingDropdownDataApi: cashFlowData,
                    currentOption: currentCashFlowOption,
                    selectedItem: onSelectedDropdownItem,
                  ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () async {
                  Map<String, String> dataToSubmit = {
                    // required field
                    'cash_flow_category_id': idCashFlowCate,
                    'amount_of_money': moneyEditTextController.text.toString(),
                    'money_account_id': idChosenAccountWallet,

                    'occur_date': _selectedDate,
                    'trip_or_event': eventEditTextController.text,
                    'description': descriptEditTextController.text,
                    'report' : isNotIncludeInReport.toString(),
                  };
                  if( idCashFlowCate.isNotEmpty &&
                      moneyEditTextController.text.isNotEmpty&&
                      idChosenAccountWallet.isNotEmpty
                  ){
                    //if have borrow_to_pay
                    if(moneyType.toLowerCase().contains('chi tiền') ||
                        nameCashFlowCate.toLowerCase().contains('cho vay')||
                        nameCashFlowCate.toLowerCase().contains('trả nợ')
                    ){
                      if(isBorrowToPay == 1){
                        dataToSubmit['borrow_to_pay'] = isBorrowToPay.toString();
                      }else {
                        dataToSubmit.remove('borrow_to_pay');
                      }
                    }else {
                      dataToSubmit.remove('borrow_to_pay');
                    }
                    //if have fee
                    if(moneyType.toLowerCase().contains('chi tiền')
                        || nameCashFlowCate.toLowerCase().contains('cho vay')
                        || nameCashFlowCate.toLowerCase().contains('cho vay')
                    ){
                      if(isFee){
                        String id = idCostIncuredCategory;
                        dataToSubmit['cost_incurred'] = costIncurredEditTextController.text;
                        dataToSubmit['cost_incurred_category_id'] = id;
                      }else {
                        dataToSubmit.remove('cost_incurred');
                        dataToSubmit.remove('cost_incurred_category_id');
                      }
                    }else {
                      dataToSubmit.remove('cost_incurred');
                      dataToSubmit.remove('cost_incurred_category_id');
                    }

                    if(!moneyType.toLowerCase().contains('tiền')){
                      dataToSubmit.remove('trip_or_event');
                    }
                    if(
                      moneyType.toLowerCase().contains('chi tiền')||
                      nameCashFlowCate.toLowerCase().contains('cho vay')
                    ){
                      dataToSubmit['pay_for_who'] = contactPerson;
                    }
                    if(
                      moneyType.toLowerCase().contains('thu tiền')||
                      nameCashFlowCate.toLowerCase().contains('đi vay')
                    ){
                      dataToSubmit['collect_from_who'] = contactPerson;
                    }



                  }else {
                    if(idCashFlowCate.isEmpty){
                      showCustomErrorToast(context, 'Hạng mục không được trống', 1);
                    }
                    if(moneyEditTextController.text.isEmpty){
                      setState(() {alertOnNullMoneyTextField = true;});
                    }
                    if(idChosenAccountWallet.isEmpty){
                      showCustomErrorToast(context, 'Ví không được trống', 1);
                    }
                    return;
                  }
                  Map<String, dynamic> result = await Provider.of<UserProvider>(context, listen: false).addExpenseRecordProvider(dataToSubmit);
                  if(result['status'] == '200'){
                    showCustomSuccessToast(context, result['result'], duration: 1);
                    //reset all value
                    setState(() {
                      moneyEditTextController.text = '';
                      descriptEditTextController.text = '';
                      contactPerson = '';
                      eventEditTextController.text = '';
                      revenueOrSpendingPerson= '';
                      isBorrowToPay = 0;
                      costIncurredEditTextController.text = '';
                      isNotIncludeInReport  = 0;

                      onSetIsFee(false);
                      onSelectCostIncuredCategory('', '');
                      onSelectContact('');
                      currentCashFlowOption = CashFlowModel(
                          id: '', iconPath: '', name: '', isChosen: 0
                      );

                    });
                  }else {
                    showCustomErrorToast(context, result['result'], 1);
                  }
                },
                child: SvgPicture.asset(
                  'assets/svg/tick.svg',
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 38, // Adjust the width as needed
                  height: 38, // Adjust the height as needed
                ),
              ),
            )
          ],
        ),
        body: Container(
          color: backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                spaceColumn,
                //Phần điền số tiền
                InputMoneyTextField(
                  controller: moneyEditTextController,
                  title: 'Số tiền',
                  alertOnNull: alertOnNullMoneyTextField,
                ),
                spaceColumn,
                // Phần điền thông tin cần thiết
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      // Phần chọn lý do dùng tiền
                      ChooseCashFlowCategory(
                        cashFlowType:  moneyType,
                        onSelectCashFlowCate: onSelectCashFlowCate,
                      ),
                      dividerI76,
                      //Person loan
                      Visibility(
                        visible: moneyType.toLowerCase().contains('vay'),
                        child: PickContactListTile(
                          moneyType: moneyType,
                          nameCashFlowCate: nameCashFlowCate,
                          onSelectContact: onSelectContact,
                          onResetChosenContact: onResetChosenContact,
                          horizontalTitleGap: 21,
                        )
                      ),
                      dividerI76,
                      //_decribeSection
                      ListTitleTextField(
                        leading: SvgPicture.asset(
                          'assets/svg/text-align-left.svg', width: 30, height: 30,
                          colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
                        ),
                        hintText: 'Diễn giải',
                        controller: descriptEditTextController,
                      ),
                      dividerI76,

                      Container(
                        padding: paddingR8L24,
                        child: ListTile(
                          leading: SvgPicture.asset(
                            'assets/svg/calendar.svg', width: 26, height: 26,
                            colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
                          ),
                          title: Text(_selectedDate, style: defaultTextStyle),
                          trailing: keyBoardArrowRightIcon,
                          horizontalTitleGap: 23,
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                          onTap: (){
                              _selectDate(context);
                          },
                        ),
                      ),
                      dividerI76,
                      Container(
                        padding: const EdgeInsets.only(right: 8, left: 18),
                        child: ListTile(
                          leading: Container(
                            margin: const EdgeInsets.only(right: 13),
                            child: Image.asset(
                              chosenAccountWallet['icon']??
                              'assets/another_icon/wallet-2.png',
                              width: 40, height: 40,
                            ),
                          ),
                          horizontalTitleGap: 5,
                          title: Text(chosenAccountWallet['name']??'Ví', style: defaultTextStyle),
                          trailing: keyBoardArrowRightIcon,
                          contentPadding: const EdgeInsets.only(left: 0, top: 8, bottom: 8, right: 0),
                          onTap: ()async{

                            final result =await CustomNavigationHelper.router.push(
                             '${CustomNavigationHelper.addingWorkspacePath}/${CustomNavigationHelper.chooseAccountWalletPath}'
                            );
                            if(!context.mounted){return ;}
                            if(result != null){
                              setState(() {
                                chosenAccountWallet = result as Map<String, dynamic>;
                                idChosenAccountWallet = result['id'];
                              });
                            }

                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Phần thông tin chi tiết(optional)
                spaceColumn,
                //Expanded detailed option
                CustomDropdownMenu(
                  moneyType: moneyType,
                  nameCashFlowCate: nameCashFlowCate,
                  onSelectContact: onSelectContact,
                  onResetChosenContact: onResetChosenContact,
                  eventEditTextController: eventEditTextController,
                  onSetIsBorrowToPay: onSetIsBorrowToPay,
                  costIncuredEditTextController: costIncurredEditTextController,
                  onSelectCostIncuredCategory:onSelectCostIncuredCategory,
                  onSetIsIncludeInReport:onSetIsIncludeInReport,
                  isFee: isFee,
                  onSetIsFee: onSetIsFee,

                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}


class ChooseCashFlowCategory extends StatefulWidget {
  ChooseCashFlowCategory({
     required this.cashFlowType,
     required this.onSelectCashFlowCate
   });

  final String cashFlowType;
  final Function? onSelectCashFlowCate;
  @override
  State<ChooseCashFlowCategory> createState() => ChooseCashFlowCategoryState();
}

class ChooseCashFlowCategoryState extends State<ChooseCashFlowCategory> {
  late Map<String, dynamic> currentOption = {'icon' :'', 'name':'', 'id': ''};
  final TextStyle textStyle = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: textColor
  );
  @override
  void didUpdateWidget(covariant ChooseCashFlowCategory oldWidget) {
    if(oldWidget.cashFlowType != widget.cashFlowType){
      widget.onSelectCashFlowCate!('','');
      currentOption = {'icon' :'', 'name':''};
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: Image.asset(
        currentOption['icon'] != '' ? currentOption['icon'] : 'assets/another_icon/question-mark.png', width: 40, height: 40,
      ),
      title: currentOption['name'] != '' ?  Text(currentOption['name'], style: textStyle):Text('Chọn hạng mục', style: textStyle,),
      trailing: keyBoardArrowRightIcon,
      contentPadding: const EdgeInsets.only(left:  16, top: 8, bottom: 8, right: 8),
      onTap: ()async{
        final result = await CustomNavigationHelper.router.pushNamed(
          'selectCategory', extra: widget.cashFlowType
        );
        if(!context.mounted) return;
        if(result != null){
          setState(() {
            currentOption = result as  Map<String , dynamic>;
          });
          widget.onSelectCashFlowCate!(currentOption['_id'], currentOption['name']);
        }

      },
    );
  }
}

