import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/data/dropdown_adding_data.dart';
import 'package:practise_ui/widgets/adding_workspace/dropdown_adding_workspace.dart';

class AddingWorkspace extends StatefulWidget {
  const AddingWorkspace({super.key});

  @override
  State<AddingWorkspace> createState() => _AddingWorkspaceState();
}

class _AddingWorkspaceState extends State<AddingWorkspace> {
  final sidePadding = const EdgeInsets.all(0);
  late Map<String, dynamic> currentOption= addingDropdownData[0];
  late String moneyType ;

  DateTime selectedDate = DateTime.now();
  final TextEditingController _date =  TextEditingController();
  String _dob= '';
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
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
        _date.value = TextEditingValue(text: formattedDate);
        _dob = formattedDate;
      });
    }
  }
  @override
  void initState() {
    moneyType =currentOption['type'];
    _dob = DateFormat('dd/MM/yyyy').format(selectedDate);
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
            padding: sidePadding,
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
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text('Số tiền', style: TextStyle(
                        fontSize: textSize,
                        color: revenueMoneyColor,
                        height: 0.9,
                      )),
                    ),
                    TextField(

                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        border: InputBorder.none,

                        hintText: '0',
                        hintStyle: const TextStyle(
                          color: labelColor,
                        ),

                        suffixIcon: SizedBox(
                          height: 10,
                          width: 10,
                          child: SvgPicture.asset(
                            'assets/dong.svg',
                            height: 10,
                            width: 10,
                            colorFilter: const ColorFilter.mode(textColor, BlendMode.srcIn),
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 30,
                          minHeight: 30,
                        ),
                        suffixIconColor: textColor,

                      ),
                      textAlign: TextAlign.end,
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: revenueMoneyColor
                      ),
                    ),
                    const Divider(height: 1, color: underLineColor,)
                  ],
                ),
              ),
              spaceColumn,
              // Phần điền thông tin cần thiết
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Phần chọn lý do dùng tiền
                    ListTile(
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
                      title: Transform.translate(
                        offset: const Offset(-8, 0),
                        child: Text(currentOption['text'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: textColor
                          )
                        ),
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: labelColor,
                        size: 33,
                      ),
                      contentPadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
                      onTap: (){},
                    ),
                    const Divider(height: 1, color: underLineColor,indent: 66),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        style: TextStyle(
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
                            ),
                          ),

                          prefixIconConstraints: BoxConstraints(
                            maxWidth: 50,
                            maxHeight: 50
                          ),
                          suffixIcon: SvgPicture.asset(
                            'assets/delete.svg',
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
                    ),
                    const Divider(height: 1, color: underLineColor,indent: 66),

                    ListTile(
                      leading: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.only(left: 2),
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
                            _dob,
                            style: const TextStyle(
                                fontSize: textSize,
                                color: textColor
                            )
                        ),
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: labelColor,
                        size: 33,
                      ),
                      contentPadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
                      onTap: (){
                            _selectDate(context);
                      },
                    ),
                    const Divider(height: 1, color: underLineColor,indent: 66),

                    ListTile(
                      leading: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.only(left: 2),
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
                            style: const TextStyle(
                                fontSize: textSize,
                                color: textColor
                            )
                        ),
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: labelColor,
                        size: 33,
                      ),
                      contentPadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
                      onTap: (){

                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}

