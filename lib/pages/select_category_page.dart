import 'package:flutter/material.dart';
import 'package:practise_ui/widgets/rounded_checkbox_icon.dart';
import '../constant/color.dart';
import '../constant/font.dart';
import '../utils/custom_navigation_helper.dart';
class SelectCategoryPage extends StatefulWidget {
  const SelectCategoryPage({super.key});

  @override
  State<SelectCategoryPage> createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  String spendingMoneyIconPath = 'assets/icon_category/spending_money_icon/';
  TabBar get _tabBar => TabBar(
    indicatorColor: Colors.lightBlue.shade200,
    indicatorWeight: 3,
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: underLineColor,
    dividerHeight: 1,
    labelStyle: const TextStyle(
        fontSize: textSize, color: primaryColor
    ),
    unselectedLabelColor: textColor,
    tabs: const [
      Tab(child: Text('CHI TIỀN')),
      Tab(child: Text('THU TIỀN')),
      Tab(child: Text('VAY NỢ')),
    ],
  );


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(46),
              child: ColoredBox(
                color: Colors.grey.shade200,
                child: _tabBar
              )
            ),
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
          body: const TabBarView(
            children: [
              FirstTabView(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
class FirstTabView extends StatefulWidget {
  const FirstTabView({super.key});

  @override
  State<FirstTabView> createState() => _FirstTabViewState();
}

class _FirstTabViewState extends State<FirstTabView> {
  List data = [
    {
      'parentIcon' : <String, dynamic>{
        'iconPath': 'assets/icon_category/spending_money_icon/anUong/burger_parent.png',
        'title': 'Ăn uống',
        'isChosen': false,
        'isExpanded': true,
      },
      'subIcon' : [
        {
          'iconPath': 'assets/icon_category/spending_money_icon/anUong/breakfast.png',
          'title': 'Ăn sáng',
          'isChosen': false,
        },
        {
          'iconPath': 'assets/icon_category/spending_money_icon/anUong/coffee.png',
          'title': 'Cà phê',
          'isChosen': false,
        },
      ]
    },
    {
      'parentIcon' : <String, dynamic>{
        'iconPath': 'assets/icon_category/spending_money_icon/conCai/children-parent.png',
        'title': 'Con cái',
        'isChosen': true,
        'isExpanded': false,
      },
      'subIcon' : [
        {
          'iconPath': 'assets/icon_category/spending_money_icon/conCai/book.png',
          'title': 'Sách',
          'isChosen': false,
        },
        {
          'iconPath': 'assets/icon_category/spending_money_icon/conCai/milk.png',
          'title': 'Sữa',
          'isChosen': false,
        },
      ]
    },
    {
      'parentIcon' : <String, dynamic>{
        'iconPath': 'assets/icon_category/spending_money_icon/dichVuSinhHoat/clothes-rack-parent.png',
        'title': 'Dịch vụ sinh hoạt',
        'isChosen': true,
        'isExpanded': false,
      },
      'subIcon' : [
        {
          'iconPath': 'assets/icon_category/spending_money_icon/dichVuSinhHoat/electrical-energy.png',
          'title': 'Điện',
          'isChosen': false,
        },
        {
          'iconPath': 'assets/icon_category/spending_money_icon/dichVuSinhHoat/gas-cylinder.png',
          'title': 'Gas',
          'isChosen': false,
        },
      ]
    },
  ];
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
              data[index]['parentIcon']['isExpanded'] = !data[index]['parentIcon']['isExpanded'];
            });
        },
        children: data.map<ExpansionPanel>((e) {
            return ExpansionPanel(
              canTapOnHeader: false,
              // backgroundColor: Colors.green,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Column(
                  children: [
                    ListTile(
                      onTap: (){},
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
