import 'package:flutter/material.dart';
import 'package:practise_ui/widgets/back_toolbar_button.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../providers/app_provider.dart';
import '../../utils/custom_navigation_helper.dart';
import '../../widgets/rounded_checkbox_icon.dart';

class SelectAccountWalletTypePage extends StatefulWidget {
  const SelectAccountWalletTypePage({super.key, required this.accountWalletTypeData});
  final List<dynamic> accountWalletTypeData;

  @override
  State<SelectAccountWalletTypePage> createState() => _SelectAccountWalletTypePageState();
}

class _SelectAccountWalletTypePageState extends State<SelectAccountWalletTypePage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Chọn loại tài khoản',
          style: TextStyle(
              color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        leading: const BackToolbarButton()
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: ListView(
          children: widget.accountWalletTypeData.map((e){
            return Column(
              children: [
                ListTile(
                  onTap: (){
                    Map<String, dynamic> chosenCategory ={
                      'icon': e['icon'],
                      'name': e['name'],
                      '_id': e['_id'],
                    };
                    Navigator.pop(context, chosenCategory);
                  },
                  leading: Image.asset(e['icon'].toString(), width: 50, height: 50,),
                  title: Text(e['name'].toString(), style: const TextStyle(
                      color: textColor, fontSize: textSize
                  ),),
                  trailing: Visibility(
                      visible: e['isChosen'] == 0? false: true,
                      child:  const RoundedCheckboxIcon()
                  ),
                  contentPadding: const EdgeInsets.only(right: 18, left: 46 ),
                ),
                const Divider(color: underLineColor, height: 15,)
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
