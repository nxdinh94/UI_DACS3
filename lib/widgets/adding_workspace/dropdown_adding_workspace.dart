import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
// import 'package:practise_ui/data/dropdown_adding_data.dart';
class DropDownAddingWorkspace extends StatefulWidget {
  const DropDownAddingWorkspace({super.key, required this.addingDropdownData, required this.selectedItem});
  final List<Map<String, dynamic>> addingDropdownData;
  final Function? selectedItem;

  @override
  State<DropDownAddingWorkspace> createState() => _DropDownAddingWorkspaceState();
}

class _DropDownAddingWorkspaceState extends State<DropDownAddingWorkspace> {

  String? selectedValue ;

  @override
  void initState() {
    selectedValue = widget.addingDropdownData[0]['text'];

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Container(
            color: Colors.grey,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Tiêu tiền',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          items: widget.addingDropdownData.map((Map<String, dynamic> item) => DropdownMenuItem<String>(
            value: item['text'],
            //custom dropdown item
            child: _DropdownMenuItem(
              text: item['text'],
              icon: item['icon'],
              isChosen: item['isChosen'],
              backgroundColor: item['backgroundColor'],
            )
          )).toList(),

          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            widget.selectedItem!(value);
            for(var item in widget.addingDropdownData){
              if(item['text'] == value){
                item['isChosen'] = true;
              }else {
                item['isChosen'] = false;
              }
            }
          },
          // buttonStyleData: ButtonStyleData(
          //   height: 38,
          //   width: 160,
          //   // elevation:14,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(14),
          //     color: const Color(0x66A6E2F3),
          //   ),
          // ),

          customButton: Container(
            height: 38,
            width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0x66A6E2F3),
              // color: Colors.red,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedValue!,
                  style: const  TextStyle(
                    fontSize: buttonTextSize,
                    color: Colors.white
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 36,
                  color: Colors.white,
                )
              ],
            ),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 34,
            iconEnabledColor: Colors.white,
            iconDisabledColor: Colors.grey,

          ),
          dropdownStyleData: const DropdownStyleData(
            // maxHeight: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            offset: Offset(0, -7),
            // scrollbarTheme: ScrollbarThemeData(
            //   radius: const Radius.circular(40),
            //   thickness: MaterialStateProperty.all(6),
            //   thumbVisibility: MaterialStateProperty.all(true),
            // ),
            elevation: 0
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 65,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      );
  }
}
class _DropdownMenuItem extends StatefulWidget {
  const _DropdownMenuItem({
    // super.key,
    required this.icon,
    required this.text,
    this.backgroundColor = Colors.transparent,
    this.isChosen = false
  });
  final String icon;
  final String text;
  final Color backgroundColor;
  final bool isChosen;
  @override
  State<_DropdownMenuItem> createState() => _DropdownMenuItemState();
}

class _DropdownMenuItemState extends State<_DropdownMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(4),
                    color: widget.backgroundColor,
                    child: SvgPicture.asset(
                      widget.icon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Text(
                  widget.text,
                  style: const TextStyle(color: textColor, fontSize: textSize),
                ),
              ],
            ),
            Positioned(
              right: 10,
              bottom: 0,
              child: SvgPicture.asset(
                'assets/tick.svg',
                colorFilter: widget.isChosen ?
                const ColorFilter.mode(primaryColor, BlendMode.srcIn):
                const ColorFilter.mode(Colors.transparent, BlendMode.srcIn),
                width: 35,
              ),
            )
          ],
        ),
        const SizedBox(height: 12),
        const Divider(height: 1, color: underLineColor),
        const SizedBox(height: 12)
      ],
    );
  }
}

