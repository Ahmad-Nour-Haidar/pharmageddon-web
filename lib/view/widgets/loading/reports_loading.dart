import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_padding.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/functions/functions.dart';
import 'custom_shimmer.dart';

class OrdersLoading extends StatelessWidget {
  const OrdersLoading({
    super.key,
  });

  double get width => Random().nextInt(150) + 100.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Wrap(
          spacing: 30,
          runSpacing: 20,
          children: List.generate(
            getRandom(),
            (index) => Container(
              width: 250,
              padding: AppPadding.padding10,
              decoration: BoxDecoration(
                color: AppColor.gray3,
                borderRadius: BorderRadius.circular(AppSize.radius10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  6,
                  (index) => CustomShimmer(
                    baseColor: AppColor.background,
                    child: Container(
                      margin: AppPadding.padding5,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: width.toInt().toDouble(),
                      height: 12,
                      child: const Text(''),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(30),
      ],
    );
  }
}
