import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/utils/progress_bar.dart';

import '../../constant/font.dart';
class SpendingLimitItems extends StatelessWidget {
  const SpendingLimitItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        CustomNavigationHelper.router.push(
          CustomNavigationHelper.detailSpendingLimitItemPath
        );
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 65,
                color: Colors.blue,
                child: Stack(
                  children: [
                    Positioned(
                      left: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        radius: 21,
                      ),
                    ),
                    Positioned(
                      left: 10,
                      child: CircleAvatar(
                        backgroundColor: secondaryColor,
                        radius: 21,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 18,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 21,
                      backgroundColor: secondaryColor,
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 18,
                      ),
                    ),
                ],
                            ),
              ),
              spaceRow,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tiền sinh hoạt hằng tháng', style: textStyleForSpendingLimitItem,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '01/04 - 30/4',
                          style: TextStyle(
                            color: labelColor,
                            fontSize: textSmall
                          )),
                        Text('7.000.000đ', style: TextStyle(
                          color: textColor, fontSize: textBig
                        ),),
                      ],
                    ),
                  ],
                ),
              )
            ]

          ),
          spaceColumn,
          MyProgressBar(),
          spaceColumn,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Còn 1 ngày', style: TextStyle(
                fontSize: textSmall,
                color: labelColor
              ),),
              Text('6.000.000đ', style: TextStyle(
                fontSize: textSize
              ),),
            ],
          ),
        ],
      ),
    );
  }
}
