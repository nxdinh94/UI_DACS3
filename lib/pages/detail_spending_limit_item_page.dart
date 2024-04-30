import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/widgets/charts/area_chart.dart';
import 'package:practise_ui/widgets/spendingLimit/spendingLimitItems.dart';
class DetailSpendingLimitItem extends StatefulWidget {
  const DetailSpendingLimitItem({super.key});

  @override
  State<DetailSpendingLimitItem> createState() => _DetailSpendingLimitItemState();
}

class _DetailSpendingLimitItemState extends State<DetailSpendingLimitItem> {
  final TextStyle labelStyle = const TextStyle(fontSize: 15, color: labelColor);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Tiền sinh hoạt hằng tháng',
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
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset('assets/pen-appbar.svg'),
            ),
          )
        ],
      ),
      body: Container(
        color: backgroundColor,
        child: ListView(
          children: [
            Container(
              color: secondaryColor,
              padding: paddingV6H12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Hạn mức', style: TextStyle(color: textColor, fontSize: textSmall)),
                  Text('7.000.000đ', style: TextStyle(
                      fontSize: textSize, fontWeight: FontWeight.w700, color: textColor
                  ),)
                ],
              ),
            ),
            spaceColumn,
            Container(
              color: secondaryColor,
              padding: paddingAll12,
              child: SpendingLimitItems(),
            ),
            spaceColumn,
            Container(
              padding: const EdgeInsets.only(left: 12),
              color: secondaryColor,
              child:  ListTile(
                onTap: (){},
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                title: const Text(
                  'Chi tiết khoản chi',
                  style: TextStyle(
                      fontSize: textSize,
                      color: textColor
                  ),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: iconColor,
                  size: 33,
                ),

              ),
            ),
            spaceColumn,
            Container(
              color: secondaryColor,
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                children: [
                  MyAreaChart(),
                  const Divider(height: 1, color: underLineColor,indent: 30,endIndent: 30,),
                  spaceColumn6,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text:  TextSpan(
                          children: [
                            TextSpan(
                                text: "Thực tế chi tiêu",
                                style: labelStyle
                            ),
                            const TextSpan(text: ' '),
                            const WidgetSpan(
                                child: CustomToolTip(
                                  tooltipText: 'ST đã chi / Khoảng thời gian chi tiêu',
                                ),
                                alignment: PlaceholderAlignment.middle
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Nên chi",
                                style: labelStyle
                            ),
                            const TextSpan(text: ' '),
                            const WidgetSpan(
                                child: CustomToolTip(
                                  tooltipText: 'ST còn lại / Số ngày còn lại',
                                ),
                                alignment: PlaceholderAlignment.middle
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  spaceColumn,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                                text: "122.221",
                                style: TextStyle(fontSize: textSmall, color: textColor)
                            ),
                            // const TextSpan(text: ' '),
                            WidgetSpan(
                                child: SvgPicture.asset(
                                  'assets/dong.svg',
                                  height: 16,
                                  colorFilter: const ColorFilter.mode(textColor, BlendMode.srcIn),
                                ),
                                alignment: PlaceholderAlignment.bottom
                            ),
                            const TextSpan(text: ' '),
                            const TextSpan(text: '/ngày',  style: TextStyle(fontSize: 15, color: labelColor)),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                                text: "334.221",
                                style: TextStyle(fontSize: textSmall, color: textColor)
                            ),
                            // const TextSpan(text: ' '),
                            WidgetSpan(
                                child: SvgPicture.asset(
                                  'assets/dong.svg',
                                  height: 16,
                                  colorFilter: const ColorFilter.mode(textColor, BlendMode.srcIn),
                                ),
                                alignment: PlaceholderAlignment.bottom
                            ),
                            const TextSpan(text: ' '),
                            const TextSpan(text: '/ngày',  style: TextStyle(fontSize: 15, color: labelColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  spaceColumn6,
                  const Divider(height: 1, color: underLineColor,indent: 30,endIndent: 30,),
                  spaceColumn6,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Dự kiến chi tiêu",
                                style: labelStyle
                            ),
                            const TextSpan(text: ' '),
                            const WidgetSpan(
                              child: CustomToolTip(
                                tooltipText: 'Thực tế chi tiêu * Số ngày còn lại \n + ST đã chi',
                              ),
                              alignment: PlaceholderAlignment.middle
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  spaceColumn,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "444.333",
                                style: const TextStyle(fontSize: textSmall, color: revenueMoneyColor)
                            ),
                            const TextSpan(text: ' '),
                            WidgetSpan(
                                child: SvgPicture.asset(
                                  'assets/dong.svg',
                                  height: 16,
                                  colorFilter: const ColorFilter.mode(revenueMoneyColor, BlendMode.srcIn),
                                ),
                                alignment: PlaceholderAlignment.bottom
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomToolTip extends StatelessWidget {
  final String tooltipText;

  const CustomToolTip({
    super.key, required this.tooltipText,
  });
  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      backgroundColor: Colors.black54,
      tailBaseWidth: 10,
      tailLength: 8,
      preferredDirection: AxisDirection.up,
      content: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          tooltipText,
          style: const TextStyle(color: secondaryColor),
          textAlign: TextAlign.center,
        ),
      ),
      child: Material(
        child: SvgPicture.asset(
          'assets/question-mark-round.svg',
          colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}
