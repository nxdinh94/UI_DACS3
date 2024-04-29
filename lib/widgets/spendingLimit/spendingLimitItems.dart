import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/utils/progress_bar.dart';
import 'package:path/path.dart';

import '../../constant/font.dart';
class SpendingLimitItems extends StatefulWidget {
  const SpendingLimitItems({super.key});

  @override
  State<SpendingLimitItems> createState() => _SpendingLimitItemsState();
}

class _SpendingLimitItemsState extends State<SpendingLimitItems> {
  @override
  Widget build(BuildContext context) {
    var currentRoute = GoRouterState.of(context).uri.toString();
    bool isDetailSpendingLimitItemPage =
    currentRoute =='/detailSpendingLimitItem'? true: false;
    return GestureDetector(
      onTap: (){
        if(!isDetailSpendingLimitItemPage){
          CustomNavigationHelper.router.push(
              CustomNavigationHelper.detailSpendingLimitItemPath
          );
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              Visibility(
                visible: isDetailSpendingLimitItemPage ? false: true,
                child: Container(
                  width: 65,
                  color: Colors.blue,
                  margin: const EdgeInsets.only(right: 12),
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
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: isDetailSpendingLimitItemPage ? false: true,
                      child: Text(
                        'Tiền sinh hoạt hằng tháng',
                        style: textStyleForSpendingLimitItem,
                      )
                    ),
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
