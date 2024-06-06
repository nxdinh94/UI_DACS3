import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/utils/progress_bar.dart';
import 'package:practise_ui/widgets/rich_text/vnd_rich_text.dart';
import 'package:provider/provider.dart';
import '../../constant/font.dart';
import '../custom_stack_three_images.dart';
class SpendingLimitItems extends StatefulWidget {
  const SpendingLimitItems({
    super.key,
    required this.itemSpendingLimit
  });
  final Map<String, dynamic> itemSpendingLimit;
  @override
  State<SpendingLimitItems> createState() => _SpendingLimitItemsState();
}

class _SpendingLimitItemsState extends State<SpendingLimitItems> {

  bool isSpendingLimitOutOfDate = false;
  String startTime = '';
  String endTime = '';
  int remainDay = 0;
  double remainMoney = 0;
  String name = '';
  String id = '';
  double initialMoney = 0;
  double totalSpendingMoney = 0;
  double spendingPercentage = 0;
  int dateTimeToSecondsSinceEpoch(DateTime dateTime) {
    return (dateTime.millisecondsSinceEpoch / 1000).round();
  }
  bool onSpendingLimitOutOfDate (DateTime endDate){
    bool result = false;
    DateTime now = DateTime.now();
    int endDateToSecond = dateTimeToSecondsSinceEpoch(endDate);
    int nowToSecond = dateTimeToSecondsSinceEpoch(now);
    if(nowToSecond > endDateToSecond){
      result = true;
    }else {
      result = false;
    }
    return result;
  }

  @override
  void initState() {
    DateTime startDate = DateTime.parse(widget.itemSpendingLimit['start_time']);
    DateTime endDate = DateTime.parse(widget.itemSpendingLimit['end_time']);

    startTime = DateFormat('dd/MM').format(startDate);
    endTime = DateFormat('dd/MM').format(endDate);
    isSpendingLimitOutOfDate =  onSpendingLimitOutOfDate(endDate);
    initialMoney = double.parse(widget.itemSpendingLimit['amount_of_money'][r'$numberDecimal']) ;

    name = widget.itemSpendingLimit['name'];
    id = widget.itemSpendingLimit['_id'];
    totalSpendingMoney = double.parse(widget.itemSpendingLimit['total_spending'][r'$numberDecimal']) ;
    remainMoney = initialMoney - totalSpendingMoney;

    if(remainMoney < 0){
      remainMoney = - remainMoney;
      spendingPercentage = 1;
    }else {
      spendingPercentage = (totalSpendingMoney / initialMoney);
    }
    //calculate remain day
    int endDay = endDate.day;
    if(isSpendingLimitOutOfDate){
      remainDay = 0;
    }else{
      remainDay = endDay - DateTime.now().day;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentRoute = GoRouterState.of(context).uri.toString();
    bool isDetailSpendingLimitItemPage =
    currentRoute =='/detailSpendingLimitItem'? true: false;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: ()async{
        if(!isDetailSpendingLimitItemPage){
        await Provider.of<UserProvider>(context, listen: false).getSpecificSpendingLimitProvider(id);

        CustomNavigationHelper.router.push(
              CustomNavigationHelper.detailSpendingLimitItemPath, extra: widget.itemSpendingLimit
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
                    imageOne: 'assets/icon_category/spending_money_icon/anUong/dinner.png',
                    imageTwo: 'assets/icon_category/spending_money_icon/anUong/cutlery.png',
                    imageThree: 'assets/icon_category/spending_money_icon/anUong/burger_parent.png'
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
                              name,
                              style: defaultTextStyle,
                            ),
                          )
                        ),
                        Visibility(
                          visible: isSpendingLimitOutOfDate,
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
                          '$startTime - $endTime',
                          style: const TextStyle(color: labelColor, fontSize: textSmall)),
                        VndRichText(
                          value: double.parse(
                            widget.itemSpendingLimit['amount_of_money'][r'$numberDecimal']
                          ),
                          fontSize: textBig, color: textColor, iconSize: 16
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
            percentage: spendingPercentage,
            color: spendingPercentage >= 0.8 ? Colors.red : Colors.orangeAccent,
            lineHeight: 12,
          ),
          spaceColumn,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Còn $remainDay ngày', style: const TextStyle(fontSize: textSmall, color: labelColor)),
              RichText(
                text: TextSpan(
                  children: [
                    spendingPercentage == 1 ? const TextSpan(
                      text: '( Bội chi ) ',
                      style: labelTextStyle
                    ): const TextSpan(),
                    WidgetSpan(
                      child: VndRichText(
                          value: remainMoney, fontSize: textSize,
                          color: spendingPercentage == 1? spendingMoneyColor: textColor,
                          iconSize: 14
                      )
                    )
                  ]
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}


