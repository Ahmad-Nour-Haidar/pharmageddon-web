import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmageddon_web/controllers/effect_category_cubit/effect_category_cubit.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_padding.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_svg.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../model/effect_category_model.dart';
import '../app_widget.dart';
import '../custom_cached_network_image.dart';
import '../svg_image.dart';

class EffectCategoryWidget extends StatelessWidget {
  const EffectCategoryWidget({
    super.key,
    required this.model,
  });

  final EffectCategoryModel model;

  @override
  Widget build(BuildContext context) {
    final isSelected =
        AppInjection.getIt<EffectCategoryCubit>().effectCategoryModel == model;
    return InkWell(
      onTap: () {
        AppInjection.getIt<EffectCategoryCubit>().showMedicinesOfModel(model);
      },
      child: Material(
        borderRadius: BorderRadius.circular(AppSize.radius10),
        elevation: 4,
        child: Container(
          padding: AppPadding.padding10,
          width: AppSize.widthEffect,
          height: AppSize.widthEffect + 60,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(AppSize.radius10),
            border: Border.all(
              color: isSelected ? AppColor.primaryColor : AppColor.white,
              width: 3,
            ),
          ),
          child: Column(
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
                  width: AppSize.widthEffect - 50,
                  height: AppSize.widthEffect - 50,
                  imageUrl: getEffectCategoryImage(model),
                  errorWidget: ErrorWidgetShow.picture,
                ),
              ),
              const Gap(5),
              const Divider(thickness: 2, color: AppColor.gray1),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        getEffectCategoryModelName(model),
                        style: AppTextStyle.f20w600black,
                        maxLines: 2,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        AppInjection.getIt<EffectCategoryCubit>()
                            .showDetailsModel(model);
                      },
                      icon: const SvgImage(
                        path: AppSvg.edit,
                        color: AppColor.blue,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EffectCategoriesListWidget extends StatelessWidget {
  const EffectCategoriesListWidget({
    super.key,
    required this.data,
  });

  final List<EffectCategoryModel> data;

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? AppInjection.getIt<AppWidget>().noData
        : ListView(
            children: [
              Wrap(
                spacing: 30,
                runSpacing: 20,
                children: List.generate(
                  data.length,
                  (index) => EffectCategoryWidget(
                    model: data[index],
                  ),
                ),
              ),
              const Gap(30),
            ],
          );
  }
}
