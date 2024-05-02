import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/pages/home_page.dart';
import 'package:practise_ui/pages/signin_page.dart';
import 'package:practise_ui/pages/signup_page.dart';
import 'package:practise_ui/providers/auth_provider.dart';
import 'package:provider/provider.dart';
class UnverifyAccountPage extends StatelessWidget {
  UnverifyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: whiteColor,
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 280,
                  width: double.infinity,
                  child: Image.asset('assets/unverify.png'),
                ),
                Text("Xác thực tài khoản", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                )),
                SizedBox(height: 10,),
                Container(
                  width: 320,
                  child: Text("Chúng tôi đã gửi email cho bạn, hãy kiểm tra hòm thư và xác thực rằng đây là tài khoản của bạn",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: 15,
                  )),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Gửi lại",
                      style: TextStyle(
                          fontSize: 15,
                          color: whiteColor
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Góc bo tròn
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Provider.of<AuthProvider>(context, listen: false).logout();
                  },
                  child: Text(
                    'Quay lại',
                    style: TextStyle(
                        fontSize: 15,
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
