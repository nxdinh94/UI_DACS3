import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class VndIcon extends StatelessWidget {
  const VndIcon({
    super.key,
    required this.color,
    required this.size
  });
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/dong-svg-repo.svg',
      width: size, height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
