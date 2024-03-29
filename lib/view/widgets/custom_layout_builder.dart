import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/constant/app_size.dart';

import '../../core/constant/app_text.dart';

class CustomLayoutBuilder extends StatelessWidget {
  const CustomLayoutBuilder({super.key, required this.widget});

  final Widget Function(double maxWidth, double maxHeight) widget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        AppSize.initial(context);
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;
        // printme.cyan(maxWidth);
        // printme.cyan(maxHeight);
        // return widget(maxWidth, maxHeight);
        if (maxHeight < 300) {
          return Scaffold(
            body: Center(
              child: Text(AppText.openInFullScreen.tr),
            ),
          );
        }
        return widget(maxWidth, maxHeight);
      },
    );
  }
}
