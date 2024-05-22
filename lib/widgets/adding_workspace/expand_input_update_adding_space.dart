
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/pages/adding_workspace/update_workspace.dart';
import 'package:practise_ui/widgets/adding_workspace/pick_contact_listtitle.dart';
import 'package:practise_ui/widgets/input_money_textfield.dart';
import 'package:practise_ui/widgets/listtitle_textfield.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
class ExpandInputUpdateAddingSpace extends StatefulWidget {
  const ExpandInputUpdateAddingSpace({
    Key? key,
    required this.moneyType,
    required this.eventEditTextController,
    this.onSelectContact,
    this.onResetChosenContact,
    this.onSetIsBorrowToPay,
    this.onSelectCostIncuredCategory,
    this.onSetIsIncludeInReport,
    this.onSetIsFee,
    required this.costIncuredEditTextController,
    required this.nameCashFlowCate,
    required this.isFee,
    required this.idCostIncuredCategory, required this.contactPerson
  }) : super(key: key);
  final String moneyType;
  final bool isFee;
  final String nameCashFlowCate;
  final String contactPerson;
  final TextEditingController eventEditTextController;
  final TextEditingController costIncuredEditTextController;
  final String idCostIncuredCategory;
  final Function? onSelectContact;
  final Function? onResetChosenContact;
  final Function? onSetIsBorrowToPay;
  final Function? onSelectCostIncuredCategory;
  final Function? onSetIsIncludeInReport;
  final Function? onSetIsFee;
  @override
  State<ExpandInputUpdateAddingSpace> createState() => _ExpandInputUpdateAddingSpaceState();
}

class _ExpandInputUpdateAddingSpaceState extends State<ExpandInputUpdateAddingSpace>  {

  Map<String, dynamic> currentIncuredCashFlowCate = {'icon' :'', 'name':''};


  late bool isShow;
  bool isBorrowToPay = false;
  bool isNotReport = false;
  Map<String, dynamic> cashFlowCategoryData = {};
  List<dynamic> cashFlowFiltered = [];

  @override
  void initState() {
    isShow = false;
    print(widget.moneyType);


    cashFlowCategoryData = context.read<AppProvider>().cashFlowCateData;
    cashFlowFiltered = cashFlowCategoryData['spending_money'];
    for(var e in cashFlowFiltered){
      if(e['parent_category']['_id'] == widget.idCostIncuredCategory){
        currentIncuredCashFlowCate['icon'] = e['parent_category']['icon'];
        currentIncuredCashFlowCate['name']= e['parent_category']['name'];
      }else{
        if(e['sub_category']!= null){
          for(var f in e['sub_category']){
            if(f['_id'] == widget.idCostIncuredCategory){
              currentIncuredCashFlowCate['icon'] = f['icon'];
              currentIncuredCashFlowCate['name']= f['name'];
            }
          }
        }
      }
    }
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
                              onResetChosenContact: widget.onResetChosenContact,
                              contactPerson: widget.contactPerson
                            ),
                            const Divider(height: 1, color: underLineColor,indent: 64),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                spaceColumn,
                Visibility(
                  visible: widget.moneyType.toLowerCase().contains('chi tiền') ||
                          widget.nameCashFlowCate.toLowerCase().contains('cho vay')||
                          widget.nameCashFlowCate.toLowerCase().contains('trả nợ'),
                  child: Column(
                    children: [
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
                            trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
                            thumbColor: const WidgetStatePropertyAll<Color>(secondaryColor),
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
                    ],
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children:<Widget> [
                    Visibility(
                      visible: widget.moneyType.toLowerCase().contains('chi tiền')
                      || widget.nameCashFlowCate.toLowerCase().contains('cho vay')
                      || widget.nameCashFlowCate.toLowerCase().contains('trả nợ'),

                      child: Container(
                        color: secondaryColor,
                        child: ListTile(
                          title: const Text('Phí', style: defaultTextStyle),
                          trailing: Switch(
                            value: widget.isFee,
                            activeColor: switchColorButton,
                            trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
                            thumbColor: const WidgetStatePropertyAll<Color>(secondaryColor),
                            onChanged: (bool value) {
                              widget.onSetIsFee!(value);
                            },
                          ),
                          contentPadding: const EdgeInsets.only(left: 16, top: 0, bottom: 0, right: 12),
                        ),
                      ),

                    ),
                    Visibility(
                      visible:
                          (widget.isFee && widget.moneyType.toLowerCase().contains('chi tiền')) ||
                          (widget.isFee && widget.nameCashFlowCate.toLowerCase().contains('cho vay'))||
                          (widget.isFee && widget.nameCashFlowCate.toLowerCase().contains('trả nợ')),

                      maintainInteractivity: false,
                      maintainState: true,
                      maintainSize: false,
                      child: Container(
                        color: secondaryColor,
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
                              cashFlowType: 'chi tiền',
                              onSelectCashFlowCate: widget.onSelectCostIncuredCategory,
                              currentOption: currentIncuredCashFlowCate,
                            ),
                          ],
                        ),
                      ),
                    ),
                    spaceColumn,
                    spaceColumn,
                  ],
                ),

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
                      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),

                      thumbColor: const WidgetStatePropertyAll<Color>(secondaryColor),
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