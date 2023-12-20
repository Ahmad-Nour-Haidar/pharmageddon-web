import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/controllers/local_controller.dart';
import 'package:pharmageddon_web/core/constant/app_color.dart';
import 'package:pharmageddon_web/core/constant/app_constant.dart';
import 'package:pharmageddon_web/core/constant/app_local_data.dart';
import 'package:pharmageddon_web/core/constant/app_size.dart';
import 'package:pharmageddon_web/core/constant/app_svg.dart';
import 'package:pharmageddon_web/core/constant/app_text.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import 'package:pharmageddon_web/core/resources/app_text_theme.dart';
import 'package:pharmageddon_web/core/services/dependency_injection.dart';
import 'package:pharmageddon_web/view/widgets/custom_cached_network_image.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/drawer.dart';
import '../widgets/svg_image.dart';

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
              child: Column(children: [
                CustomAppBar(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
