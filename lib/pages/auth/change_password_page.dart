import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/divider.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/utils/custom_toast.dart';
import 'package:practise_ui/widgets/listtitle_textfield.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../widgets/back_toolbar_button.dart';
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordController = TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmNewPasswordController = TextEditingController();

  bool alertOnNullOldPassword = false;

  bool alertOnNullNewPassword = false;

  bool alertOnNullConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text('Đổi mật khẩu', style: appBarTitleTextStyle,),
        leading: const BackToolbarButton(),
      ),
      body: Column(
        children: [
          Container(
            color: secondaryColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  color: backgroundColor,
                  child: const Text(
                    'Mật khẩu từ 6-50 ký tự, ít nhất 1 thường, 1 hoa, 1 số và 1 ký tự đặc biệt.',
                    style: TextStyle(
                      color: labelColor, fontSize: textSmall
                    ),
                  ),
                ),
                defaultDivider,
                ListTitleTextField(
                  leading: SvgPicture.asset(
                    'assets/svg/password.svg',width: 40,
                    colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
                  ),
                  hintText: 'Mật khẩu cũ',
                  controller: _oldPasswordController,
                  paddingLeftLeading: 12,
                  horizontalTitleGap: 10,
                  alertWarming: alertOnNullOldPassword,
                ),
                defaultDivider,
                ListTitleTextField(
                  leading: SvgPicture.asset(
                    'assets/svg/lock-keyhole.svg',width: 40,
                    colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
                  ),
                  hintText: 'Mật khẩu mới',
                  controller: _newPasswordController,
                  paddingLeftLeading: 12,
                  horizontalTitleGap: 10,
                  alertWarming: alertOnNullNewPassword,
                ),
                defaultDivider,
                ListTitleTextField(
                  leading: SvgPicture.asset(
                    'assets/svg/lock-keyhole.svg',width: 40,
                    colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
                  ),
                  hintText: 'Xác nhận mật khẩu mới',
                  controller: _confirmNewPasswordController,
                  paddingLeftLeading: 12,
                  horizontalTitleGap: 10,
                  alertWarming: alertOnNullConfirmPassword,
                ),
                defaultDivider,

              ],
            ),
          ),
          Padding(
            padding: paddingAll12,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: ElevatedButton(
                  onPressed: ()async{
                    String oldPassword = _oldPasswordController.text;
                    String newPassword = _newPasswordController.text;
                    String confirmPassword = _confirmNewPasswordController.text;

                    Map<String, String> dataToUpdate = {
                      'old_password': oldPassword,
                      'password': newPassword,
                      'confirm_password': confirmPassword
                    };
                    if(oldPassword.isNotEmpty && newPassword.isNotEmpty && confirmPassword.isNotEmpty){
                      if(_newPasswordController.text == _confirmNewPasswordController.text){
                        bool result = await Provider.of<UserProvider>(context, listen: false).changePasswordProvider(dataToUpdate);
                        if(result){
                          showCustomSuccessToast(context, 'Đổi mật khẩu thành công', duration: 1);
                          Navigator.pop(context);
                          _newPasswordController.text= '';
                          _oldPasswordController.text = '';
                          _confirmNewPasswordController.text = '';
                        }else {
                          showCustomErrorToast(context, 'Mật khẩu cũ không đúng', 1);
                        }
                      }else {
                        showCustomErrorToast(context, 'Xác nhận mật khẩu không đúng', 1);
                      }
                    }else {
                      if(oldPassword.isEmpty){
                        setState(() {alertOnNullOldPassword = true;});
                      }else{
                        setState(() {alertOnNullOldPassword = false;});
                      }
                      if(newPassword.isEmpty){
                        setState(() {alertOnNullNewPassword = true;});
                      }else{
                        setState(() {alertOnNullNewPassword = false;});
                      }
                      if(confirmPassword.isEmpty){
                        setState(() {alertOnNullConfirmPassword = true;});
                      }else{
                        setState(() {alertOnNullConfirmPassword = false;});
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  child: const Text('LƯU', style: TextStyle(
                    color: secondaryColor, fontSize: textSize
                  ),)
              ),
            ),
          )
        ],
      ),
    );
  }
}
