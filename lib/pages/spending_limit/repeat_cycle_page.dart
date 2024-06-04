import 'package:flutter/material.dart';
import 'package:practise_ui/constant/divider.dart';
import 'package:provider/provider.dart';
import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../providers/app_provider.dart';
import '../../widgets/back_toolbar_button.dart';
class RepeatCyclePage extends StatefulWidget {
  const RepeatCyclePage({super.key});

  @override
  State<RepeatCyclePage> createState() => _RepeatCyclePageState();
}

class _RepeatCyclePageState extends State<RepeatCyclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Lặp lại',
          style: TextStyle(
              color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        leading: const BackToolbarButton(),
      ),
      body: Container(
        color: backgroundColor,
        child: Consumer<AppProvider>(
          builder: (context, value, child) {
            List<dynamic> repeatTime = value.repeatTimeSpendingLimit;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ColoredBox(
                  color: secondaryColor,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: (){
                          Navigator.pop(context, repeatTime[index]);
                        },
                        title: Text(repeatTime[index]['name']),
                        titleTextStyle: defaultTextStyle,
                      ),
                      defaultDivider
                    ],
                  ),
                );
              },
              itemCount: repeatTime.length,
            );
          },
        ),
      ),
    );
  }
}
