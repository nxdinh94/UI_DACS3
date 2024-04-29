import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/models/register_body.dart';
import 'package:practise_ui/pages/home_page.dart';
import 'package:practise_ui/pages/signin_page.dart';
import 'package:practise_ui/pages/unverify_account.dart';
import 'package:practise_ui/providers/auth_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/utils/custom_toast.dart';
import 'package:practise_ui/utils/loading_dialog.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirm_password = '';

  @override
  Widget build(BuildContext context) {
    void _handleRegister() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }

      RegisterReqBody reqBody = RegisterReqBody(
        name: _name,
        email: _email,
        password: _password,
        confirmPassword: _confirm_password,
      );

      await Provider.of<AuthProvider>(context, listen: false).register(reqBody);
      final isRegisterSucces = await Provider.of<AuthProvider>(context, listen: false).isRegisterSuccess;
      if (isRegisterSucces) {
        showCustomSuccessToast(context, "Đăng ký thành công! Kiểm tra email để xác thực tài khoản");
      }
    }

    void _setEmptyValue() {
      _emailController.clear();
      _passwordController.clear();
      _nameController.clear();
      _confirmPasswordController.clear();
    }

    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, size: 30,),
                  onPressed: () {
                    // Quay lại màn hình trước đó
                    Navigator.pop(context);
                  },
                ),
                floating: false,
                pinned: false,
                snap: false,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieBuilder.asset('assets/lotties/Animation - 1714317330939.json', width: 120,),
                          Text("Bắt đầu nào!", style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w900
                          ),),
                          Text("Tạo tài khoản để sử dụng tất cả chức năng", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: labelColor
                          ),),
                          SizedBox(height: 20,),
                          Form(
                            key: _formKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    controller: _nameController,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15
                                    ),
                                    decoration: InputDecoration(
                                        hintText: 'Họ và tên',
                                        prefixIcon: Icon(Icons.account_circle_outlined, color: primaryColor, size: 24,),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: inputColor, width: 2),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        contentPadding: EdgeInsets.only(top: 35)
                                    ),

                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Tên không được để trống';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _name = value!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  TextFormField(
                                    controller: _emailController,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15
                                    ),
                                    decoration: InputDecoration(
                                        hintText: 'Email',
                                        prefixIcon: Icon(Icons.email_outlined, color: primaryColor, size: 24,),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: inputColor, width: 2),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        contentPadding: EdgeInsets.only(top: 35)
                                    ),

                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Email không được để trống';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _email = value!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscureText,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Mật khẩu',
                                      prefixIcon: Icon(Icons.key_outlined, color: primaryColor, size: 24,),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: inputColor, width: 2),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      contentPadding: EdgeInsets.only(top: 35),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureText ? Icons.visibility : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Mật khẩu không được để trống';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _password = value!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: _obscureText,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Nhập lại mật khẩu',
                                      prefixIcon: Icon(Icons.key_outlined, color: primaryColor, size: 24,),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: inputColor, width: 2),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      contentPadding: EdgeInsets.only(top: 35),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureText ? Icons.visibility : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Mật khẩu không được để trống';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _confirm_password = value!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showCustomLoadingDialog(context);
                                        // Hiệu ứng loading
                                        Future.delayed(Duration(seconds: 3), () => {
                                          _handleRegister(),
                                          // Tắt hiệu ứng loading
                                          hideCustomLoadingDialog(context),
                                          _setEmptyValue()
                                        });
                                      },
                                      child: const Text('Đăng ký',
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
                        ],
                      ),
                    );
                  },
                  childCount: 1, // Replace this with the number of widgets
                ),
              ),
            ],
          )
        ), // Use CustomRouter as home
      ),
    );
  }
}
