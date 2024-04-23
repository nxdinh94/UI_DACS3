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
    // int _selectedIndex = 0;
    // List<Widget> _navigationOptions = <Widget>[
    //   HomePage(),
    //   Text(
    //     'Index 2: Business',
    //   ),
    //   AddingWorkspace(),
    //   Text(
    //     'Index 4: School',
    //   ),
    //
    //   // UserProfile(),
    //   CustomDropdownMenu()
    // ];
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: CustomNavigationHelper.router,
    );
    // return MaterialApp(
    //   title: 'Do an co so 3',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue.shade400),
    //     useMaterial3: true,
    //     unselectedWidgetColor: Colors.grey
    //   ),
    //   home: Container(
    //     color: primaryColor,
    //     child: GestureDetector(
    //       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    //       child: SafeArea(
    //         child: Scaffold(
    //           body: _navigationOptions[_selectedIndex],
    //           bottomNavigationBar: BottomNavigationBar(
    //             type: BottomNavigationBarType.fixed,
    //             showUnselectedLabels: true,
    //             unselectedItemColor: Colors.grey,
    //             selectedLabelStyle: const TextStyle(fontSize: 14),
    //             backgroundColor: Colors.white,
    //             items:  <BottomNavigationBarItem>[
    //               BottomNavigationBarItem(
    //                 icon: Icon(Icons.home),
    //                 label: 'Trang chủ',
    //               ),
    //               BottomNavigationBarItem(
    //                 icon: Icon(Icons.wallet),
    //                 label: 'Tài khoản',
    //               ),
    //               BottomNavigationBarItem(
    //                 icon: Icon(Icons.add, weight: 20),
    //                 label: 'Thêm',
    //               ),
    //               BottomNavigationBarItem(
    //                 icon: Icon(Icons.bar_chart),
    //                 label: 'Báo cáo',
    //               ),
    //               BottomNavigationBarItem(
    //                 icon: Icon(Icons.settings),
    //                 label: 'Khác',
    //               ),
    //             ],
    //             currentIndex: _selectedIndex,
    //             selectedItemColor: Colors.blue,
    //             selectedFontSize: 20,
    //             selectedIconTheme: IconThemeData(size: 34),
    //             onTap: _onItemTapped,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    //   debugShowCheckedModeBanner: false,
    // );
  }
}

