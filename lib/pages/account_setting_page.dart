import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practise_ui/constant/side.dart';

import '../constant/color.dart';
import '../constant/font.dart';
import '../utils/custom_navigation_helper.dart';
class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({super.key});

  @override
  State<AccountSettingPage> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Container(
            color: secondaryColor,
            padding: paddingAll12,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      GestureDetector(
                          onTap: (){
                            CustomNavigationHelper.router.pop();
                          },
                          child:  SvgPicture.asset(
                            "assets/svg/angle-left-svgrepo-com.svg",
                            height: 40,
                            semanticsLabel: 'Back',
                            colorFilter: const ColorFilter.mode(textColor, BlendMode.srcIn),
                          )
                      ),
                      GestureDetector(
                          onTap: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          },
                          child:  SvgPicture.asset(
                            "assets/svg/qrcode.svg",
                            height: 40,
                            semanticsLabel: 'Qrcode',
                            colorFilter: const ColorFilter.mode(textColor, BlendMode.srcIn),

                          )
                      ),
                    ]
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 75,
                      child: CircleAvatar(
                        radius: 43,
                        backgroundColor: Colors.grey.shade400,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/beach and me.jpg'),
                        ),
                      ),
                    ),
                    spaceColumn6,
                    Text('nguyenxuandinh336live',
                        style: const TextStyle(color: textColor, fontSize: textBig, fontWeight: FontWeight.w700),
                    ),
                    Text('nguyenxuandinh336live',
                      style: const TextStyle(
                        color: textColor, fontSize: textSize, height: 0.8
                      ),
                    ),
                    spaceColumn,
                    ElevatedButton(
                      onPressed: (){
                        CustomNavigationHelper.router.push(
                          '${CustomNavigationHelper.anotherPath}/${CustomNavigationHelper.accountSettingPath}/${CustomNavigationHelper.userProfilePath}'
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: const BorderSide(color: labelColor)

                        ),

                      ),

                      child: const Text('Sửa', style: TextStyle(
                        color: textColor, fontSize: textSmall, fontWeight: FontWeight.w400
                      ),))

                  ],
                ),
              ],
            ),
          ),
          spaceColumn,
          Container(
            color: secondaryColor,
            child: Column(
              children: [
                _ListTitle(
                  title: 'Liên kết tài khoản',
                  onTap: () {

                  },
                ),
                const Divider(height: 0,color: underLineColor,),
                _ListTitle(
                  title: 'Đổi mật khẩu',
                  onTap: () {

                  },
                ),
                const Divider(height: 0,color: underLineColor,),
                _ListTitle(
                  title: 'Đăng xuất',
                  onTap: () {

                  },
                  color: spendingMoneyColor,
                ),
                const Divider(height: 0,color: underLineColor,),
              ],
            ),
          )
        ],
      ),

    );
  }
}

class _ListTitle extends StatelessWidget {
  const _ListTitle({
    required this.onTap, required this.title, this.color = textColor
  });
  final VoidCallback onTap;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle( color: color, fontSize: textSize),
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
        color: iconColor,
        size: 33,
      ),
      contentPadding: const EdgeInsets.only(left: 15, top: 0, bottom: 0, right: 6),

    );
  }
}
