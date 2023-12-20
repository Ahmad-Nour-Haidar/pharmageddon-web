import 'package:flutter/material.dart';
import 'package:pharmageddon_web/core/constant/app_color.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
