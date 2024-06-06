import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:provider/provider.dart';

void showDialogAskUserAccepPolicy(BuildContext context){
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6), // Background color
    barrierDismissible: false,
    barrierLabel: 'Dialog',
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, __, ___) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: sidePadding,
              child: Container(
                height: 430,
                width: MediaQuery.of(context).size.width,
                padding: paddingAll12,
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child:  Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Image.asset(
                          'assets/another_icon/security-shield.png',
                          width: 80
                        ),
                      )
                    ),
                    Padding(
                      padding: paddingAll12,
                      child: const Text(
                        'Xác nhận Chính sách quyền và riêng tư và Thỏa thuận sử dụng phần mềm',
                        style: TextStyle(
                          color: textColor,
                          fontSize: textBig, height: 1.2,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Theo quy định của pháp luật Việt Nam, MiSA bổ sung ',
                        style: defaultTextStyle,
                        children: [
                          TextSpan(
                            text: 'Chính sách quyền riêng tư ',
                            style: TextStyle(color: primaryColor, fontSize: textSize, fontWeight: FontWeight.w500)
                          ),
                          TextSpan(
                            text: 'và ',
                            style: defaultTextStyle
                          ),
                          TextSpan(
                            text: 'thỏa thuận sử dụng phần mềm ',
                            style: TextStyle(color: primaryColor, fontSize: textSize, fontWeight: FontWeight.w500)
                          ),
                          TextSpan(
                            text: 'Sổ thu chi MISA.'
                          ),
                        ]
                      ) ,
                      ),
                    Text(
                      'Bằng việc nhấn Xác nhận, quý khách đã đồng ý với các điều khoản của chúng tôi.',
                      style: TextStyle(
                        wordSpacing: -0.5,
                        fontSize: textSize, color: textColor, height: 1.2
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    spaceColumn,
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: paddingAll12,
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                        ),
                        onPressed: ()async{
                          Map<String, String> dataToUpdate = {
                            'agree_policy' : '1'
                          };
                          await Provider.of<UserProvider>(context, listen: false).updateMeProvider(dataToUpdate);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Xác nhận', style: TextStyle(color: secondaryColor, fontSize: textSize),
                        )
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}