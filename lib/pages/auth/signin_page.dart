import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/pages/auth/signup_page.dart';
import 'package:practise_ui/providers/auth_provider.dart';
import 'package:practise_ui/utils/custom_toast.dart';
import 'package:practise_ui/utils/loading_dialog.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController(text: 'nxdinh94@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: ' a1s2d3f4g5h6KT@');
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
      final isError = Provider.of<AuthProvider>(context, listen: false).isError;
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
                    const Text('Đăng nhập tài khoản của bạn',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: textSize,
                          color: textColor
                      ),
                    ),
                    spaceColumn,
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
                                labelStyle: const TextStyle(color: labelColor, fontSize: textSmall),
                                prefixIcon: const Icon(Icons.email_outlined, color: primaryColor, size: 24,),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: inputColor, width: 2),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                floatingLabelStyle: const TextStyle(color: labelColor, fontSize: textSize),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                contentPadding: const EdgeInsets.only(left: 50, top: 35),
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
                                labelStyle: const TextStyle(color: labelColor, fontSize: textSmall),
                                prefixIcon: const Icon(Icons.key_outlined, color: primaryColor, size: 24,),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText ? Icons.visibility : Icons.visibility_off,
                                    color: iconColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: inputColor, width: 2),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                floatingLabelStyle: const TextStyle(color: labelColor, fontSize: textSize),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                contentPadding: const EdgeInsets.only(left: 50, top: 35),
                              ),
                              onSaved: (value) {
                                _password = value!;
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Quên mật khẩu?',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: textSmall,
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
                                    Future.delayed(const Duration(seconds: 3), () => {
                                      _handleSubmit(),
                                      // Tắt hiệu ứng loading
                                      hideCustomLoadingDialog(context),
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Góc bo tròn
                                  ),
                                ),
                                child: const Text('Đăng nhập',
                                  style: TextStyle(fontSize: textSize, color: secondaryColor),
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                    spaceColumn,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bạn chưa có tài khoản?',
                          style: TextStyle(fontSize: textSmall, color: textColor),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.leftToRight,
                                duration: const Duration(milliseconds: 300),
                                child: const SignUpPage(),
                              ),
                            );
                            _setEmptyValue();
                          },
                          child: const Text(
                            'Đăng ký',
                            style: TextStyle(
                              fontSize: textSmall, color: primaryColor, fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    spaceColumn,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Divider(color: underLineColor)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Hoặc đăng nhập bằng',
                              style: TextStyle(color : labelColor, fontSize: textSmall),
                            ),
                          ),
                          Expanded(child: Divider(color: underLineColor)),
                        ],
                      ),
                    ),
                    spaceColumn,
                    InkWell(
                      onTap: () {},
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Custom cho hiệu ứng tap vào vừa với icon
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(15),
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