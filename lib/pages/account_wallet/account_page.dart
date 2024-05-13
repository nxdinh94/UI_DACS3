import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/app_provider.dart';
import 'package:practise_ui/services/app_services.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../utils/custom_navigation_helper.dart';
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    Provider.of<AppProvider>(context, listen: false).getAccountWalletType();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Tài khoản',
          style: TextStyle(
              color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: SvgPicture.asset(
                  'assets/svg/magnifying-glass.svg',
                  height: 22, width: 22,
                ),
                onPressed: () async {
                },

              );
            }
        ),
      ),
      body: const NoAccountCase(),
    );
  }
}
class HaveAccountCase extends StatefulWidget {
  const HaveAccountCase({super.key});

  @override
  State<HaveAccountCase> createState() => _HaveAccountCaseState();
}

class _HaveAccountCaseState extends State<HaveAccountCase> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class NoAccountCase extends StatelessWidget {
  const NoAccountCase({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Image.asset('assets/another_icon/grey-coin.png', width: 100,),
            spaceColumn,
            const Text('Bạn chưa có tài khoản nào',style: TextStyle(
              color: labelColor, fontSize: textSize
            )),
            spaceColumn6,
            GestureDetector(
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
            )
          ],
        ),
      ),
    );
  }
}
