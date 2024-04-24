import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/pages/signin_page.dart';
import 'package:practise_ui/pages/unverify_account.dart';
import 'package:practise_ui/providers/auth_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:provider/provider.dart';

void main() {
  CustomNavigationHelper.instance;
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue.shade400),
        useMaterial3: true,
        unselectedWidgetColor: Colors.grey,
      ),
      home: Container(
        color: primaryColor,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: AuthMiddleware(
              child: CustomRouter(), // Use CustomRouter as home
            ),
          ),
        ),
      ),
    );
  }
}

class AuthMiddleware extends StatelessWidget {
  final Widget child;

  AuthMiddleware({required this.child});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    // Kiểm tra xem người dùng đã đăng nhập hay chưa
    if (authProvider.isAuth) {
      if (authProvider.isVerify == 0) {
        return UnverifyAccountPage();
      }
      // Nếu đã đăng nhập, hiển thị router như thông thường
      return child;
    } else {
      // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
      return SignInPage();
    }
  }
}

class CustomRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: CustomNavigationHelper.router,
      debugShowCheckedModeBanner: false,
      builder: (context, router) {
        return Scaffold(
          body: router!,
        );
      },
    );
  }
}
