import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/constant/app_padding.dart';
import 'package:pharmageddon_web/core/constant/app_text.dart';
import 'package:pharmageddon_web/core/resources/app_text_theme.dart';
import 'package:pharmageddon_web/view/widgets/effect_category/effect_category_input_form.dart';
import 'package:pharmageddon_web/view/widgets/manufacturer/manufacturer_input_form.dart';
import 'package:pharmageddon_web/view/widgets/medication/medication_input_form.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppPadding.zero,
      children: [
        Text(AppText.addMedication.tr, style: AppTextStyle.f18w500green3),
        MedicationInputForm(
          physics: const NeverScrollableScrollPhysics(),
          onTapButton: (data, file) {},
          isLoading: false,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppText.addEffectCategory.tr,
                    style: AppTextStyle.f18w500green3,
                  ),
                  const Gap(5),
                  EffectCategoryInputForm(
                    onTapButton: (data, file) {},
                    isLoading: false,
                  ),
                ],
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppText.addManufacturer.tr,
                    style: AppTextStyle.f18w500green3,
                  ),
                  const Gap(5),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: ManufacturerInputForm(
                      onTapButton: (data) {},
                      isLoading: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
