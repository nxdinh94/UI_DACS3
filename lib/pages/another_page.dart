import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: CircleAvatar(
            radius: 20,
            child: ClipOval(
              child: Image.asset('assets/beach and me.jpg'),
            ),
          ),
        ),
        title: GestureDetector(
          onTap: (){
            CustomNavigationHelper.router.push(
              '${CustomNavigationHelper.anotherPath}/${CustomNavigationHelper.accountSettingPath}'
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'nguyenxuandinh336live@gmail.com',
                style: const TextStyle(color: secondaryColor, fontSize: textBig, fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'nguyenxuandinh336live@gmail.com',
                style: const TextStyle(color: secondaryColor, fontSize: textSize),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        centerTitle: false,

        actions: <Widget>[
          Padding(
            padding: paddingAll12,
            child: GestureDetector(
              onTap: (){},
              child: SvgPicture.asset('assets/svg/bell.svg', width: 20,),
            ),
          )
        ],

      ),
    );
  }
}
