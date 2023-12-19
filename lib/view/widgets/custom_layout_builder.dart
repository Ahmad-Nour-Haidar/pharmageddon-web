import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/constant/app_size.dart';
import 'package:pharmageddon_web/core/constant/app_text.dart';

class CustomLayoutBuilder extends StatelessWidget {
  const CustomLayoutBuilder({super.key, required this.widget});

  final Widget Function(double maxWidth, double maxHeight) widget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        AppSize.initial(context);
        // printme.yellow(MediaQuery.sizeOf(context));
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;
        if (maxWidth < 1000 || maxHeight < 600) {
          return Scaffold(
            body: Center(
              child: SelectableText(AppText.openInFullScreen.tr),
            ),
          );
        }
        return widget(maxWidth, maxHeight);
      },
    );
  }
}
