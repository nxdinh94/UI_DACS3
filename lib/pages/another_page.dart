import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child){
      Map<String, dynamic> meData = value.meData;
      return Scaffold(
            appBar: AppBar(
              toolbarHeight: 90,
              backgroundColor: primaryColor,
              leading: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: CircleAvatar(
                  radius: 20,
                  child: ClipOval(
                    child:  Image.asset(meData['avatar'] ==''? 'assets/another_icon/avt-fb.jpg': 'assets/beach and me.jpg'),
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
                      meData['name'] ?? 'Anonymous',
                      style: const TextStyle(color: secondaryColor, fontSize: textBig, fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      meData['email'],
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
    );
  }
}
