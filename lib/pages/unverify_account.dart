import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/pages/home_page.dart';
import 'package:practise_ui/pages/signup_page.dart';
import 'package:practise_ui/providers/auth_provider.dart';
import 'package:provider/provider.dart';
class UnverifyAccountPage extends StatelessWidget {
  UnverifyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.asset('assets/unverify.png'),
            ),
            Text("Xác thực tài khoản", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
            SizedBox(height: 10,),
            Container(
              width: 300,
              child: Text("Chúng tôi đã gửi email cho bạn, hãy kiểm tra hòm thư và xác thực rằng đây là email của bạn",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 15,
              )),
            ),
            SizedBox(height: 30,),
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
          ],
        )
      ),
    );
  }
}
