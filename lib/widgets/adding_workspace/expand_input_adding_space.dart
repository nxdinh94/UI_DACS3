import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({Key? key}) : super(key: key);

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
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/svg/travel-bus.svg',
                          colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
                          width: 29,
                        ),

                        title: const Text(
                          'Chuyến đi/Sự kiện',
                          style: TextStyle(
                              fontSize: textSize,
                              color: labelColor
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right,
                          color: iconColor,
                          size: 33,
                        ),
                        contentPadding: const EdgeInsets.only(left: 16, top: 0, bottom: 0, right: 8),
                        onTap: (){},
                      ),
                      const Divider(height: 1, color: underLineColor,indent: 64),
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/svg/person.svg',
                          colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
                          width: 33,
                        ),

                        title: Transform.translate(
                          offset: const Offset(-4, 0),
                          child: const Text(
                            'Chi cho ai',
                            style: TextStyle(
                                fontSize: textSize,
                                color: labelColor
                            ),
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right,
                          color: iconColor,
                          size: 33,
                        ),
                        contentPadding: const EdgeInsets.only(left: 16, top: 0, bottom: 0, right: 8),
                        onTap: (){},
                      ),
                      const Divider(height: 1, color: underLineColor,indent: 64),
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/svg/location.svg',
                          colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
                          width: 30,
                        ),

                        title: const Text(
                          'Địa điểm',
                          style: TextStyle(
                              fontSize: textSize,
                              color: labelColor
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right,
                          color: iconColor,
                          size: 33,
                        ),
                        contentPadding: const EdgeInsets.only(left: 16, top: 0, bottom: 0, right: 8),
                        onTap: (){},
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
                      style: TextStyle(
                        color: textColor,
                        fontSize: textSize
                      ),
                    ),
                    trailing: Switch(
                      value: isBorrowToPay,
                      activeColor: switchColorButton,
                      trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),

                      thumbColor: const MaterialStatePropertyAll<Color>(secondaryColor),
                      onChanged: (bool value) {
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
                      ListTile(
                        title: const Text(
                          'Phí',
                          style: TextStyle(
                              color: textColor,
                              fontSize: textSize
                          ),
                        ),
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
                      Visibility(
                        visible: isFee,
                        maintainInteractivity: false,
                        maintainState: false,
                        maintainSize: false,
                        child: Column(
                          children: [
                            const Divider(
                              height: 1, color: underLineColor, indent: 65,
                            ),
                            spaceColumn,
                            Column(
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
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                    border: InputBorder.none,
                                    hintText: '0',
                                    hintStyle: const TextStyle(
                                      color: labelColor,
                                    ),

                                    suffixIcon: SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: SvgPicture.asset(
                                        'assets/svg/dong.svg',
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
                                const Divider(height: 1, color: underLineColor, indent: 65,)
                              ],
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                'assets/svg/location.svg',
                                colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
                                width: 30,
                              ),

                              title: const Text(
                                'Địa điểm',
                                style: TextStyle(
                                    fontSize: textSize,
                                    color: labelColor
                                ),
                              ),
                              trailing: const Icon(
                                Icons.keyboard_arrow_right,
                                color: iconColor,
                                size: 33,
                              ),
                              contentPadding: const EdgeInsets.only(left: 16, top: 0, bottom: 0, right: 8),
                              onTap: (){},
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
                      style: TextStyle(
                          color: textColor,
                          fontSize: textSize
                      ),
                    ),
                    subtitle: const Text(
                      'Ghi chép này sẽ không được thống kê vào TẤT CẢ các '
                          'báo cáo(trừ báo cáo Tài chính hiện tại)'
                    ),
                    subtitleTextStyle: const TextStyle(color: labelColor)
                    ,trailing: Switch(
                      value: isNotReport,
                      activeColor: switchColorButton,
                      trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),

                      thumbColor: const MaterialStatePropertyAll<Color>(secondaryColor),
                      onChanged: (bool value) {
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
                        child: IconButton(
                          icon: Icon(Icons.image, size: 45,),
                          color: iconColor,
                          onPressed: () {  },
                        ),
                        flex: 1,
                      ),

                      Container(
                        height: double.infinity,
                        width: 1,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        color: underLineColor,
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.camera_alt, size: 45,),
                          color: iconColor,
                          onPressed: () {  },
                        ),
                        flex: 1,
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