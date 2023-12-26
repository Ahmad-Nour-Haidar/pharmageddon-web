import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/controllers/add_cubit/add_cubit.dart';
import 'package:pharmageddon_web/controllers/add_cubit/add_state.dart';
import 'package:pharmageddon_web/core/constant/app_color.dart';
import 'package:pharmageddon_web/core/constant/app_padding.dart';
import 'package:pharmageddon_web/core/constant/app_svg.dart';
import 'package:pharmageddon_web/core/constant/app_text.dart';
import 'package:pharmageddon_web/core/resources/app_text_theme.dart';
import 'package:pharmageddon_web/view/widgets/effect_category/effect_category_input_form.dart';
import 'package:pharmageddon_web/view/widgets/handle_state.dart';
import 'package:pharmageddon_web/view/widgets/manufacturer/manufacturer_input_form.dart';
import 'package:pharmageddon_web/view/widgets/medication/medication_input_form.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AddCubit.get(context);
    cubit.initial();
    return BlocConsumer<AddCubit, AddState>(
      listener: (context, state) {
        if (state is AddFailureState) {
          handleState(state: state.state, context: context);
        }
        if (state is AddSuccessState) {
          handleState(state: state.state, context: context);
        }
      },
      builder: (context, state) {
        return ListView(
          padding: AppPadding.zero,
          children: [
            Text(
              AppText.addMedication.tr,
              style: AppTextStyle.f18w600blue,
            ),
            MedicationInputForm(
              physics: const NeverScrollableScrollPhysics(),
              onTapButton: cubit.createMedication,
              isLoading: state is AddAddMedicationLoadingState,
              chooseEffectCategory: true,
              chooseManufacturer: true,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.addEffectCategory.tr,
                        style: AppTextStyle.f18w600blue,
                      ),
                      const Gap(5),
                      EffectCategoryInputForm(
                        onTapButton: cubit.createEffectCategory,
                        isLoading: state is AddEffectCategoryLoadingState,
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
                        style: AppTextStyle.f18w600blue,
                      ),
                      const Gap(5),
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColor.gray4,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const SvgImage(
                            path: AppSvg.apartment,
                            color: AppColor.white,
                            size: 50,
                          ),
                        ),
                      ),
                      ManufacturerInputForm(
                        onTapButton: cubit.createManufacturer,
                        isLoading: state is AddManufacturerLoadingState,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
