import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/controllers/medication_details_cubit/medication_details_cubit.dart';
import 'package:pharmageddon_web/core/constant/app_color.dart';
import 'package:pharmageddon_web/core/constant/app_padding.dart';
import 'package:pharmageddon_web/core/constant/app_svg.dart';
import 'package:pharmageddon_web/core/constant/app_text.dart';
import 'package:pharmageddon_web/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import 'package:pharmageddon_web/core/services/dependency_injection.dart';
import 'package:pharmageddon_web/model/medication_model.dart';
import 'package:pharmageddon_web/view/widgets/custom_cached_network_image.dart';
import 'package:pharmageddon_web/view/widgets/handle_state.dart';
import 'package:pharmageddon_web/view/widgets/medication_input_form.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';

import '../../controllers/medication_details_cubit/medication_details_state.dart';
import '../widgets/row_text_span.dart';

class MedicationDetailsScreen extends StatelessWidget {
  const MedicationDetailsScreen({
    super.key,
    required this.medicationModel,
    required this.onTapClose,
    required this.onSuccess,
    this.isShowDelete = true,
  });

  final MedicationModel medicationModel;
  final bool isShowDelete;
  final void Function() onTapClose;
  final void Function() onSuccess;

  @override
  Widget build(BuildContext context) {
    AppInjection.getIt<MedicationDetailsCubit>().initial(medicationModel);
    return BlocConsumer<MedicationDetailsCubit, MedicationDetailsState>(
      listener: (context, state) {
        if (state is MedicationDetailsFailureState) {
          handleState(state: state.state, context: context);
        }
        if (state is MedicationDetailsSuccessState) {
          onSuccess();
          handleState(state: state.state, context: context);
        }
      },
      builder: (context, state) {
        final cubit = MedicationDetailsCubit.get(context);
        return Column(
          children: <Widget>[
            buildRowTop(cubit),
            Expanded(
              child: cubit.enableEdit
                  ? MedicationInputForm(
                      medicationModel: cubit.model,
                      isLoading: state is MedicationDetailsLoadingState,
                      onTapButton: cubit.updateMedication,
                    )
                  : ListView(
                      children: [
                        image(getUrlImageMedication(cubit.model)),
                        const Gap(15),
                        Container(
                          padding: AppPadding.padding5,
                          decoration: BoxDecoration(
                            color: AppColor.gray2.withOpacity(.4),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RowTextSpan(
                                s1: '${AppText.id.tr} : # ',
                                s2: cubit.model.id.toString().trn,
                              ),
                              const Gap(5),
                              RowTextSpan(
                                s1: '${AppText.scientificName.tr} : ',
                                s2: getMedicationScientificName(cubit.model)
                                    .trn,
                              ),
                              const Gap(5),
                              RowTextSpan(
                                s1: '${AppText.commercialName.tr} : ',
                                s2: getMCommercialName(cubit.model).trn,
                              ),
                              const Gap(5),
                              RowTextSpan(
                                s1: '${AppText.manufacturer.tr} : ',
                                s2: getManufacturerName(
                                        cubit.model.manufacturer)
                                    .trn,
                              ),
                              const Gap(5),
                              RowTextSpan(
                                s1: '${AppText.effect.tr} : ',
                                s2: getEffectCategoryModelName(
                                        cubit.model.effectCategory)
                                    .trn,
                              ),
                              const Gap(5),
                              RowTextSpan(
                                s1: '${AppText.description.tr} : ',
                                s2: getMedicationModelDescription(cubit.model)
                                    .trn,
                              ),
                              const Gap(5),
                              RowTextSpan(
                                s1: '${AppText.availableQuantity.tr} : ',
                                s2: cubit.model.availableQuantity
                                    .toString()
                                    .trn,
                              ),
                              const Gap(5),
                              RowTextSpan(
                                s1: '${AppText.price.tr} : ',
                                s2: '${cubit.model.price} ${AppText.sp.tr}'.trn,
                              ),
                              if (cubit.model.discount! > 0) const Gap(5),
                              if (cubit.model.discount! > 0)
                                RowTextSpan(
                                  s1: '${AppText.discount.tr} : ',
                                  s2: '${cubit.model.discount} %'.trn,
                                ),
                              if (cubit.model.discount! > 0) const Gap(5),
                              if (cubit.model.discount! > 0)
                                RowTextSpan(
                                  s1: '${AppText.priceAfterDiscount.tr} : ',
                                  s2: '${cubit.model.priceAfterDiscount} ${AppText.sp.tr}'
                                      .trn,
                                ),
                              const Gap(5),
                              RowTextSpan(
                                s1: '${AppText.expirationDate.tr} : ',
                                s2: formatYYYYMd(cubit.model.expirationDate),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }

  Row image(String imageUrl) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 2,
          child: CustomCachedNetworkImage(
            width: double.infinity,
            height: 200,
            imageUrl: imageUrl,
            errorWidget: ErrorWidgetShow.picture,
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  Row buildRowTop(MedicationDetailsCubit cubit) {
    return Row(
      children: [
        IconButton(
            onPressed: onTapClose,
            icon: const SvgImage(
              path: AppSvg.close,
              color: AppColor.contentColorBlue,
              size: 26,
            )),
        const Spacer(),
        IconButton(
            onPressed: cubit.onTapEdit,
            icon: const SvgImage(
              path: AppSvg.edit,
              color: AppColor.contentColorBlue,
              size: 26,
            )),
      ],
    );
  }
}
