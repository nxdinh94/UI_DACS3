import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/widgets/empty_value_screen.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/divider.dart';
import '../../constant/font.dart';
import '../../utils/custom_navigation_helper.dart';
import '../../widgets/spendingLimit/spendingLimitItems.dart';
class ListSpendingLimitItemPage extends StatefulWidget {
  const ListSpendingLimitItemPage({super.key});

  @override
  State<ListSpendingLimitItemPage> createState() => _ListSpendingLimitItemPageState();
}

class _ListSpendingLimitItemPageState extends State<ListSpendingLimitItemPage> {
  
  @override
  void initState() {
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Hạn mức chi',
          style: TextStyle(
              color: secondaryColor,
              fontSize: textBig,
              fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: const Icon(
                    Icons.keyboard_arrow_left,
                    color: secondaryColor,
                    size: 43
                ),
                onPressed: () {
                  CustomNavigationHelper.router.pop();
                },
              );
            }
        ),
        actions: [
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: SvgPicture.asset('assets/svg/information-button.svg',width: 23),
            ),
          ),
          GestureDetector(
            onTap: (){
              CustomNavigationHelper.router.push(
                CustomNavigationHelper.addSpendingLimitPath
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset('assets/svg/plus.svg', width: 36,),
            ),
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, value, child) {
          List<dynamic> spendingLimitList = value.allSpendingLimit;
          if(spendingLimitList.isEmpty){
            return const EmptyValueScreen(title: 'Không có hạn mức chi', isAccountPage: false);
          }
          return ListView(
              children: spendingLimitList.map((e){
                return Column(
                  children: [
                    Container(
                      padding: paddingAll12,
                      color: secondaryColor,
                      child: SpendingLimitItems(itemSpendingLimit: e),
                    ),
                    defaultDivider
                  ],
                );
              }).toList()
          );
        },
      ),
    );
  }
}
