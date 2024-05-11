import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/divider.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/data/dropdown_adding_data.dart';
import 'package:practise_ui/models/cashs_flow_model.dart';
import 'package:practise_ui/providers/app_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/widgets/adding_workspace/dropdown_adding_workspace.dart';
import 'package:provider/provider.dart';
import '../../widgets/adding_workspace/expand_input_adding_space.dart';

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


  // all value;
  late  String _money;

  void selectedDropdownItem(CashFlowModel selectedItem){
    setState(() {
      currentCashFlowOption  = selectedItem;
      moneyType = selectedItem.name;
    });
    print(moneyType);
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
    // print(cashFlowData);

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
    moneyEditTextController.dispose();
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
                    selectedItem: selectedDropdownItem,
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
                      content: Text(
                        'sotien ${moneyEditTextController.text}'
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
                _inputMoneySection(controller: moneyEditTextController,),
                spaceColumn,
                // Phần điền thông tin cần thiết
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      // Phần chọn lý do dùng tiền
                      _categorySection(cashFlowType:  currentCashFlowOption.name,),
                      dividerI76,
                      _borrowerOrLenderSection(),
                      dividerI76,
                      _decribeSection(),
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

class _decribeSection extends StatefulWidget {
  const _decribeSection({
    super.key,
  });

  @override
  State<_decribeSection> createState() => _decribeSectionState();
}

class _decribeSectionState extends State<_decribeSection> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingR16L24,
      child: TextField(
        controller: _controller,
        style: const TextStyle(
          color: textColor,
          fontSize: textSize,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          border: InputBorder.none,
          hintText: 'Diễn giải',
          hintStyle:const TextStyle(
            color: labelColor
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              'assets/svg/text-align-left.svg',
              width: 30,
              height: 30,
              colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),

            ),
          ),

          prefixIconConstraints:const  BoxConstraints(
            maxWidth: 50,
            maxHeight: 50
          ),
          suffixIcon: GestureDetector(
            onTap: _controller.clear,
            child: SvgPicture.asset(
              'assets/svg/delete.svg',
              colorFilter:const  ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
          suffixIconConstraints: const BoxConstraints(
            minHeight: 15,
            minWidth: 15,
            maxHeight: 18,
            maxWidth: 18
          ),
          // suffixIconColor: Colors.grey,
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

class _inputMoneySection extends StatefulWidget {

   _inputMoneySection({required this.controller});
   final TextEditingController controller;
  @override
  State<_inputMoneySection> createState() => _inputMoneySectionState();
}

class _inputMoneySectionState extends State<_inputMoneySection> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    const Divider divider = Divider(height: 1, color: underLineColor,indent: 64);
    return Container(
      height: 110,
      color: secondaryColor,
      padding: paddingAll12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('Số tiền', style: TextStyle(
              fontSize: textSmall,
              color: textColor
          )),
          spaceColumn6,
          TextField(
            controller: widget.controller,
            style: const TextStyle(fontSize: 35.0, height: 45/35,fontWeight: FontWeight.w500, color: revenueMoneyColor),
            textAlign: TextAlign.end,
            cursorColor: Colors.deepPurpleAccent,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                suffixIcon: SvgPicture.asset(
                  'assets/svg/dong.svg',
                  colorFilter: const  ColorFilter.mode(textColor, BlendMode.srcIn),
                ),
                suffixIconConstraints: const BoxConstraints(
                    minHeight: 32,
                    minWidth: 32
                ),
                hintText: '0',
                hintStyle: const TextStyle(fontSize: 35, color: revenueMoneyColor)
            ),
          ),
          spaceColumn6,
          divider
        ],
      ),
    );
  }
}

class _categorySection extends StatefulWidget {
   _categorySection({required this.cashFlowType});

  final String cashFlowType;

  @override
  State<_categorySection> createState() => _categorySectionState();
}

class _categorySectionState extends State<_categorySection> {
  late Map<String, dynamic> currentOption = {'iconPath' :'', 'title':''};
  final TextStyle textStyle = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: textColor
  );
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:currentOption['iconPath'] !='' ?  Image.asset(
        currentOption['iconPath'], width: 40, height: 40,
      ) : Image.asset('assets/another_icon/question-mark.png', width: 45, height: 45,),
      title: currentOption['title'] != '' ?  Text(currentOption['title'], style: textStyle):Text('Chọn hạng mục', style: textStyle,),

      trailing: const Icon(
        Icons.keyboard_arrow_right,
        color: iconColor,
        size: 33,
      ),
      contentPadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
      onTap: ()async{
        final result = await CustomNavigationHelper.router.pushNamed(
          'selectCategory',
          pathParameters: {'type': widget.cashFlowType}
        );
        if(!context.mounted) return;

        setState(() {

          currentOption = result as  Map<String , dynamic>;
        });

      },
    );
  }
}

