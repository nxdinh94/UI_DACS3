import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../providers/app_provider.dart';
import '../../utils/custom_navigation_helper.dart';
import '../../widgets/back_toolbar_button.dart';
class SelectBankPage extends StatefulWidget {
  const SelectBankPage({super.key});

  @override
  State<SelectBankPage> createState() => _SelectBankPageState();
}

class _SelectBankPageState extends State<SelectBankPage> {
  
  List<dynamic> bankDataApi = [];
  
  @override
  void initState() {
    bankDataApi = context.read<AppProvider>().bank;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Ngân hàng',
          style: TextStyle(
              color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        leading: const BackToolbarButton(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: ListView(
          children: bankDataApi.map((e) => ListTile(
            onTap: (){
              Map<String, dynamic> result = {
                'logo' : e['logo'],
                'shortName' : e['shortName'],
                'id' : e['id'],
              };
              Navigator.pop(context, result);
            },
            leading: Image.network(e['logo'], width: 100, height: 80,),
            title: Text(e['shortName'], style: const TextStyle(color: textColor, fontSize: textBig, fontWeight: FontWeight.w600),),
            subtitle: Text(e['name'], style: const TextStyle(color: textColor, fontSize: textSmall),),
          )).toList(),
        ),
      ),
    );
  }
}
