import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../constant/side.dart';
Future<void> showLimitToAddDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Stack(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              padding: sidePadding,
              child: Column(
                children: [
                  Padding(
                    padding: paddingAll12,
                    child: Image.asset('assets/another_icon/hourglass.png', width: 100,),
                  ),
                  const Text('Bạn đã tạo hết số Hạn mức chi miễn phí',
                    style: TextStyle(fontSize: textBig, fontWeight: FontWeight.w700, color: textColor),
                    textAlign: TextAlign.center,
                  ),
                  const Text('Vui lòng nâng cấp tài khoản để sử dụng tính năng này.',
                    style: defaultTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: SizedBox(
                      width: 250,
                      height: 52,
                      child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange
                          ),
                          child: const Text(
                            'Nâng cấp Premium',
                            style: TextStyle(color: secondaryColor, fontSize: textSize, fontWeight: FontWeight.w600),
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 12,
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  'assets/svg/delete.svg',
                  colorFilter:const  ColorFilter.mode(iconColor, BlendMode.srcIn),
                  width: 20,height: 20,
                ),
              ),
            )
          ],
        ),
        actionsOverflowAlignment: OverflowBarAlignment.start,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: secondaryColor,
        elevation: 0,

      );
    },
  );
}
