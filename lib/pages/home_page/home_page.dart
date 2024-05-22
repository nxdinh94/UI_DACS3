
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:practise_ui/Section/home_travel_section_item.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/constant/font.dart';
import 'package:practise_ui/constant/range_time_value.dart';
import 'package:practise_ui/constant/side.dart';
import 'package:practise_ui/models/cashs_flow_model.dart';
import 'package:practise_ui/providers/app_provider.dart';
import 'package:practise_ui/providers/auth_provider.dart';
import 'package:practise_ui/providers/chart_provider.dart';
import 'package:practise_ui/providers/user_provider.dart';
import 'package:practise_ui/utils/function/currency_format.dart';
import 'package:practise_ui/utils/custom_navigation_helper.dart';
import 'package:practise_ui/widgets/charts/pie_chart.dart';
import 'package:practise_ui/widgets/charts/collumn_chart.dart';
import 'package:practise_ui/widgets/charts/custom_legend_column_chart.dart';
import 'package:practise_ui/widgets/rich_text/right_arrow_rich_text.dart';
import 'package:practise_ui/widgets/rich_text/vnd_rich_text.dart';
import 'package:practise_ui/widgets/spendingLimit/spendingLimitItems.dart';
import 'package:practise_ui/widgets/vnd_icon.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../constant/share_prefercence_key.dart';
import '../../models/collum_chart_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    //get cashflowData from cache in homepage
    fetchDataCashFlow().whenComplete((){
      Provider.of<AppProvider>(context, listen: false).getAllCashFlowCache();
    });
    fetchDataCashFlowCate().whenComplete(() async {
      Provider.of<AppProvider>(context, listen: false).getAllCashFlowCateCache();

      //start all necessary provider
      Provider.of<AppProvider>(context, listen: false).getAccountWalletType();
      Provider.of<AppProvider>(context, listen:  false).getBank();
      Provider.of<UserProvider>(context, listen:  false).getAllAccountWallet();
      await Provider.of<ChartProvider>(context, listen:  false).getExpenseRecordForChartProvider();

    });
  }
  // if cache empty, fetch data api, then save to cache
  Future<void> fetchDataCashFlow() async {
    final List<CashFlowModel> data = await CashFlowModel.getCashFlow();
    if(data.isEmpty) {
      await Provider.of<AppProvider>(context, listen: false).saveCashFlowApi();
    } else {
      // print(data.length);
    }
  }
  Future<void> fetchDataCashFlowCate()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String dataFromCache = pref.getString(cashFlowCategoriesKey) ?? '';
    if(dataFromCache.isNotEmpty){
      return;
    }else {
      await Provider.of<AppProvider>(context, listen: false).saveCashFlowCateApi();
    }
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        color: backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: CustomMaterialIndicator(
                onRefresh: () async {
                  await Provider.of<ChartProvider>(context, listen: false).getExpenseRecordForChartProvider();
                  await Provider.of<AppProvider>(context, listen: false).getAccountWalletType();
                  await Provider.of<AppProvider>(context, listen:  false).getBank();
                  await Provider.of<UserProvider>(context, listen:  false).getAllAccountWallet();
                  await Provider.of<ChartProvider>(context, listen:  false).getExpenseRecordForChartProvider();
                  await Provider.of<UserProvider>(context, listen: false).getAllExpenseRecordForNoteHistoryProvider(rangeTimeData[0]['value']);
                },
                key: _refreshIndicatorKey,
                indicatorBuilder: (BuildContext context, IndicatorController controller) {
                  return LoadingAnimationWidget.hexagonDots(
                    color: primaryColor,
                    size: 30);
                  },
                child: ListView(
                  children: [
                    Container(
                      height: 169,
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
                                        color: secondaryColor,
                                        fontSize: textBig
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        // Provider.of<AuthProvider>(context, listen: false).logout();
                                        _refreshIndicatorKey.currentState?.show();
                                      },

                                      icon: const Icon(
                                        Icons.refresh, color: secondaryColor, size: 29,
                                      )
                                  ),
                                  IconButton(
                                      onPressed: ()async{
                                        },
                                      icon: const Icon(
                                        Icons.add_alert, color: secondaryColor, size: 26,
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
                                padding: paddingAll12,
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
                                          const RightArrowRichText(
                                            text: 'Total balance', fontSize: textSize, color: labelColor,
                                          ),
                                          Consumer<UserProvider>(
                                              builder: (context, value, child){
                                                List<dynamic> accountWalletList = value.accountWalletList;
                                                double totalMoney = 0;
                                                for(var item in accountWalletList){
                                                  totalMoney += double.parse(item['account_balance'][r'$numberDecimal']);
                                                }
                                                return VndRichText(
                                                  value: totalMoney,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 30, color: spendingMoneyColor, iconSize: 24,
                                                );
                                              }
                                          ),

                                        ],
                                      ),
                                      IconButton(
                                          onPressed: (){},
                                          icon: const Icon(
                                            Icons.remove_red_eye_sharp, size: 30, color: iconColor,
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
                                "Tình hình thu chi", style: textStyleForTitleSection
                              ),
                              IconButton(
                                onPressed: () {},
                                iconSize: 28, padding: EdgeInsets.zero, color: iconColor,
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
                              RichText(
                                text:  const TextSpan(
                                  text: 'Năm nay',
                                  style: labelTextStyle,
                                  children: [
                                    WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Icon(Icons.keyboard_arrow_right, size: 30, color: iconColor,)
                                    )
                                  ]
                                ))
                            ],
                          ),
                          //Row chart
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              CustomNavigationHelper.router.push(
                                '${CustomNavigationHelper.homePath}/${CustomNavigationHelper.detailSpendingRevenueStatisticalPath}'
                              );
                            },
                            child: Column(
                              children: [
                                Consumer<ChartProvider>(
                                  builder: (context, value, child)  {

                                    final List<CollumChartModel> dataColumnChart  = value.filteredColumnChartDataHomePage;

                                    if(value.isLoading){
                                      return SizedBox(
                                        height: 400,
                                        child: LoadingAnimationWidget.inkDrop(
                                          color: primaryColor,
                                          size: 80,
                                        ),
                                      );
                                    }
                                    return Visibility(
                                      visible: dataColumnChart.length>1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child:  MyColumnChart(
                                              data: value.filteredColumnChartDataHomePage,
                                            ),
                                          ),
                                          Consumer<ChartProvider>(
                                            builder: (context, value, child) {
                                              return Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  height: 250,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const CustomLegendColumnChart(color: chartCollumn1, text: "Thu"),
                                                          VndRichText(
                                                            value: value.totalRevenueMoney,
                                                            fontSize: 17, iconSize: textSmall,
                                                            color: chartCollumn1, fontWeight: FontWeight.bold,
                                                          )
                                                        ],
                                                      ),
                                                      spaceColumn,
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const CustomLegendColumnChart(color: chartCollumn2, text: "Chi"),
                                                          VndRichText(
                                                            value: value.totalSpendingMoney,
                                                            fontSize: 17, iconSize: textSmall,
                                                            color: chartCollumn2, fontWeight: FontWeight.bold,
                                                          )
                                                        ],
                                                      ),
                                                      spaceColumn,
                                                      const Divider(height: 1, color: underLineColor,),
                                                      spaceColumn,
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          VndRichText(
                                                            value: value.totalRevenueMoney-value.totalSpendingMoney,
                                                            fontSize: textBig, iconSize: textSize,
                                                            color: textColor, fontWeight: FontWeight.bold,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                spaceColumn,
                                Consumer<ChartProvider>(
                                  builder: (context, value, child){
                                    Map<String, double> data = value.filteredSpendingDataForPieChartHomePage;
                                    return Visibility(
                                      visible: data.isNotEmpty,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 22),
                                        child: MyPieChart(dataMap: data),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          spaceColumn,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap:()async{
                                  await Provider.of<UserProvider>(context, listen: false)
                                    .getAllExpenseRecordForNoteHistoryProvider(rangeTimeData[0]['value']);
                                  CustomNavigationHelper.router.push(
                                    '${CustomNavigationHelper.homePath}/${CustomNavigationHelper.noteHistoryPath}'
                                  );
                                },
                                child: const  RightArrowRichText(
                                  text: 'Lịch sử ghi chép',
                                  color: primaryColor,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    spaceColumn,
                    //spending limit
                    Container(
                      color: secondaryColor,
                      padding: paddingAll12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Hạn mức chi', style: textStyleForTitleSection),
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
                                RichText(
                                  text: const TextSpan(
                                      text: 'Xem thêm',
                                      style: TextStyle(fontSize: textSize, color: primaryColor),
                                      children: [
                                        WidgetSpan(
                                            child: Icon(Icons.keyboard_arrow_right, size: 30, color: primaryColor,),
                                            alignment: PlaceholderAlignment.middle,
                                        )
                                      ]
                                  ),
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
