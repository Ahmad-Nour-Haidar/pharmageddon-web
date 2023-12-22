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
import 'package:pharmageddon_web/view/widgets/svg_image.dart';

import '../../controllers/medication_details_cubit/medication_details_state.dart';
import '../../core/class/validation.dart';
import '../widgets/row_text_span.dart';
import '../widgets/text_input.dart';

class MedicationDetailsScreen extends StatelessWidget {
  const MedicationDetailsScreen({
    super.key,
    required this.medicationModel,
    required this.onTapClose,
  });

  final MedicationModel medicationModel;
  final void Function() onTapClose;

  @override
  Widget build(BuildContext context) {
    AppInjection.getIt<MedicationDetailsCubit>().initial(medicationModel);
    return BlocConsumer<MedicationDetailsCubit, MedicationDetailsState>(
      listener: (context, state) {
        if (state is MedicationDetailsFailureState) {
          handleState(state: state.state, context: context);
        }
      },
      builder: (context, state) {
        final cubit = MedicationDetailsCubit.get(context);
        return ListView(
          children: <Widget>[
            buildRowTop(cubit),
            image(cubit),
            const Gap(15),
            if (!cubit.enableEdit)
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
                      s2: cubit.model.id.toString(),
                    ),
                    const Gap(5),
                    RowTextSpan(
                      s1: '${AppText.scientificName.tr} : ',
                      s2: getMedicationScientificName(cubit.model),
                    ),
                    const Gap(5),
                    RowTextSpan(
                      s1: '${AppText.commercialName.tr} : ',
                      s2: getMCommercialName(cubit.model),
                    ),
                    const Gap(5),
                    RowTextSpan(
                      s1: '${AppText.manufacturer.tr} : ',
                      s2: getManufacturerName(cubit.model.manufacturer),
                    ),
                    const Gap(5),
                    RowTextSpan(
                      s1: '${AppText.effect.tr} : ',
                      s2: getEffectCategoryModelName(
                          cubit.model.effectCategory),
                    ),
                    const Gap(5),
                    RowTextSpan(
                      s1: '${AppText.description.tr} : ',
                      s2: getMedicationModelDescription(cubit.model).trn,
                    ),
                    const Gap(5),
                    RowTextSpan(
                      s1: '${AppText.availableQuantity.tr} : ',
                      s2: cubit.model.availableQuantity.toString().trn,
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
              ),
            if (cubit.enableEdit)
              Form(
                key: cubit.formKey,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    children: [
                      BuildRow(
                        widget1: TextInputField(
                          validator: (value) {
                            return ValidateInput.isEnglishText(value);
                          },
                          controller: cubit.scientificNameEnCon,
                          label: AppText.scientificNameEn.tr,
                        ),
                        widget2: TextInputField(
                          validator: (value) {
                            return ValidateInput.isArabicText(value);
                          },
                          controller: cubit.scientificNameArCon,
                          label: AppText.scientificNameAr.tr,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      const Gap(10),
                      BuildRow(
                        widget1: TextInputField(
                          validator: (value) {
                            return ValidateInput.isEnglishText(value);
                          },
                          controller: cubit.commercialNameEnCon,
                          label: AppText.commercialNameEn.tr,
                        ),
                        widget2: TextInputField(
                          validator: (value) {
                            return ValidateInput.isArabicText(value);
                          },
                          controller: cubit.commercialNameArCon,
                          label: AppText.commercialNameAr.tr,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      const Gap(10),
                      BuildRow(
                        widget1: TextInputField(
                          validator: (value) {
                            return ValidateInput.isEnglishText(value, max: 500);
                          },
                          controller: cubit.descEnCon,
                          label: AppText.description.tr,
                          maxLength: 500,
                          maxLines: 5,
                        ),
                        widget2: TextInputField(
                          validator: (value) {
                            return ValidateInput.isArabicText(value,max: 500);
                          },
                          controller: cubit.descArCon,
                          label: AppText.description.tr,
                          textDirection: TextDirection.rtl,
                          maxLength: 500,
                          maxLines: 5,
                        ),
                      ),
                      const Gap(10),
                      BuildRow(
                        widget1: TextInputField(
                          validator: (value) {
                            return ValidateInput.isPrice(value);
                          },
                          controller: cubit.priceCon,
                          label: AppText.price.tr,
                          maxLength: 16,
                          maxLines: 1,
                        ),
                        widget2: TextInputField(
                          validator: (value) {
                            return ValidateInput.isNumericWithoutDecimal(value);
                          },
                          controller: cubit.availableQuantityCon,
                          label: AppText.availableQuantity.tr,
                          textDirection: TextDirection.ltr,
                          maxLength: 16,
                          maxLines: 1,
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Row image(MedicationDetailsCubit cubit) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: cubit.enableEdit ? cubit.pickImage : null,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: cubit.imageShow != null
                  ? Image.memory(
                      cubit.imageShow!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    )
                  : CustomCachedNetworkImage(
                      width: double.infinity,
                      height: 200,
                      imageUrl: getUrlImageMedication(cubit.model),
                      errorWidget: ErrorWidgetShow.picture,
                    ),
            ),
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
              size: 30,
            )),
        const Spacer(),
        IconButton(
            onPressed: cubit.onTapEdit,
            icon: const SvgImage(
              path: AppSvg.edit,
              color: AppColor.contentColorBlue,
              size: 30,
            )),
      ],
    );
  }
}

class BuildRow extends StatelessWidget {
  const BuildRow({
    super.key,
    required this.widget1,
    required this.widget2,
  });

  final Widget widget1, widget2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: widget1,
          ),
        ),
        const Gap(10),
        Expanded(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: widget2,
          ),
        ),
      ],
    );
  }
}
