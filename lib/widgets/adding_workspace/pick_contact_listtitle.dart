
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../constant/icon_key_board_arrow_right.dart';
class PickContactListTile extends StatefulWidget {
  const PickContactListTile({
    super.key,
    required this.nameCashFlowCate,
    this.onSelectContact,
    this.onResetChosenContact,
    required this.moneyType,
    this.horizontalTitleGap = 9
  });
  final String nameCashFlowCate;
  final String moneyType;
  final Function? onSelectContact;
  final Function? onResetChosenContact;
  final double horizontalTitleGap;
  @override
  State<PickContactListTile> createState() => PickContactListTileState();
}

class PickContactListTileState extends State<PickContactListTile> {
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  String? _contact = '';

  String customTitle = 'Chọn liên lạc';

  @override
  Widget build(BuildContext context) {
    if(widget.nameCashFlowCate.toLowerCase().contains('cho vay')){
      customTitle = 'Cho ai vay';
    }else if(widget.nameCashFlowCate.toLowerCase().contains('trả nợ')){
      customTitle = 'Trả cho ai';
    }else if(widget.nameCashFlowCate.toLowerCase().contains('thu nợ')){
      customTitle = 'Thu từ ai';
    }else if(widget.nameCashFlowCate.toLowerCase().contains('đi vay')){
      customTitle = 'Vay từ ai';
    }
    if(widget.moneyType.toLowerCase().contains('chi tiền')){
      customTitle = 'Chi cho ai';
    }else if(widget.moneyType.toLowerCase().contains('thu tiền')){
      customTitle = 'Thu từ ai';
    }
    return Container(
      padding: const EdgeInsets.only(right: 8,left: 16),
      child: ListTile(
        leading: Container(
          margin: const EdgeInsets.only(right: 13),
          child: SvgPicture.asset(
            'assets/svg/person.svg', width: 32, height: 32,
            colorFilter: ColorFilter.mode(Colors.grey[400]!, BlendMode.srcIn),
          ),
        ),
        title: Transform.translate(
            offset:  Offset(_contact == '' ? -8: -61, 0),
            child: Builder(builder: (context){
              if(_contact != ''){
                return Chip(
                  onDeleted: () {
                    widget.onResetChosenContact!();
                    setState(() {
                      _contact = '';
                    });
                  },
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
                  label: Text(_contact!, style: defaultTextStyle),

                );
              }
              return Text(customTitle, style: const TextStyle(
                color: labelColor, fontSize: textSize
              ));

            })
        ),
        trailing: keyBoardArrowRightIcon,
        horizontalTitleGap: widget.horizontalTitleGap,
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
            }else {
              _contact = contact.fullName;
              widget.onSelectContact!(contact.fullName);
            }
          });
        },
      ),
    );
  }
}
