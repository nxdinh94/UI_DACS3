
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
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/widgets/adding_workspace/dropdown_adding_workspace.dart';
import 'package:practise_ui/widgets/adding_workspace/pick_contact_listtitle.dart';
import 'package:provider/provider.dart';
import '../../widgets/adding_workspace/expand_input_adding_space.dart';
import '../../widgets/input_money_textfield.dart';
import '../../widgets/listtitle_textfield.dart';

class AddingWorkspace extends StatefulWidget {
  const AddingWorkspace({super.key});

  @override
  State<AddingWorkspace> createState() => _AddingWorkspaceState();
}

class _AddingWorkspaceState extends State<AddingWorkspace> {

  late CashFlowModel currentCashFlowOption;
  late String moneyType;// 3 options of dropdown
  List<CashFlowModel> cashFlowData = [];
  Map<String, dynamic> chosenAccountWallet = {};
  late String nameCashFlowCate = '';

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
  late int isIncludeInReport  = 0;

  void onSetIsIncludeInReport(int value){
    setState(() {
      isIncludeInReport = value;
    });
  }
  void onSelectCostIncuredCategory(String value, String fakeValue){
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
    setState(() {
      idCashFlowCate = id;
      nameCashFlowCate = name;
    });
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
        String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
        _selectedDate = formattedDate;
      });
    }
  }
  @override
  void initState() {
    cashFlowData = context.read<AppProvider>().cashFlowData;
    currentCashFlowOption = cashFlowData[0];
    for(var item in cashFlowData){
      if(item.isChosen == 1 ){
        currentCashFlowOption = item;
        break;
      }
    }
    moneyType = currentCashFlowOption.name;
    _selectedDate = DateFormat('dd/MM/yyyy').format(currentDate);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              'assets/svg/history.svg',
              fit: BoxFit.fitWidth,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          title: Padding(
            padding: paddingNone,
            child: cashFlowData.isEmpty
                ? const Text('None')
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
                onTap: () {
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text('Basic dialog title'),
                      content: Column(
                        children: [
                          Text('idCashFlowCate: $idCashFlowCate'),
                          Text('soTien: ${moneyEditTextController.text}'),
                          Text('description: ${descriptEditTextController.text}'),
                          Text('idAccountWallet: $idChosenAccountWallet'),
                          Text('selectedDate: $_selectedDate'),
                          Text('nameLoanPerson: $contactPerson'),
                          Text('IsBorrowToPay: $isBorrowToPay'),
                          Text('costIncured: ${costIncurredEditTextController.text}'),
                          Text('idCostIncuredCategory: $idCostIncuredCategory'),
                          Text('isIncludeInReport: $isIncludeInReport'),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Disable'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
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
                        controller: descriptEditTextController
                      ),
                      dividerI76,

                      Container(
                        padding: paddingR8L24,
                        child: ListTile(
                          leading: Container(
                            margin: const EdgeInsets.only(right: 13),
                            child: SvgPicture.asset(
                              'assets/svg/calendar.svg',
                              width: 26,
                              height: 26,
                              colorFilter: ColorFilter.mode(Colors.grey[400]!, BlendMode.srcIn),
                            ),
                          ),
                          title: Transform.translate(
                            offset: const Offset(-8, 0),
                            child: Text(_selectedDate, style: defaultTextStyle),
                          ),
                          trailing: keyBoardArrowRightIcon,
                          contentPadding: const EdgeInsets.only(left: 2, top: 8, bottom: 8, right: 0),
                          onTap: (){
                              _selectDate(context);
                          },
                        ),
                      ),
                      dividerI76,

                      Container(
                        padding: const EdgeInsets.only(right: 9, left: 18),
                        child: ListTile(
                          leading: Container(
                            margin: const EdgeInsets.only(right: 13),
                            child: Image.asset(
                              chosenAccountWallet['icon']??
                              'assets/another_icon/wallet-2.png',
                              width: 40, height: 40,
                            ),
                          ),
                          horizontalTitleGap: 11,
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
                CustomDropdownMenu(
                  moneyType: moneyType,
                  nameCashFlowCate: nameCashFlowCate,
                  onSelectContact: onSelectContact,
                  onResetChosenContact: onResetChosenContact,
                  eventEditTextController: eventEditTextController,
                  onSetIsBorrowToPay: onSetIsBorrowToPay,
                  costIncuredEditTextController: costIncurredEditTextController,
                  onSelectCostIncuredCategory:onSelectCostIncuredCategory,
                  onSetIsIncludeInReport:onSetIsIncludeInReport
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
        setState(() {
          currentOption = result as  Map<String , dynamic>;
        });
        widget.onSelectCashFlowCate!(currentOption['_id'], currentOption['name']);
      },
    );
  }
}

