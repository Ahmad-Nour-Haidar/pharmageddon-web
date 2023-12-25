import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pharmageddon_web/controllers/effect_category_cubit/effect_category_cubit.dart';
import 'package:pharmageddon_web/controllers/effect_category_cubit/effect_category_state.dart';
import 'package:pharmageddon_web/view/widgets/build_row_edit_close.dart';
import 'package:pharmageddon_web/view/widgets/effect_category/effect_category_input_form.dart';
import 'package:pharmageddon_web/view/widgets/effect_category/effect_category_widget.dart';
import 'package:pharmageddon_web/view/widgets/handle_state.dart';
import 'package:pharmageddon_web/view/widgets/loading/effect_category_loading.dart';

import '../../core/constant/app_color.dart';
import 'medication_screen.dart';

class EffectCategoryScreen extends StatelessWidget {
  const EffectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = EffectCategoryCubit.get(context);
    cubit.initial();
    return BlocConsumer<EffectCategoryCubit, EffectCategoryState>(
      listener: (context, state) {
        if (state is EffectCategoryFailureState) {
          handleState(state: state.state, context: context);
        } else if (state is EffectCategoryEditSuccessState) {
          handleState(state: state.state, context: context);
        }
      },
      builder: (context, state) {
        Widget body = EffectCategoriesListWidget(
          data: cubit.data,
        );
        if (state is EffectCategoryLoadingState) {
          body = const EffectCategoryLoading();
        }
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (cubit.showDetailsEffectCategoryModel)
                    Expanded(
                      child: SizedBox(
                        width: 500,
                        child: Column(
                          children: [
                            BuildRowEditClose(
                              onTapClose: cubit.closeDetailsModel,
                              showEdit: false,
                            ),
                            Expanded(
                              child: EffectCategoryInputForm(
                                effectCategoryModel: cubit.effectCategoryModel,
                                onTapButton: cubit.updateEffectCategory,
                                isLoading:
                                    state is EffectCategoryEditLoadingState,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  const Gap(10),
                  Expanded(child: body),
                ],
              ),
            ),
            if (cubit.showMedicinesEffectCategoryModel)
              const VerticalDivider(color: AppColor.gray1),
            if (cubit.showMedicinesEffectCategoryModel)
              Expanded(
                flex: 2,
                child: MedicationScreen(url: cubit.getUrlMedicinesModel),
              ),
          ],
        );
      },
    );
  }
}
