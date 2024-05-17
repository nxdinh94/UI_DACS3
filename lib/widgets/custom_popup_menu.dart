import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/utils/custom_toast.dart';
import 'package:provider/provider.dart';
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
      onSelected: (value)async {
        if (value == "edit") {
          CustomNavigationHelper.router.push(
            '${CustomNavigationHelper.accountWalletPath}/${CustomNavigationHelper.updateAccountWalletPath}',
            extra: widget.selectedItemData
          );
        }else if(value == "delete"){
          Map<String, dynamic> result = await Provider.of<UserProvider>(context, listen: false).deleteAccountWall(widget.selectedItemData['_id']);
          if(result['result']['deletedCount'] == 1){
            showCustomSuccessToast(context, result['result']['msg'], duration: 2);
            await Provider.of<UserProvider>(context, listen: false).getAllAccountWallet();
          }else {
            showCustomErrorToast(context, result['result']['msg'], 1);
          }
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
