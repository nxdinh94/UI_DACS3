import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../utils/custom_navigation_helper.dart';
class ListSpendingLimitItemPage extends StatefulWidget {
  const ListSpendingLimitItemPage({super.key});

  @override
  State<ListSpendingLimitItemPage> createState() => _ListSpendingLimitItemPageState();
}

class _ListSpendingLimitItemPageState extends State<ListSpendingLimitItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Hạn mức chi',
          style: const TextStyle(
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
    );
  }
}
