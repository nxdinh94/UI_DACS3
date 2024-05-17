import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/providers/app_provider.dart';
import 'package:practise_ui/widgets/rounded_checkbox_icon.dart';
import 'package:provider/provider.dart';
import '../../constant/color.dart';
import '../../constant/font.dart';
import '../../utils/custom_navigation_helper.dart';
import '../../widgets/back_toolbar_button.dart';
class SelectCategoryPage extends StatefulWidget {
  const SelectCategoryPage({super.key, required this.cashFlowType});
  final String cashFlowType;
  @override
  State<SelectCategoryPage> createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  String spendingMoneyIconPath = 'assets/icon_category/spending_money_icon/';

  @override
  void initState() {
    // print('seage');
    // print(cashFlowCateData);
    super.initState();
  }

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
            leading: const BackToolbarButton(),
          ),
          body:  Consumer<AppProvider>(
            builder: (context, value, child) {
              Map<String, dynamic> cashFlowCateData = value.cashFlowCateData;
              if(cashFlowCateData.isNotEmpty){
                if(widget.cashFlowType.toLowerCase().contains('chi')){
                  return MyExpansionPanelList(data: cashFlowCateData['spending_money']);
                }else if(widget.cashFlowType.toLowerCase().contains('thu')){
                  return ChooseListView(data: cashFlowCateData['revenue_money'],);
                }else{
                  return ChooseListView(data: cashFlowCateData['loan_money'],);
                }
              }else{
                return Container();
              }
            },
          )
      );
  }
}
class MyExpansionPanelList extends StatefulWidget {
  const MyExpansionPanelList({super.key, required this.data,});
  final List<dynamic> data;
  @override
  State<MyExpansionPanelList> createState() => _MyExpansionPanelListState();
}

class _MyExpansionPanelListState extends State<MyExpansionPanelList> {

  @override
  void initState() {
    super.initState();
  }

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
            if(widget.data[index]['parent_category']['isExpanded'] == 0){
              widget.data[index]['parent_category']['isExpanded']  = 1;
            }else {
              widget.data[index]['parent_category']['isExpanded']  = 0;
            }
          });
        },
        children: widget.data.map<ExpansionPanel>((e) {
          return ExpansionPanel(
            canTapOnHeader: false,
            // backgroundColor: Colors.green,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Column(
                children: [
                  ListTile(
                    onTap: (){
                      Map<String, dynamic> chosenCategory ={
                        'icon': e['parent_category']['icon'],
                        'name': e['parent_category']['name'],
                        '_id': e['parent_category']['_id'],
                        'cash_flow_id': e['parent_category']['cash_flow_id'],
                      };
                      Navigator.pop(context, chosenCategory);
                    },
                    leading: Image.asset(
                      e['parent_category']['icon'], width: 50, height: 50,
                    ),

                    title: Text(e['parent_category']['name'], style: const TextStyle(
                        color: textColor, fontSize: textSize
                    ),),
                    trailing: Visibility(
                      visible: e['parent_category']['isChosen'] == 0? false : true,
                      child: const RoundedCheckboxIcon(),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                  divider
                ],
              );
            },
            body: Column(
              children: e['sub_category'].map<Widget>((subIcon) {
                return Column(
                    children: [
                      ListTile(
                        leading: Image.asset(
                          subIcon['icon'], width: 50, height: 50,
                        ),
                        contentPadding: const EdgeInsets.only(left: 45, right: 18, top: 3, bottom: 3),
                        title: Text(subIcon['name'], style: const TextStyle(
                            color: textColor, fontSize: textSize
                        ),),
                        trailing: Visibility(
                            visible: subIcon['isChosen'] == 0 ? false: true,
                            child: const RoundedCheckboxIcon()
                        ),

                        onTap: () {
                          Map<String, dynamic> chosenCategory ={
                            'icon': subIcon['icon'],
                            'name': subIcon['name'],
                            '_id': subIcon['_id'],
                            'cash_flow_id': subIcon['cash_flow_id'],
                          };
                          Navigator.pop(context, chosenCategory);
                        },
                      ),
                      divider,
                    ]
                );
              }).toList(),
            ),
            // isExpanded: true
            isExpanded: e['parent_category']['isExpanded'] == 0 ? false : true,
          );
        },
        ).toList(),
      ),
    );
  }

}

class ChooseListView extends StatefulWidget {

  const ChooseListView({Key? key, required this.data}) : super(key: key);
  final List<dynamic> data;


  @override
  State<ChooseListView> createState() => _ChooseListViewState();
}

class _ChooseListViewState extends State<ChooseListView> {


  @override
  void initState() {
    // print(widget.data.runtimeType);
    super.initState();
  }
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
                  Map<String, dynamic> chosenCategory ={
                    'icon': e['parent_category']['icon'],
                    'name': e['parent_category']['name'],
                    '_id': e['parent_category']['_id'],
                    'cash_flow_id': e['parent_category']['cash_flow_id'],
                  };
                  Navigator.pop(context, chosenCategory);
                },
                leading: Image.asset(e['parent_category']['icon'].toString(), width: 50, height: 50,),
                title: Text(e['parent_category']['name'].toString(), style: const TextStyle(
                    color: textColor, fontSize: textSize
                ),),
                trailing: Visibility(
                    visible: e['parent_category']['isChosen'] == 0? false: true,
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
