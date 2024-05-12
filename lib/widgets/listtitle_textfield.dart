import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/color.dart';
import '../constant/font.dart';

class ListTitleTextField extends StatefulWidget {
  const ListTitleTextField({
    super.key,
    required this.leading,
    required this.hintText,
    required this.controller,
    this.horizontalTitleGap = 20,
    this.paddingLeftLeading = 24,
  });
  final Widget leading;
  final String hintText;
  final TextEditingController controller;
  final double horizontalTitleGap;
  final double paddingLeftLeading;
  @override
  State<ListTitleTextField> createState() => _ListTitleTextFieldState();
}

class _ListTitleTextFieldState extends State<ListTitleTextField> {

  bool isSufficIconVisible = false;

  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: widget.leading,
      horizontalTitleGap: widget.horizontalTitleGap,
      dense: true,
      contentPadding: EdgeInsets.only(left: widget.paddingLeftLeading,right: 18),
      title: TextField(
        controller: widget.controller,
        style: const TextStyle(color: textColor, fontSize: textSize,),
        onChanged: (value){
          setState(() {
            value.isNotEmpty ? isSufficIconVisible = true: isSufficIconVisible = false;
          });
        },
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle:const TextStyle(
              color: labelColor
          ),
          suffixIcon: Visibility(
            visible: isSufficIconVisible,
            child: GestureDetector(
              onTap: widget.controller.clear,
              child: SvgPicture.asset(
                'assets/svg/delete.svg',
                colorFilter:const  ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
          ),
          suffixIconConstraints: const BoxConstraints(
              minHeight: 15,
              minWidth: 15,
              maxHeight: 18,
              maxWidth: 18
          ),
        ),

      ),
    );
  }
}