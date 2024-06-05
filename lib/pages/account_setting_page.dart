import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/color.dart';
import '../constant/font.dart';
import '../providers/auth_provider.dart';
import '../utils/custom_navigation_helper.dart';
import '../utils/qr_code_scanner/qr_code_scanner.dart';
class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({super.key});

  @override
  State<AccountSettingPage> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {

  void setResult(String result) {
    scannerSuccessDialog(context, result);
  }
  Future<void> _launchUrl(uri) async {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
  Future<void> scannerSuccessDialog(BuildContext context, String result) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quét QR thành công'),
          content: GestureDetector(
            onTap: (){
              final uri = Uri.parse(result);
              _launchUrl(uri);
            },
            child: Text(
              result, style: defaultTextStyle
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Copy', style: defaultTextStyle,),
              onPressed: () {
                //result is a link
                Clipboard.setData(ClipboardData(text: result));
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Thoát', style: defaultTextStyle),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => QrCodeScanner(setResult: setResult),
                            ),
                          ),
                          child:  SvgPicture.asset(
                            "assets/svg/qrcode.svg",
                            height: 40,
                            semanticsLabel: 'Qrcode',
                            colorFilter: const ColorFilter.mode(textColor, BlendMode.srcIn),
                          )
                      ),
                    ]
                ),
                Consumer<UserProvider>(
                  builder: (context, value, child) {
                    Map<String, dynamic> meData = value.meData;
                    if(meData.isEmpty){
                      return SizedBox(
                        height: 250,
                        child: LoadingAnimationWidget.inkDrop(
                          color: primaryColor,
                          size: 80,
                        ),
                      );
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 75,
                          child: CircleAvatar(
                            radius: 43,
                            child: ClipOval(
                              child: meData['avatar'] ==''? Image.asset('assets/another_icon/avt-fb.jpg')
                                  :  Image.network(meData['avatar']),
                            ),
                          ),
                        ),
                        spaceColumn6,
                        Text(meData['name'] ?? 'Anonymous',
                          style: const TextStyle(color: textColor, fontSize: textBig, fontWeight: FontWeight.w700),
                        ),
                        Text(meData['email'] ?? 'anonymous@gmail.com',
                          style: const TextStyle(
                              color: textColor, fontSize: textSize, height: 0.8
                          ),
                        ),
                        spaceColumn,
                        ElevatedButton(
                            onPressed: (){
                              CustomNavigationHelper.router.push(
                                  '${CustomNavigationHelper.accountSettingPath}/${CustomNavigationHelper.userProfilePath}'
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
                    );
                  },
                )
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
                  onTap: () async{
                     await Provider.of<AuthProvider>(context, listen: false).logout();
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
