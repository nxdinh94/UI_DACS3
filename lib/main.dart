import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/pages/adding_workspace.dart';
import 'package:practise_ui/pages/home_page.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';

void main() {
  CustomNavigationHelper.instance;
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: CustomNavigationHelper.router,
      debugShowCheckedModeBanner: false,
      builder: (context, router) {
        return MaterialApp(
          title: 'Do an co so 3',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue.shade400),
              useMaterial3: true,
              unselectedWidgetColor: Colors.grey

          ),
          home: Container(
            color: primaryColor,
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SafeArea(
                child: Scaffold(
                  body: router!,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

