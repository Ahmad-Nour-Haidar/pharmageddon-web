import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/functions/functions.dart';
import 'custom_shimmer.dart';

class MedicationsLoading extends StatelessWidget {
  const MedicationsLoading({
    super.key,
    required this.onRefresh,
  });

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: [
          Wrap(
            spacing: 30,
            runSpacing: 20,
            children: List.generate(
              getRandom(),
              (index) => CustomShimmer(
                child: Container(
                  height: AppSize.widthMedicine + 30,
                  width: AppSize.widthMedicine,
                  decoration: BoxDecoration(
                    color: AppColor.cardColor,
                    borderRadius: BorderRadius.circular(AppSize.radius10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
