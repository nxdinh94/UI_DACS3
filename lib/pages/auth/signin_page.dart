import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/pages/home_page.dart';
import 'package:practise_ui/pages/auth/signup_page.dart';
import 'package:practise_ui/pages/user_profile.dart';
import 'package:practise_ui/providers/auth_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/utils/custom_toast.dart';
import 'package:practise_ui/utils/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _email = '';
  String _password = '';
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    bool _basicValidate() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
      if (_email.isEmpty) {
        showCustomErrorToast(context, "Vui lòng điền email", 3);
        return false;
      }
      if (_password.isEmpty) {
        showCustomErrorToast(context, "Vui lòng điền mật khẩu", 3);
        return false;
      }

      return true;
    }

    void _handleSubmit() async {
      await Provider.of<AuthProvider>(context, listen: false).login(_email, _password);
      final isError = await Provider.of<AuthProvider>(context, listen: false).isError;
      if (isError) {
        showCustomErrorToast(context, "Email hoặc mật khẩu không đúng", 3);
      }
    }

    void _setEmptyValue() {
      _emailController.clear();
      _passwordController.clear();
    }

    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Container(
          color: primaryColor,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: whiteColor,
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/login_img.jpg', width: 200, height: 200,),
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
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: labelColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                                ),
                                prefixIcon: Icon(Icons.email_outlined, color: primaryColor, size: 24,),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: inputColor, width: 2),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: labelColor,
                                  fontSize: 18,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                contentPadding: EdgeInsets.only(left: 50, top: 35),
                              ),
                              onSaved: (value) {
                                _email = value!;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelText: 'Mật khẩu',
                                labelStyle: TextStyle(
                                    color: labelColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                                prefixIcon: Icon(Icons.key_outlined, color: primaryColor, size: 24,),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText ? Icons.visibility : Icons.visibility_off,
                                    color: labelColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: inputColor, width: 2),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: labelColor,
                                  fontSize: 18,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                contentPadding: EdgeInsets.only(left: 50, top: 35),
                              ),
                              onSaved: (value) {
                                _password = value!;
                              },
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
                                onPressed: () {
                                  if (_basicValidate()) {
                                    showCustomLoadingDialog(context);
                                    // Hiệu ứng loading
                                    Future.delayed(Duration(seconds: 3), () => {
                                      _handleSubmit(),
                                      // Tắt hiệu ứng loading
                                      hideCustomLoadingDialog(context),
                                    });
                                  }
                                },
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
                          ]
                      ),
                    ),
                    SizedBox(
                        height: 15
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
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.leftToRight,
                                duration: Duration(milliseconds: 300),
                                child: SignUpPage(),
                              ),
                            );
                            _setEmptyValue();
                          },
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
                    SizedBox(
                        height: 15
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(color: Colors.grey,),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Hoặc đăng nhập bằng',
                              style: TextStyle(color: Colors.grey,),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: Colors.grey),
                          ),
                        ],
                      ),
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}