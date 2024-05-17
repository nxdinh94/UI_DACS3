import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
class CustomPopupMenu extends StatefulWidget {
  const CustomPopupMenu({
    super.key,
    required this.representationIcon,
    required this.selectedItemData,
  });
  final Widget representationIcon;
  final Map<String, dynamic> selectedItemData;
  @override
  State<CustomPopupMenu> createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: secondaryColor,
      child: widget.representationIcon,
      onSelected: (value) {
        if (value == "edit") {
          CustomNavigationHelper.router.push(
            '${CustomNavigationHelper.accountWalletPath}/${CustomNavigationHelper.updateAccountWalletPath}',
            extra: widget.selectedItemData
          );
        }else if(value == "delete"){
          // add desired output
        }else if(value == "stop"){
          // add desired output
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          value: "edit",
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 5),
                child: SvgPicture.asset('assets/svg/pen-appbar.svg', width: 18, color: textColor,)),
              const Text('Chỉnh sửa', style: defaultTextStyle),
            ],
          ),
        ),
        const PopupMenuItem(
          value: "delete",
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.restore_from_trash_outlined)
              ),
              Text('Xóa tài khoản', style: defaultTextStyle),
            ],
          ),
        ),
        const PopupMenuItem(
          value: "stop",
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.lock)
              ),
              Text('Ngưng sử dụng', style: defaultTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}
