import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
class DetailSpendingLimitItem extends StatefulWidget {
  const DetailSpendingLimitItem({super.key});

  @override
  State<DetailSpendingLimitItem> createState() => _DetailSpendingLimitItemState();
}

class _DetailSpendingLimitItemState extends State<DetailSpendingLimitItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Tiền sinh hoạt hằng tháng',
          style: TextStyle(
            color: secondaryColor,
            fontSize: textBig,
            fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context){
            if(true){
              return IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: secondaryColor,
                  size: 43
                ),
                onPressed: () {
                  CustomNavigationHelper.router.pop();
                },
              );
            }
          },
        ),
        actions: [
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset('assets/pen-appbar.svg'),
            ),
          )
        ],
      ),
    );
  }
}
