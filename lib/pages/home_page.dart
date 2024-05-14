import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practise_ui/Section/home_travel_section_item.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/models/cashs_flow_model.dart';
import 'package:practise_ui/providers/app_provider.dart';
import 'package:practise_ui/providers/auth_provider.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/services/app_services.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/widgets/charts/pie_chart.dart';
import 'package:practise_ui/widgets/charts/collumn_chart.dart';
import 'package:practise_ui/data/piechart_data.dart';
import 'package:practise_ui/widgets/charts/custom_legend_column_chart.dart';
import 'package:practise_ui/widgets/spendingLimit/spendingLimitItems.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/share_prefercence_key.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    //get cashflowData from cache in homepage
    fetchDataCashFlow().whenComplete((){
      Provider.of<AppProvider>(context, listen: false).getAllCashFlowCache();
    });
    fetchDataCashFlowCate().whenComplete((){
      Provider.of<AppProvider>(context, listen: false).getAllCashFlowCateCache();

      //start all necessary provider
      Provider.of<AppProvider>(context, listen: false).getAccountWalletType();
      Provider.of<AppProvider>(context, listen:  false).getBank();
    });
  }
  // if cache empty, fetch data api, then save to cache
  Future<void> fetchDataCashFlow() async {
    final List<CashFlowModel> data = await CashFlowModel.getCashFlow();
    if(data.isEmpty) {
      Provider.of<AppProvider>(context, listen: false).saveCashFlowApi();
    } else {
      print(data.length);
    }
  }
  Future<void> fetchDataCashFlowCate()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String dataFromCache = pref.getString(cashFlowCategoriesKey) ?? '';
    if(dataFromCache.isNotEmpty){
      return;
    }else {
      Provider.of<AppProvider>(context, listen: false).saveCashFlowCateApi();
    }
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        color: backgroundColor,
        child: Column(
          children: [
            //CHART
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    Container(
                      height: 170,
                      width: double.infinity,
                      padding: paddingAll12,
                      decoration: const BoxDecoration(
                          color: primaryColor
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Hello nguyenxuandinh336live!',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        Provider.of<AuthProvider>(context, listen: false).logout();
                                      },
                                      icon: const Icon(
                                        Icons.refresh, color: Colors.white, size: 29,
                                      )
                                  ),
                                  IconButton(
                                      onPressed: ()async{
                                      },
                                      icon: const Icon(
                                        Icons.add_alert, color: Colors.white, size: 26,
                                      )
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){},
                              child: Container(
                                width: double.infinity,
                                padding:const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total balance >',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey.shade500
                                            ),
                                          ),
                                          Text(
                                            '-2.120.016đ',
                                            style: TextStyle(
                                                fontSize: 29,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red.shade400
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: (){},
                                          icon: Icon(
                                            Icons.remove_red_eye_sharp,
                                            size: 30,
                                            color: Colors.grey.shade400,
                                          )
                                      )
                                    ]
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    spaceColumn,
                    // Tinh hinh thu chi
                    Container(
                      padding: paddingAll12,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Tình hình thu chi",
                                style: textStyleForTitleSection
                              ),
                              IconButton(
                                onPressed: () {},
                                iconSize: 28,
                                padding: EdgeInsets.zero,
                                color: Colors.grey,
                                constraints: const BoxConstraints(), // override default min size of 48px
                                style: const ButtonStyle(
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
                                ),
                                icon: const Icon(Icons.settings),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Năm nay >",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                  height: 1.2,
                                ),
                              )
                            ],
                          ),
                          //Row chart
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child:  MyColumnChart(),
                                flex: 1,
                              ),
                              Expanded(
                                child: Container(
                                  // color: Colors.grey.shade300,
                                  height: 250,

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomLegendColumnChart(color: chartCollumn1, text: "Thu"),
                                          Text(
                                            "9.999.999đ",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: chartCollumn1,
                                                fontWeight: FontWeight.bold
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomLegendColumnChart(color: chartCollumn2, text: "Chi"),
                                          Text(
                                            "9.999.999đ",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: chartCollumn2,
                                                fontWeight: FontWeight.bold
                                            ),)
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Divider(height: 1, color: Colors.grey.shade300,),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("18.454.423",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold
                                            ),)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                flex: 1,
                              )
                            ],
                          ),
                          MyPieChart(dataMap: dataMap),
                        ],
                      ),
                    ),
                    spaceColumn,
                    //spending limit
                    Container(

                      width: double.infinity,
                      color: secondaryColor,
                      padding: paddingAll12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hạn mức chi', style: textStyleForTitleSection),
                          spaceColumn,
                          SpendingLimitItems(),
                          spaceColumn,
                          GestureDetector(
                            onTap: (){
                              CustomNavigationHelper.router.push(
                                CustomNavigationHelper.listSpendingLimitItemPath
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Xem thêm', style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 17
                                ),),
                                const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: primaryColor,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    spaceColumn,
                    //Du lịch
                    Container(
                      padding: paddingAll12,
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Du lịch", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                          HomeTravelSectionItem(),
                          HomeTravelSectionItem(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  "Xem thêm >",
                                  style: TextStyle(
                                      color: Colors.blue
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
  }
}
