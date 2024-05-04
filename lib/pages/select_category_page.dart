import 'dart:ui';

import 'package:flutter/material.dart';
import '../constant/color.dart';
import '../constant/font.dart';
import '../utils/custom_navigation_helper.dart';
class SelectCategoryPage extends StatefulWidget {
  const SelectCategoryPage({super.key});

  @override
  State<SelectCategoryPage> createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  String spendingMoneyIconPath = 'assets/icon_category/spending_money_icon/';
  TabBar get _tabBar => TabBar(
    indicatorColor: Colors.lightBlue.shade200,
    indicatorWeight: 3,
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: underLineColor,
    dividerHeight: 1,
    labelStyle: const TextStyle(
        fontSize: textSize, color: primaryColor
    ),
    unselectedLabelColor: textColor,
    tabs: const [
      Tab(child: Text('CHI TIỀN')),
      Tab(child: Text('THU TIỀN')),
      Tab(child: Text('VAY NỢ')),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(46),
              child: ColoredBox(
                color: Colors.grey.shade200,
                child: _tabBar
              )
            ),
            backgroundColor: primaryColor,
            title: const Text(
              'Chọn hạng mục',
              style: TextStyle(
                  color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
              ),
            ),
            centerTitle: true,
            leading: Builder(
                builder: (BuildContext context){
                  return IconButton(
                    icon: const Icon(
                        Icons.keyboard_arrow_left, color: secondaryColor, size: 43
                    ),
                    onPressed: () {
                      CustomNavigationHelper.router.pop();
                    },
                );
              }
            ),
          ),
          body: const TabBarView(
            children: [
              FirstTabView(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
class FirstTabView extends StatefulWidget {
  const FirstTabView({super.key});

  @override
  State<FirstTabView> createState() => _FirstTabViewState();
}

class _FirstTabViewState extends State<FirstTabView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/icon_category/loan_icon/borrow.png'),
    );
  }
}
class Item{
  Item({
    required this.iconPath,
    required this.title,
    this.isChosen = false,
    this.isExpended = true
  });

  String iconPath;
  String title;
  bool isChosen;
  bool isExpended;
}

