import 'package:flutter/material.dart';
class HomeTravelSectionItem extends StatefulWidget {
  const HomeTravelSectionItem({super.key});

  @override
  State<HomeTravelSectionItem> createState() => _HomeTravelSectionItemState();
}

class _HomeTravelSectionItemState extends State<HomeTravelSectionItem> {
  @override
  Widget build(BuildContext context) {
    return (
      Container(
        // color: Colors.blue,
        height: 100,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: CircleAvatar(),
            ),
            Expanded(
                child: Container(
                  // color: Colors.red,
                  padding: EdgeInsets.only(left: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Du lịch Mỹ"),
                          Text(
                            "9.993.999",
                            style: TextStyle(
                              color: Colors.green
                            ))
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "2024-04-04",
                          style: TextStyle(
                            color: Colors.grey.shade600
                          ),),
                          Text("0đ", style: TextStyle(
                                color: Colors.red
                            )),
                        ],
                      ),
                    ],
                  ),
                )
            )
            
          ],
        ),
      )
    );
  }
}
