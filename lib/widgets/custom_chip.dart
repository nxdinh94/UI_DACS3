import 'package:flutter/material.dart';

import '../constant/color.dart';
import '../constant/font.dart';
class CustomChip extends StatelessWidget {
  const CustomChip({super.key, required this.label, required this.callback});
  final String label;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return Chip(
      deleteIcon:  CircleAvatar(
          radius: 10,
          backgroundColor: Colors.grey.shade400,
          child: const Icon(Icons.close, size: 15, color: secondaryColor,)
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide.none),
      side: BorderSide.none,
      label: Text(label, style: const TextStyle(color: textColor, fontSize: textSize),),
      onDeleted: () {
        callback;
      },
    );
  }
}
