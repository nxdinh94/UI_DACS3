import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({
    super.key,
    required this.child,
  });

  final StatefulNavigationShell child;

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar:  BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        currentIndex: widget.child.currentIndex,
        onTap: (index) {
          widget.child.goBranch(
            index,
            initialLocation: index == widget.child.currentIndex,
          );
          setState(() {});
        },
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Tài khoản',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, weight: 20),
            label: 'Thêm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Báo cáo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Khác',
          ),
      ],
      // currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      selectedFontSize: 20,
      selectedIconTheme: const IconThemeData(size: 34),
      // onTap: _onItemTapped,
    ),
    );
  }
}