import 'package:flutter/material.dart';

import '../constant/color.dart';
import '../utils/custom_navigation_helper.dart';
class BackToolbarButton extends StatelessWidget {
  const BackToolbarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context){
          return IconButton(
            icon: const Icon(
                Icons.keyboard_arrow_left, color: secondaryColor, size: 43
            ),
            onPressed: () {
              CustomNavigationHelper.router.pop();
            },
          );
        }
    );
  }
}
