
import 'package:flutter/material.dart';
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
import 'package:practise_ui/widgets/back_toolbar_button.dart';
import 'package:provider/provider.dart';
import '../../widgets/adding_workspace/expand_input_update_adding_space.dart';
import '../../widgets/input_money_textfield.dart';
import '../../widgets/listtitle_textfield.dart';

class UpdateWorkspace extends StatefulWidget {
  const UpdateWorkspace({super.key, required this.dataToUpdate});
  final Map<String, dynamic> dataToUpdate;
  @override
  State<UpdateWorkspace> createState() => _UpdateWorkspaceState();
}

class _UpdateWorkspaceState extends State<UpdateWorkspace> {

  //initial currentCashFlowOption value
  late CashFlowModel currentCashFlowOption = CashFlowModel(
      id: '', iconPath: '', name: '', isChosen: 0
  );

  Map<String, dynamic> currentCashFlowCate = {'icon' :'', 'name':''};

  late String cashFlowType = '';// 3 options of dropdown
  List<CashFlowModel> cashFlowData = [];
  Map<String, dynamic> chosenAccountWallet = {};//{name:'', icon:''}
  late String nameCashFlowCate = '';
  late bool alertOnNullMoneyTextField = false;
  late bool isFee = false;
  List<dynamic> allWalletUserData = [];
  Map<String, dynamic> cashFlowCategoryData = {};
  List<dynamic> cashFlowFiltered = [];
  String initialMoney = '';
  
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
      cashFlowType = selectedItem.name;

    });
    // print(cashFlowType);
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
    currentDate = DateTime.parse( widget.dataToUpdate['occur_date']);
    _selectedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    cashFlowData = context.read<AppProvider>().cashFlowData;
    allWalletUserData = context.read<UserProvider>().accountWalletList;
    cashFlowCategoryData = context.read<AppProvider>().cashFlowCateData;
    isFee = widget.dataToUpdate['cost_incurred_category_id']!="";



    //get required value
    idCashFlowCate = widget.dataToUpdate['cash_flow_category_id'];


    //get cash-flow item
    if(cashFlowData.isNotEmpty){
      for(var item in cashFlowData){
        if(item.id == widget.dataToUpdate['cash_flow_id'] ){
          currentCashFlowOption = item;
          cashFlowType = item.name;
          break;
        }
      }
    }

    if(cashFlowCategoryData.isNotEmpty) {
      if (cashFlowType.toLowerCase().contains('chi')) {
        cashFlowFiltered = cashFlowCategoryData['spending_money'];
      } else if (cashFlowType.toLowerCase().contains('thu')) {
        cashFlowFiltered = cashFlowCategoryData['revenue_money'];
      } else {
        cashFlowFiltered = cashFlowCategoryData['loan_money'];
      }
    }
    for(var e in cashFlowFiltered){
      if(e['parent_category']['_id'] == idCashFlowCate){
        currentCashFlowCate['icon'] = e['parent_category']['icon'];
        currentCashFlowCate['name']= e['parent_category']['name'];
      }else{
        if(e['sub_category']!= null){
          for(var f in e['sub_category']){
            if(f['_id'] == idCashFlowCate){
              currentCashFlowCate['icon'] = f['icon'];
              currentCashFlowCate['name']= f['name'];
            }
          }
        }
      }
    }

    // print(widget.dataToUpdate);

    // get accountWallet's name & accountWallet's icon of this dataToUpdate
    for(var e in allWalletUserData){
      if(widget.dataToUpdate['money_account_id'] == e['_id']){
        chosenAccountWallet['icon'] = e['money_type_information']['icon'];
        chosenAccountWallet['name'] = e['name'];
        break;
      }
    }
    initialMoney = widget.dataToUpdate['amount_of_money'][r'$numberDecimal'];


    //init all field
    moneyEditTextController.text = initialMoney;
    descriptEditTextController.text = widget.dataToUpdate['description'];
    idChosenAccountWallet = widget.dataToUpdate['money_account_id'];
    idCashFlowCate = widget.dataToUpdate['cash_flow_category_id'];
    idCostIncuredCategory = widget.dataToUpdate['cost_incurred_category_id'];
    costIncurredEditTextController.text = widget.dataToUpdate['cost_incurred'][r'$numberDecimal'];
    eventEditTextController.text = widget.dataToUpdate['trip_or_event'];
    if(widget.dataToUpdate['pay_for_who']!= ''){
      contactPerson = widget.dataToUpdate['pay_for_who'];
    }else if(widget.dataToUpdate['collect_from_who']!= ''){
      contactPerson = widget.dataToUpdate['collect_from_who'];
    }
    print(widget.dataToUpdate);

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
          leading: const BackToolbarButton(),
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
        padding: const EdgeInsets.only(right: 18),
        child: SvgPicture.asset('assets/svg/trash.svg', width: 22),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 15),
        child: GestureDetector(
          onTap: () async {
            Map<String, String> dataToSubmit = {
              // required field
              'cash_flow_category_id': idCashFlowCate,
              'amount_of_money': (double.parse(initialMoney) - double.parse(moneyEditTextController.text)).toString(),
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
            if(cashFlowType.toLowerCase().contains('chi tiền') ||
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
            if(cashFlowType.toLowerCase().contains('chi tiền')
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

            if(!cashFlowType.toLowerCase().contains('tiền')){
            dataToSubmit.remove('trip_or_event');
            }
            if(
            cashFlowType.toLowerCase().contains('chi tiền')||
            nameCashFlowCate.toLowerCase().contains('cho vay')
            ){
            dataToSubmit['pay_for_who'] = contactPerson;
            }
            if(
            cashFlowType.toLowerCase().contains('thu tiền')||
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
            ),

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
                  textColor: widget.dataToUpdate['cash_flow_type'] == 0? spendingMoneyColor: revenueMoneyColor,
                ),
                spaceColumn,
                // Phần điền thông tin cần thiết
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      // Phần chọn lý do dùng tiền
                      ChooseCashFlowCategory(
                        cashFlowType:  cashFlowType,
                        onSelectCashFlowCate: onSelectCashFlowCate,
                        currentOption: currentCashFlowCate,
                      ),
                      dividerI76,
                      //Person loan
                      Visibility(
                        visible: cashFlowType.toLowerCase().contains('vay'),
                        child: PickContactListTile(
                          moneyType: cashFlowType,
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

                            Map<String, dynamic> result =await CustomNavigationHelper.router.push(
                             '${CustomNavigationHelper.addingWorkspacePath}/${CustomNavigationHelper.chooseAccountWalletPath}'
                            ) as Map<String, dynamic>;
                            if(!context.mounted){return ;}
                            if(result.isNotEmpty){
                              setState(() {
                                chosenAccountWallet = result;
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
                ExpandInputUpdateAddingSpace(
                  moneyType: cashFlowType,
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
                  idCostIncuredCategory: idCostIncuredCategory,
                  contactPerson: contactPerson,

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
   required this.onSelectCashFlowCate,
  required this.currentOption

   });

  final String cashFlowType;
  final Function? onSelectCashFlowCate;
  final Map<String, dynamic> currentOption;
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
  void initState() {
    currentOption = widget.currentOption;
    super.initState();
  }
  @override
  void didUpdateWidget(covariant ChooseCashFlowCategory oldWidget) {

    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: Image.asset(
        currentOption['icon'] == ''?'assets/another_icon/question-mark.png': currentOption['icon'] , width: 40, height: 40,
      ),
      title: Text(currentOption['name'] ==''? 'Chọn hạng mục': currentOption['name'], style: textStyle),
      trailing: keyBoardArrowRightIcon,
      contentPadding: const EdgeInsets.only(left:  16, top: 8, bottom: 8, right: 8),
      onTap: ()async{
        final result = await CustomNavigationHelper.router.pushNamed(
          'selectCategory', extra: widget.cashFlowType
        );
        if(!context.mounted) return;
        setState(() {
          currentOption = result as  Map<String , dynamic>;
        });
        widget.onSelectCashFlowCate!(currentOption['_id'], currentOption['name']);
      },
    );
  }
}

