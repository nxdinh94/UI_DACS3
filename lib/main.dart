import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:page_transition/page_transition.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/pages/auth/signin_page.dart';
import 'package:practise_ui/pages/auth/unverify_account.dart';
import 'package:practise_ui/providers/app_provider.dart';
import 'package:practise_ui/providers/auth_provider.dart';
import 'package:practise_ui/providers/chart_provider.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/widgets/loading_animation.dart';
import 'package:provider/provider.dart';
import 'package:loader_overlay/loader_overlay.dart';
void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  CustomNavigationHelper.instance;
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  Future.delayed(
    const Duration(seconds: 3), () {
      FlutterNativeSplash.remove();
    }
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider()
        ),
        ChangeNotifierProvider<AppProvider>(
          create: (_)=> AppProvider()
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_)=> UserProvider()
        ),
        ChangeNotifierProvider<ChartProvider>(
            create: (_)=> ChartProvider(),
        ),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (_){
        return const Center(
            child: LoadingAnimation(iconSize: 50)
        );
      },
      overlayColor: backgroundColor.withOpacity(1),
      overlayWholeScreen: false,
      switchInCurve: Curves.easeIn,
      overlayWidth: 100,
      overlayHeight: 100,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),

      child: MaterialApp(
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
      ),
    );
  }
}

class AuthMiddleware extends StatelessWidget {
  final Widget child;

  AuthMiddleware({required this.child});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (auth.isAuth && auth.isVerify == 0) {
      return Navigator(
        onGenerateRoute: (settings) {
          return PageTransition(
            type:  PageTransitionType.leftToRight,
            duration:const Duration(milliseconds: 300),
            child: UnverifyAccountPage(),
          );
        },
      );
    }
    // Kiểm tra xem người dùng đã đăng nhập hay chưa
    return auth.isAuth
        ? child
        : FutureBuilder(
          future: auth.autoLogin(),
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // return const Center(
              //   child: CircularProgressIndicator(
              //     color: whiteColor,
              //   ),
              // );
            }
          return snapshot.data ? child : SignInPage();
        });
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
          resizeToAvoidBottomInset: false,
          body: router!,
        );
      },
    );
  }
}
