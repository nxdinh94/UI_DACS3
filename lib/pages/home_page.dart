import 'package:flutter/material.dart';
import 'package:practise_ui/Section/home_travel_section_item.dart';
import 'package:practise_ui/constant/color.dart';
import 'package:practise_ui/widgets/pie_chart.dart';
import 'package:practise_ui/widgets/collumn_chart.dart';
import 'package:practise_ui/data/piechart_data.dart';
import 'package:practise_ui/widgets/custom_legend_column_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          //DASHBOARD

          //CHART
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  Container(
                    height: 170,
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
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
                                    onPressed: (){},
                                    icon: Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                      size: 29,
                                    )
                                ),
                                IconButton(
                                    onPressed: (){},
                                    icon: Icon(
                                      Icons.add_alert,
                                      color: Colors.white,
                                      size: 26,
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
                              padding: EdgeInsets.all(10),
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
                  const SizedBox(height: 10,),
                  // Tinh hinh thu chi
                  Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tình hình thu chi",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              iconSize: 28, // desired size
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
                  SizedBox(height: 12),
                  //Hạn mức chi
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.95,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 12),
                  //Du lịch
                  Container(
                    padding: EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width * 0.95,
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
