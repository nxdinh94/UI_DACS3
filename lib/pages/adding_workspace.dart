import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/divider.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/data/dropdown_adding_data.dart';
import 'package:practise_ui/widgets/adding_workspace/dropdown_adding_workspace.dart';

import '../widgets/adding_workspace/expand_input_adding_space.dart';

class AddingWorkspace extends StatefulWidget {
  const AddingWorkspace({super.key});

  @override
  State<AddingWorkspace> createState() => _AddingWorkspaceState();
}

class _AddingWorkspaceState extends State<AddingWorkspace> {

  late Map<String, dynamic> currentOption= addingDropdownData[0];
  late String moneyType ;


  void selectedDropdownItem(String selectedItem){
    for(var item in addingDropdownData){
      if(item['text'] == selectedItem){
        setState(() {
          currentOption  = item;
        });
        return;
      }
    }
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
    moneyType =currentOption['type'];
    _selectedDate = DateFormat('dd/MM/yyyy').format(currentDate);
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
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              'assets/history.svg',
              fit: BoxFit.fitWidth,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          title: Padding(
            padding: paddingNone,
            child: DropDownAddingWorkspace(
                  addingDropdownData: addingDropdownData,
                selectedItem: selectedDropdownItem,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  // Your action when the icon is tapped
                },
                child: SvgPicture.asset(
                  'assets/tick.svg',
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
          child: ListView(
            children: [
              spaceColumn,
              //Phần điền số tiền
              _inputMoneySection(),
              spaceColumn,
              // Phần điền thông tin cần thiết
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Phần chọn lý do dùng tiền
                    _categorySection(currentOption: currentOption),
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
                            'assets/calendar.svg',
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
                            'assets/calendar.svg',
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

    );
  }
}

class _decribeSection extends StatelessWidget {
  const _decribeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingR16L24,
      child: TextField(
        style: const TextStyle(
          color: textColor,
          fontSize: textSize,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 20),
          border: InputBorder.none,
          hintText: 'Diễn giải',
          hintStyle: TextStyle(
            color: labelColor
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              'assets/text-align-left.svg',
              width: 30,
              height: 30,
              colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),

            ),
          ),

          prefixIconConstraints: BoxConstraints(
            maxWidth: 50,
            maxHeight: 50
          ),
          suffixIcon: SvgPicture.asset(
            'assets/delete.svg',
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          suffixIconConstraints: BoxConstraints(
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

class _borrowerOrLenderSection extends StatelessWidget {
  const _borrowerOrLenderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingR8L21,
      child: ListTile(
        leading: Container(
          margin: const EdgeInsets.only(right: 13),
          child: SvgPicture.asset(
            'assets/person.svg',
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(Colors.grey[400]!, BlendMode.srcIn),
          ),
        ),
        title: Transform.translate(
          offset: const Offset(-8, 0),
          child: Text(
              'Người cho vay',
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
        contentPadding: const EdgeInsets.only(left: 0, top: 8, bottom: 8, right: 0),
        onTap: (){},
      ),
    );
  }
}

class _inputMoneySection extends StatelessWidget {
  const _inputMoneySection({
    super.key,
  });

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
            // controller: _moneyInputController,
            style: const TextStyle(fontSize: 35.0, height: 45/35,fontWeight: FontWeight.w500, color: revenueMoneyColor),
            textAlign: TextAlign.end,
            cursorColor: Colors.deepPurpleAccent,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,

                suffixIcon: SvgPicture.asset(
                  'assets/dong.svg',
                  colorFilter: const  ColorFilter.mode(textColor, BlendMode.srcIn),
                ),
                suffixIconConstraints: const BoxConstraints(
                    minHeight: 32,
                    minWidth: 32
                ),
                hintText: '0',
                hintStyle: const TextStyle(fontSize: 35, color: primaryColor)
            ),

          ),
          spaceColumn6,
          divider
        ],
      ),
    );
  }
}

class _categorySection extends StatelessWidget {
  const _categorySection({
    required this.currentOption,
  });

  final Map<String, dynamic> currentOption;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(6),
          color: currentOption['backgroundColor'],
          child: SvgPicture.asset(
            currentOption['icon'],
            width: 30,
            height: 30,

          ),
        ),
      ),
      title: Text(currentOption['text'],
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: textColor
        )
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
        color: iconColor,
        size: 33,
      ),
      contentPadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
      onTap: (){},
    );
  }
}

