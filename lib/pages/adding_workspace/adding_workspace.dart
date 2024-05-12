
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/divider.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/models/cashs_flow_model.dart';
import 'package:practise_ui/providers/app_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/widgets/adding_workspace/dropdown_adding_workspace.dart';
import 'package:provider/provider.dart';
import '../../widgets/adding_workspace/expand_input_adding_space.dart';
import '../../widgets/input_money_textfield.dart';
import '../../widgets/listtitle_textfield.dart';
import '../account_wallet/add_account_wallet_page.dart';

class AddingWorkspace extends StatefulWidget {
  const AddingWorkspace({super.key});

  @override
  State<AddingWorkspace> createState() => _AddingWorkspaceState();
}

class _AddingWorkspaceState extends State<AddingWorkspace> {

  late CashFlowModel currentCashFlowOption;
  late String moneyType ;
  List<CashFlowModel> cashFlowData = [];

  final TextEditingController moneyEditTextController = TextEditingController();
  final TextEditingController descriptEditTextController = TextEditingController();


  // all value;
  late String _money;
  late String idCashFlowCate = '';

  void onSelectCashFlowCate(String value){
    setState(() {
      idCashFlowCate = value;
    });
  }


  void onSelectedDropdownItem(CashFlowModel selectedItem){
    setState(() {
      currentCashFlowOption  = selectedItem;
      moneyType = selectedItem.name;
    });
    // print(moneyType);
  }
  String _selectedDate= '';
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
    //
    // print('cashFlowData');
    // print(cashFlowCateData);

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
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Enable'),
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
                InputMoneyTextField(controller: moneyEditTextController, title: 'Số tiền',),
                spaceColumn,
                // Phần điền thông tin cần thiết
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      // Phần chọn lý do dùng tiền
                      _categorySection(
                        cashFlowType:  moneyType,
                        onSelectCashFlowCate: onSelectCashFlowCate,
                      ),
                      dividerI76,
                      _borrowerOrLenderSection(),
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
                            child: Text(
                                _selectedDate,
                                style: const TextStyle(
                                    fontSize: textSize,
                                    color: textColor
                                )
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: iconColor,
                            size: 33,
                          ),
                          contentPadding: const EdgeInsets.only(left: 2, top: 8, bottom: 8, right: 0),
                          onTap: (){
                                _selectDate(context);
                          },
                        ),
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
                            child: Text(
                                'Ví',
                                style: TextStyle(
                                    fontSize: textSize,
                                    color: textColor
                                )
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: iconColor,
                            size: 33,
                          ),
                          contentPadding: const EdgeInsets.only(left: 2, top: 8, bottom: 8, right: 0),
                          onTap: (){},
                        ),
                      ),
                    ],
                  ),
                ),
                // Phần thông tin chi tiết(optional)
                spaceColumn,
                //Expanded detailed option
                CustomDropdownMenu(),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

class _borrowerOrLenderSection extends StatefulWidget {
  const _borrowerOrLenderSection();

  @override
  State<_borrowerOrLenderSection> createState() => _borrowerOrLenderSectionState();
}

class _borrowerOrLenderSectionState extends State<_borrowerOrLenderSection> {
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  String? _contact = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingR8L21,
      child: ListTile(
        leading: Container(
          margin: const EdgeInsets.only(right: 13),
          child: SvgPicture.asset(
            'assets/svg/person.svg',
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(Colors.grey[400]!, BlendMode.srcIn),
          ),
        ),
        title: Transform.translate(
          offset:  Offset(_contact == '' ? -8: -61, 0),
          child: Builder(builder: (context){
            if(_contact != ''){
              return Chip(
                deleteIcon:  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.grey.shade400,
                    child: const Icon(Icons.close, size: 15, color: secondaryColor,)
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide.none),
                side: BorderSide.none,
                label: Text(_contact!, style: const TextStyle(color: textColor, fontSize: textSize),),
                onDeleted: () {
                  setState(() {
                    _contact = '';
                  });
                },
              );
            }
            return const Text(
                'Chọn người vay',
                style: TextStyle( fontSize: textSize, color: textColor)
            );

          })
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right,
          color: iconColor,
          size: 33,
        ),
        contentPadding: const EdgeInsets.only(left: 0, top: 8, bottom: 8, right: 0),
        onTap: ()async{
          Contact? contact = await _contactPicker.selectContact();
          setState(() {
            if(contact == null){
              if(_contact != null){
                return;
              }else {
                _contact = '';
              }
            }else {_contact = contact.fullName;}
          });
        },
      ),
    );
  }
}


class _categorySection extends StatefulWidget {
   _categorySection({required this.cashFlowType, required this.onSelectCashFlowCate});

  final String cashFlowType;
  final Function onSelectCashFlowCate;
  @override
  State<_categorySection> createState() => _categorySectionState();
}

class _categorySectionState extends State<_categorySection> {
  late Map<String, dynamic> currentOption = {'icon' :'', 'name':'', 'id': '', 'cash_flow_id': ''};
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
      trailing: const Icon(
        Icons.keyboard_arrow_right,
        color: iconColor,
        size: 33,
      ),
      contentPadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
      onTap: ()async{
        final result = await CustomNavigationHelper.router.pushNamed(
          'selectCategory', extra: widget.cashFlowType
        );
        if(!context.mounted) return;
        setState(() {
          currentOption = result as  Map<String , dynamic>;

        });
        widget.onSelectCashFlowCate(currentOption['_id']);
      },
    );
  }
}

