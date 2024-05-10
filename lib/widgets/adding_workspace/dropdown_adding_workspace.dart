import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/models/cashs_flow_model.dart';
// import 'package:practise_ui/data/dropdown_adding_data.dart';
class DropDownAddingWorkspace extends StatefulWidget {
  const DropDownAddingWorkspace({super.key, required this.addingDropdownDataApi, required this.selectedItem, required this.currentOption});
  final List<CashFlowModel> addingDropdownDataApi;
  final Function? selectedItem;
  final CashFlowModel currentOption;

  @override
  State<DropDownAddingWorkspace> createState() => _DropDownAddingWorkspaceState();
}

class _DropDownAddingWorkspaceState extends State<DropDownAddingWorkspace> {
  String? selectedValue;
  @override
  void initState() {
    selectedValue = widget.currentOption.name;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Container(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.addingDropdownDataApi[0].name,
                    style: const TextStyle(
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
          items: widget.addingDropdownDataApi.map((CashFlowModel item) => DropdownMenuItem<String>(
            value: item.name,
            //custom dropdown item
            child: _DropdownMenuItem(
              text: item.name,
              icon: item.iconPath,
              isChosen: item.isChosen == 0 ? false : true,
            )
          )).toList(),

          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            for(var item in widget.addingDropdownDataApi){
              if(item.name == value){
                item.isChosen = 1;
                widget.selectedItem!(item);
              }else {
                item.isChosen = 0;
              }
              CashFlowModel.saveCashFlow(widget.addingDropdownDataApi);
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
    this.isChosen = false
  });
  final String icon;
  final String text;
  final bool isChosen;
  @override
  State<_DropdownMenuItem> createState() => _DropdownMenuItemState();
}

class _DropdownMenuItemState extends State<_DropdownMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Image.network(
            widget.icon,
            width: 35,
            height: 35,
          ),
            title: Text(
              widget.text,
              style: const TextStyle(color: textColor, fontSize: textSize),
            ),
            trailing:  SvgPicture.asset(
              'assets/tick.svg',
              colorFilter: widget.isChosen ?
              const ColorFilter.mode(primaryColor, BlendMode.srcIn):
              const ColorFilter.mode(Colors.transparent, BlendMode.srcIn),
              width: 39,
            ),
        ),
        const Divider(height: 1, color: underLineColor),
      ],
    );
  }
}

