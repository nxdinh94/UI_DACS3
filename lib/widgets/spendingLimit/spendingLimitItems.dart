import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/utils/progress_bar.dart';
import 'package:practise_ui/widgets/rich_text/vnd_rich_text.dart';
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
      behavior: HitTestBehavior.opaque,
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
                    Row(
                      mainAxisAlignment: isDetailSpendingLimitItemPage?
                      MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: isDetailSpendingLimitItemPage ? false: true,
                          child: Flexible(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              'Tiền sinh hoạt hằng tháng',
                              style: defaultTextStyle,
                            ),
                          )
                        ),
                        Visibility(
                          visible: true,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(color: spendingMoneyColor, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('Hết hạn', style: TextStyle(
                              color: spendingMoneyColor, fontSize: textSmall
                            )),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '01/04 - 30/4',
                          style: const TextStyle(color: labelColor, fontSize: textSmall)),
                        VndRichText(
                          value: 7000000, fontSize: textBig, color: textColor, iconSize: 16
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]

          ),
          spaceColumn,
          MyProgressBar(
            percentage: 0.29,
            color: Colors.red,
          ),
          spaceColumn,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Còn 1 ngày', style: TextStyle(fontSize: textSmall, color: labelColor)),
              VndRichText(
                value: 7000000, fontSize: textBig, color: textColor, iconSize: 16
              ),
            ],
          ),
        ],
      ),
    );
  }
}


