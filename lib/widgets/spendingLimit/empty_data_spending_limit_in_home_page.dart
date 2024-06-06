import 'package:flutter/material.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../constant/side.dart';
import '../../utils/custom_navigation_helper.dart';
class EmptyDataSpendingLimitInHomePage extends StatelessWidget {
  const EmptyDataSpendingLimitInHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Center(
        child: Column(
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: 'Cùng ', style: labelTextStyle,
                    children: [
                      TextSpan(
                          text: 'Sổ thu chi MISA ',
                          style: TextStyle(fontSize: textSize, color: textColor, fontWeight: FontWeight.w600)
                      ),
                      TextSpan(
                          text: 'lập ra các hạn mức chi để quản lý chi tiêu tốt hơn nhé! ',
                          style: labelTextStyle
                      ),

                    ]
                )
            ),
            spaceColumn,
            GestureDetector(
              onTap: (){
                CustomNavigationHelper.router.push(
                    CustomNavigationHelper.addSpendingLimitPath
                );
              },
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(color: primaryColor, fontSize: textSize),
                    children: [
                      WidgetSpan(
                          child: Icon(Icons.add,color: primaryColor, size: 30,),
                          alignment: PlaceholderAlignment.middle
                      ),
                      TextSpan(
                        text: 'Thêm hạn mức chi',
                      )
                    ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
