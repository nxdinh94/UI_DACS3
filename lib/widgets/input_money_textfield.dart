import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/color.dart';
import '../constant/font.dart';
import '../constant/side.dart';

class InputMoneyTextField extends StatefulWidget {

  const InputMoneyTextField({super.key, required this.controller, required this.title});
  final TextEditingController controller;
  final String title;
  @override
  State<InputMoneyTextField> createState() => InputMoneyTextFieldState();
}

class InputMoneyTextFieldState extends State<InputMoneyTextField> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    const Divider divider = Divider(height: 1, color: underLineColor,indent: 64);
    return Container(
      height: 110,
      color: secondaryColor,
      padding: paddingAll12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(widget.title, style: const TextStyle(
              fontSize: textSmall,
              color: textColor
          )),
          spaceColumn6,
          TextField(
            controller: widget.controller,
            style: const TextStyle(fontSize: 35.0, height: 45/35,fontWeight: FontWeight.w500, color: revenueMoneyColor),
            textAlign: TextAlign.end,
            cursorColor: Colors.deepPurpleAccent,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                suffixIcon: SvgPicture.asset(
                  'assets/svg/dong.svg',
                  colorFilter: const  ColorFilter.mode(textColor, BlendMode.srcIn),
                ),
                suffixIconConstraints: const BoxConstraints(
                    minHeight: 32,
                    minWidth: 32
                ),
                hintText: '0',
                hintStyle: const TextStyle(fontSize: 35, color: revenueMoneyColor)
            ),
          ),
          spaceColumn6,
          divider
        ],
      ),
    );
  }
}