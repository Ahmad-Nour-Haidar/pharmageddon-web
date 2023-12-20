import 'package:flutter/material.dart';
import 'package:pharmageddon_web/core/constant/app_color.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  BorderRadius get borderRadius {
    if (isEnglish()) {
      return const BorderRadius.only(
        topLeft: Radius.circular(25),
        bottomLeft: Radius.circular(25),
      );
    }
    return const BorderRadius.only(
      topRight: Radius.circular(25),
      bottomRight: Radius.circular(25),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.contentColorBlue,
      body: Row(
        children: [
          CustomDrawer(
            onTap: (_) {},
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: borderRadius,
              ),
              child: const Column(children: [
                CustomAppBar(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
