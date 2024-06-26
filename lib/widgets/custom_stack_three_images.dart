import 'package:flutter/material.dart';

import '../constant/color.dart';
class StackThreeCircleImages extends StatelessWidget {
  final String imageOne, imageTwo, imageThree;
  const StackThreeCircleImages({
    super.key, required this.imageOne, required this.imageTwo, required this.imageThree,
  });

  @override
  Widget build(BuildContext context) {
    final BoxDecoration myBoxdecoration = BoxDecoration(
      border: Border.all(width: 3, color: secondaryColor),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    );
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: Stack(
        children: [
          Positioned(
            left: 29,
            bottom: 3,
            child: CircleAvatar(
              radius: 20,
              child: ClipOval(
                child: Image.asset(
                  imageOne,width: 100,height: 100,fit: BoxFit.cover
                ),
              ),
            ),
          ),
          Positioned(
            left: 13,
            child: Container(
              decoration: myBoxdecoration,
              child: CircleAvatar(
                radius: 20,
                child: ClipOval(
                  child: Image.asset(imageTwo,width: 100, height: 100,fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Container(
            decoration: myBoxdecoration,
            child: CircleAvatar(
              radius: 20,
              child: ClipOval(
                child: Image.asset(
                  imageThree,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}