import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practise_ui/pages/home_page/detail_spending_revenue_statistical_page/detail_cashflow_category_parent.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../providers/user_provider.dart';
import '../../widgets/back_toolbar_button.dart';
class DetailSpendingPage extends StatefulWidget {
  const DetailSpendingPage({super.key, required this.transformData});
  final List<List<dynamic>> transformData;
  @override
  State<DetailSpendingPage> createState() => _DetailSpendingPageState();
}

class _DetailSpendingPageState extends State<DetailSpendingPage> {

  List<dynamic> allWalletUserData = [];


  @override
  void initState() {

    allWalletUserData = context.read<UserProvider>().accountWalletList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Chi tiết khoảng chi',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: secondaryColor,
              fontSize: textBig,
              fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        leading: const BackToolbarButton(),
      ),
      body: BodyDetailCashflowCategoryParent(
        transformData: widget.transformData,
        allWalletUserData: allWalletUserData,
      ),
    );
  }
}
