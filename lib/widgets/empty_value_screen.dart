import 'package:flutter/material.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
class EmptyValueScreen extends StatelessWidget {
  const EmptyValueScreen({
    super.key,
    this.iconSize = 100,
    this.isAccountPage = true,
    required this.title,
  });

  final double iconSize;
  final bool isAccountPage;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Image.asset('assets/another_icon/grey-coin.png', width: iconSize),
            spaceColumn,
            Text(title,style: const TextStyle(
                color: labelColor, fontSize: textSize
            )),
            spaceColumn6,
            Visibility(
              visible: isAccountPage,
              child: GestureDetector(
                onTap: (){
                  CustomNavigationHelper.router.push(
                      '${CustomNavigationHelper.accountWalletPath}/${CustomNavigationHelper.addAccountWalletPath}'
                  );
                },
                child: RichText(
                    text: const TextSpan(
                        text: '+',
                        style: TextStyle(color: primaryColor, fontSize: 22),
                        children: [
                          TextSpan(text: 'Thêm tài khoản', style:  TextStyle(
                              color: primaryColor, fontSize: textSize
                          ))
                        ]
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
