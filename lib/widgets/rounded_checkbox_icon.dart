import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/color.dart';
class RoundedCheckboxIcon extends StatelessWidget {
  const RoundedCheckboxIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: Colors.green,
      child: SvgPicture.asset(
        'assets/svg/tick.svg', width: 20,
        colorFilter: const ColorFilter.mode(secondaryColor, BlendMode.srcIn),),
    );
  }
}
