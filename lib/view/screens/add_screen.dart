import 'package:flutter/material.dart';
import 'package:pharmageddon_web/core/constant/app_padding.dart';
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
        MedicationInputForm(
          physics: const NeverScrollableScrollPhysics(),
          onTapButton: (data, file) {},
          isLoading: false,
        ),
        Row(
          children: [
            Expanded(
              child: EffectCategoryInputForm(
                onTapButton: (data, file) {},
                isLoading: false,
              ),
            ),
            Expanded(
              child: ManufacturerInputForm(
                onTapButton: (data) {},
                isLoading: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
