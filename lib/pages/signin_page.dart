import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/pages/home_page.dart';
import 'package:practise_ui/pages/signup_page.dart';
import 'package:practise_ui/providers/auth_provider.dart';
import 'package:provider/provider.dart';
class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void handleSubmit() {
      final email = _emailController.text;
      final password = _passwordController.text;
      if (email.isNotEmpty && password.isNotEmpty) {
        Provider.of<AuthProvider>(context, listen: false).login(email, password);
      }
    }

    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          backgroundColor: whiteColor,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/logo.jpg'), width: 200, height: 200,),
                Text('Đăng nhập tài khoản của bạn',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: textColor
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: inputColor, // Màu viền xám
                      width: 1.0,
                    ),
                  ),
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: inputColor, // Màu viền xám
                      width: 1.0,
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15
                    ),
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: 'Mật khẩu',
                        border: InputBorder.none
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Quên mật khẩu?',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: handleSubmit,
                    child: const Text('Đăng nhập',
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
                SizedBox(
                    height: 30
                ), // Khoảng cách giữa nút và dòng "Hoặc đăng nhập bằng"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Hoặc đăng nhập bằng',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {},
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Custom cho hiệu ứng tap vào vừa với icon
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: inputColor,
                        width: 1.0
                      )
                    ),
                    child: Image.asset(
                      'assets/google_icon.png',
                      width: 30, // Chiều rộng của ảnh
                      height: 30, // Chiều cao của ảnh
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bạn chưa có tài khoản?',
                      style: TextStyle(fontSize: 15, ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
