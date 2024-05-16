import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/widgets/adding_workspace/pick_contact_listtitle.dart';
import 'package:practise_ui/widgets/input_money_textfield.dart';
import 'package:practise_ui/widgets/listtitle_textfield.dart';

import '../../pages/adding_workspace/adding_workspace.dart';
class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({
    Key? key,
    required this.moneyType,
    required this.eventEditTextController,
    this.onSelectContact,
    this.onResetChosenContact,
    this.onSetIsBorrowToPay,
    this.onSelectCostIncuredCategory,
    this.onSetIsIncludeInReport,
    required this.costIncuredEditTextController,
    required this.nameCashFlowCate
  }) : super(key: key);
  final String moneyType;
  final String nameCashFlowCate;
  final TextEditingController eventEditTextController;
  final TextEditingController costIncuredEditTextController;
  final Function? onSelectContact;
  final Function? onResetChosenContact;
  final Function? onSetIsBorrowToPay;
  final Function? onSelectCostIncuredCategory;
  final Function? onSetIsIncludeInReport;
  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu>  {

  late bool isShow;
  bool isBorrowToPay = false;
  bool isFee = false;
  bool isNotReport = false;
  @override
  void initState() {
    isShow = false;
    super.initState();
  }
  @override
  void dispose() {
    widget.eventEditTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: isShow,
          child: AnimatedContainer(
            color: backgroundColor,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            // height: isShow ? 530 : 0, // Adjust height as needed
            child: Column(
              children: [
                Container(
                  color: secondaryColor,
                  child: Column(
                    children: [
                      Visibility(
                        visible: widget.moneyType.toLowerCase().contains('tiền'),
                        child: Column(
                          children: [
                            ListTitleTextField(
                              controller: widget.eventEditTextController,
                              leading: SvgPicture.asset(
                                'assets/svg/travel-bus.svg',
                                colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
                                width: 29,
                              ),
                              hintText: 'Chuyến đi/Sự kiện',
                              paddingLeftLeading: 18,
                              horizontalTitleGap: 14,
                            ),
                            const Divider(height: 1, color: underLineColor,indent: 62),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: widget.moneyType.toLowerCase().contains('tiền'),
                        child: Column(
                          children: [
                            PickContactListTile(
                              nameCashFlowCate: widget.nameCashFlowCate,
                              moneyType: widget.moneyType,
                              onSelectContact: widget.onSelectContact,
                              onResetChosenContact: widget.onResetChosenContact
                            ),
                            const Divider(height: 1, color: underLineColor,indent: 64),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                spaceColumn,
                Container(
                  color: secondaryColor,
                  child: ListTile(
                    title: const Text(
                      'Đi vay để trả khoảng này',
                      style: defaultTextStyle,
                    ),
                    trailing: Switch(
                      value: isBorrowToPay,
                      activeColor: switchColorButton,
                      trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
                      thumbColor: const MaterialStatePropertyAll<Color>(secondaryColor),
                      onChanged: (bool value) {
                      widget.onSetIsBorrowToPay!(value == true ? 1: 0);

                      setState(() {
                          isBorrowToPay = value;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.only(left: 16, top: 0, bottom: 0, right: 12),
                  ),
                ),
                spaceColumn,
                spaceColumn,
                Container(
                  color: secondaryColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:<Widget> [
                      Visibility(
                        visible: widget.moneyType.toLowerCase().contains('chi tiền')
                        || widget.nameCashFlowCate.toLowerCase().contains('cho vay'),

                        child: ListTile(
                          title: const Text('Phí', style: defaultTextStyle),
                          trailing: Switch(
                            value: isFee,
                            activeColor: switchColorButton,
                            trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
                            thumbColor: const MaterialStatePropertyAll<Color>(secondaryColor),
                            onChanged: (bool value) {
                              setState(() {
                                isFee = value;
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.only(left: 16, top: 0, bottom: 0, right: 12),
                        ),

                      ),
                      Visibility(
                        visible:
                            (isFee && widget.moneyType.toLowerCase().contains('chi tiền')) ||
                            (isFee && widget.nameCashFlowCate.toLowerCase().contains('cho vay')),
                        maintainInteractivity: false,
                        maintainState: true,
                        maintainSize: false,
                        child: Column(
                          children: [
                            const Divider(height: 1, color: underLineColor, indent: 65),
                            Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: InputMoneyTextField(
                                title: 'Số tiền',
                                controller: widget.costIncuredEditTextController,
                                textColor: spendingMoneyColor,
                              ),
                            ),
                            ChooseCashFlowCategory(
                              cashFlowType: 'chi tiền ',
                              onSelectCashFlowCate: widget.onSelectCostIncuredCategory,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                spaceColumn,
                spaceColumn,
                Container(
                  color: secondaryColor,
                  child: ListTile(
                    title: const  Text(
                      'Không tính vào báo cáo',
                      style: defaultTextStyle,
                    ),
                    subtitle: const Text(
                      'Ghi chép này sẽ không được thống kê vào TẤT CẢ các '
                          'báo cáo(trừ báo cáo Tài chính hiện tại)'
                    ),
                    subtitleTextStyle: const TextStyle(color: labelColor),
                    trailing: Switch(
                      value: isNotReport,
                      activeColor: switchColorButton,
                      trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),

                      thumbColor: const MaterialStatePropertyAll<Color>(secondaryColor),
                      onChanged: (bool value) {
                        widget.onSetIsIncludeInReport!(value == true? 1: 0);
                        setState(() {
                          isNotReport = value;
                        });

                      },
                    ),
                    contentPadding: const EdgeInsets.only(left: 16, top: 0, bottom: 0, right: 12),

                  ),
                ),
                spaceColumn,
                spaceColumn,
                Container(
                  color: secondaryColor,
                  height: 80,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(Icons.image, size: 45,),
                          color: iconColor,
                          onPressed: () {  },
                        ),
                      ),

                      Container(
                        height: double.infinity,
                        width: 1,
                        margin: const  EdgeInsets.symmetric(vertical: 5),
                        color: underLineColor,
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, size: 45,),
                          color: iconColor,
                          onPressed: () {  },
                        ),
                      ),

                    ],
                  ),
                ),
                const Divider(
                  height: 1, color: underLineColor,
                )
              ],
            ),
          ),
        ),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              ),
              backgroundColor: secondaryColor,
              elevation: 0,

            ),
            onPressed: () {
              setState(() {
                isShow = !isShow;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                isShow ? 'Ẩn chi tiết ' : 'Thêm chi tiết',
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: textSize,
                ),
              ),
            ),
          ),
        ),
        spaceColumn
      ],
    );
  }
}