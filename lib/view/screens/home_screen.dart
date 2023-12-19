import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/constant/app_color.dart';

import '../../core/constant/app_svg.dart';
import '../../core/constant/app_text.dart';
import '../widgets/drawer.dart';
import '../widgets/svg_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Row(
        children: [
          CustomDrawer(),
          Expanded(child: SizedBox(),),
        ],
      ),
    );
  }
}
