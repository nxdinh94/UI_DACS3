import 'package:flutter/material.dart';
import 'package:practise_ui/pages/home_page/detail_spending_revenue_statistical_page/revenue_tab.dart';
import 'package:practise_ui/pages/home_page/detail_spending_revenue_statistical_page/spending_tab.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';
import '../../../constant/font.dart';
import '../../../providers/chart_provider.dart';
import '../../../widgets/back_toolbar_button.dart';
class DetailSpendingRevenueStatisticalPage extends StatefulWidget {
  const DetailSpendingRevenueStatisticalPage({super.key});

  @override
  State<DetailSpendingRevenueStatisticalPage> createState() => _DetailSpendingRevenueStatisticalPageState();
}

class _DetailSpendingRevenueStatisticalPageState extends State<DetailSpendingRevenueStatisticalPage> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle tabTextStyle = TextStyle(
      color: secondaryColor, fontSize: 24
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            toolbarHeight: 52,
            leading: const Padding(
              padding:  EdgeInsets.only(bottom: 8.0),
              child: BackToolbarButton(),
            ),
            title: const Text('Tháng này', style: TextStyle(
                color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
            )),
            centerTitle: true,
            bottom: const TabBar(
              indicatorWeight: 3,
              indicatorColor: secondaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: primaryColor,
              dividerHeight: 1,
              tabs: [
                Text('Chi', style: tabTextStyle,),
                Text('Thu', style: tabTextStyle,)
              ],
            ),
          ),
          body:  const TabBarView(
              children: [
                SpendingTab(),
                RevenueTab()
              ]
          ),
        ),
      ),
    );
  }
}
