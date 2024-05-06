import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/widgets/rounded_checkbox_icon.dart';
import '../constant/color.dart';
import '../constant/font.dart';
import '../data/tab_view_data.dart';
import '../utils/custom_navigation_helper.dart';
class SelectCategoryPage extends StatefulWidget {
  const SelectCategoryPage({super.key, required this.type});
  final String? type;

  @override
  State<SelectCategoryPage> createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  String spendingMoneyIconPath = 'assets/icon_category/spending_money_icon/';


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text(
              'Chọn hạng mục',
              style: TextStyle(
                  color: secondaryColor,fontSize: textBig, fontWeight: FontWeight.w500
              ),
            ),
            centerTitle: true,
            leading: Builder(
                builder: (BuildContext context){
                  return IconButton(
                    icon: const Icon(
                        Icons.keyboard_arrow_left, color: secondaryColor, size: 43
                    ),
                    onPressed: () {
                      CustomNavigationHelper.router.pop();
                    },
                );
              }
            ),
          ),
          body:  Builder(builder: (BuildContext context){
            if(widget.type!.toLowerCase().contains('chi')){
              return FirstTabView(firstTabViewData: firstTabViewData);
            }else if(widget.type!.toLowerCase().contains('thu')){
              return SecondTabView(data: secondTabViewData);
            }else {
              return SecondTabView(data: thirdTabViewData);
            }
          })
      );
  }
}
class FirstTabView extends StatefulWidget {
  const FirstTabView({super.key, required this.firstTabViewData});
  final List<Map<String, dynamic>> firstTabViewData;
  @override
  State<FirstTabView> createState() => _FirstTabViewState();
}

class _FirstTabViewState extends State<FirstTabView> {

  @override
  Widget build(BuildContext context) {
    const Divider divider =  Divider(color: underLineColor, height: 0, indent: 0, thickness: 1,);
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        elevation: 0,
        dividerColor: Colors.transparent,

        materialGapSize: 0,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              firstTabViewData[index]['parentIcon']['isExpanded'] = !firstTabViewData[index]['parentIcon']['isExpanded'];
            });
        },
        children: firstTabViewData.map<ExpansionPanel>((e) {
            return ExpansionPanel(
              canTapOnHeader: false,

              // backgroundColor: Colors.green,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Column(
                  children: [
                    ListTile(
                      onTap: (){

                      },
                      leading: Image.asset(
                          e['parentIcon']['iconPath'], width: 50, height: 50,
                      ),

                      title: Text(e['parentIcon']['title'], style: const TextStyle(
                        color: textColor, fontSize: textSize
                      ),),
                      trailing: Visibility(
                        visible: e['parentIcon']['isChosen'],
                        child: const RoundedCheckboxIcon(),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                    divider
                  ],
                );
              },
              body: Column(
                children: e['subIcon'].map<Widget>((subIcon) {
                  return Column(
                    children: [

                      ListTile(
                        leading: Image.asset(
                            subIcon['iconPath'], width: 50, height: 50,
                        ),
                        contentPadding: const EdgeInsets.only(left: 45, right: 18, top: 3, bottom: 3),
                        title: Text(subIcon['title'], style: const TextStyle(
                  color: textColor, fontSize: textSize
                  ),),
                        trailing: Visibility(
                          visible: subIcon['isChosen'],
                          child: const RoundedCheckboxIcon()
                        ),

                        onTap: () {},
                      ),
                      divider,
                    ]
                  );
                }).toList(),
              ),
              isExpanded: e['parentIcon']['isExpanded'],
            );
          },
        ).toList(),
      ),
    );
  }

}

class SecondTabView extends StatefulWidget {
  const SecondTabView({super.key, required this.data});

  final List<Map<String, dynamic>> data ;

  @override
  State<SecondTabView> createState() => _SecondTabViewState();
}

class _SecondTabViewState extends State<SecondTabView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView(
        children: widget.data.map((e){
          return Column(
            children: [
              ListTile(
                onTap: (){
                  Navigator.pop(context, e);
                },
                leading: Image.asset(e['iconPath'].toString(), width: 50, height: 50,),
                title: Text(e['title'].toString(), style: const TextStyle(
                  color: textColor, fontSize: textSize
                ),),
                trailing: Visibility(
                  visible: e['isChosen'] as bool,
                  child:  const RoundedCheckboxIcon()
                ),
                contentPadding: const EdgeInsets.only(right: 18, left: 46 ),
              ),
              const Divider(color: underLineColor, height: 15,)
            ],
          );
        }).toList(),
      ),
    );
  }
}
