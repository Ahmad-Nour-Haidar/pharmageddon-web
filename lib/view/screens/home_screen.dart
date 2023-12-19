import 'package:flutter/material.dart';
import 'package:pharmageddon_web/core/constant/app_color.dart';

import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Row(
        children: [
          CustomDrawer(),
          Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
