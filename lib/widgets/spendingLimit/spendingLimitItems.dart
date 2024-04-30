import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/utils/progress_bar.dart';
import '../../constant/font.dart';
import '../custom_stack_three_images.dart';
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
                child: StackThreeCircleImages(
                  imageOne: 'assets/sampleImage/aolen.jpg',
                  imageThree: 'assets/sampleImage/girl1.jpg',
                  imageTwo: 'assets/sampleImage/girl3.jpg',
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
                          style: const TextStyle(
                            color: labelColor,
                            fontSize: textSmall
                          )),
                        Text('7.000.000đ', style: const TextStyle(
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


