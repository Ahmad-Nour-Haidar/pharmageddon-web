import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/functions/functions.dart';
import 'custom_shimmer.dart';

class EffectCategoryLoading extends StatelessWidget {
  const EffectCategoryLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Wrap(
          spacing: 30,
          runSpacing: 20,
          children: List.generate(
            getRandom(),
            (index) => CustomShimmer(
              child: Container(
                width: AppSize.widthEffect,
                height: AppSize.widthEffect + 60,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(AppSize.radius10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
