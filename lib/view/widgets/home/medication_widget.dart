import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/extensions/translate_numbers.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_padding.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/functions/functions.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../model/medication_model.dart';
import '../app_widget.dart';
import '../custom_cached_network_image.dart';

class MedicationWidget extends StatelessWidget {
  const MedicationWidget({
    super.key,
    required this.model,
    required this.onTapCard,
  });

  final MedicationModel model;
  final void Function(MedicationModel model) onTapCard;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapCard(model),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(AppSize.radius10),
        child: Container(
          padding: AppPadding.padding10,
          width: AppSize.widthMedicine,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(AppSize.radius10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(2),
                      bottomRight: Radius.circular(2),
                    ),
                    child: CustomCachedNetworkImage(
                      width: AppSize.widthMedicine,
                      height: AppSize.widthMedicine,
                      imageUrl: getUrlImageMedication(model),
                      errorWidget: ErrorWidgetShow.picture,
                    ),
                  ),
                  if (model.discount! > 0)
                    Positioned(
                      top: -20,
                      left: -20,
                      child: Transform.rotate(
                        angle: -pi / 4,
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.bottomCenter,
                          padding: AppPadding.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColor.red.withOpacity(.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FittedBox(
                            child: Text(
                              '${model.discount?.toInt()} %'.trn,
                              style: AppTextStyle.f20w600white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (isNew(model))
                    Positioned(
                      top: -20,
                      right: -20,
                      child: Transform.rotate(
                        angle: pi / 4,
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.bottomCenter,
                          padding: AppPadding.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColor.red.withOpacity(.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FittedBox(
                            child: Text(
                              AppText.newW.tr,
                              style: AppTextStyle.f20w600white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const Gap(10),
              AutoSizeText(
                getMCommercialName(model),
                style: AppTextStyle.f16w600black,
                maxLines: 1,
              ),
              const Gap(3),
              AutoSizeText(
                getManufacturerName(model.manufacturer),
                style: AppTextStyle.f15w400black,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MedicationsListWidget extends StatelessWidget {
  const MedicationsListWidget({
    super.key,
    required this.data,
    required this.onTapCard,
  });

  final List<MedicationModel> data;
  final void Function(MedicationModel model) onTapCard;

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? Center(child: AppInjection.getIt<AppWidget>().noData)
        : ListView(
            children: [
              Text(
                '${AppText.all.tr} : ( ${data.length} )'.trn,
                style: AppTextStyle.f18w500black,
              ),
              Wrap(
                spacing: 30,
                runSpacing: 20,
                children: List.generate(
                  data.length,
                  (index) => MedicationWidget(
                    model: data[index],
                    onTapCard: onTapCard,
                  ),
                ),
              ),
              const Gap(30),
            ],
          );
  }
}
