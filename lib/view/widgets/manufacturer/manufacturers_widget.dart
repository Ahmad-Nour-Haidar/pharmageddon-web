import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pharmageddon_web/controllers/manufacturer_cubit/manufacturer_cubit.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../model/manufacturer_model.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_padding.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_svg.dart';
import '../../../core/functions/functions.dart';
import '../../../core/resources/app_text_theme.dart';
import '../app_widget.dart';

class ManufacturerWidget extends StatelessWidget {
  const ManufacturerWidget({
    super.key,
    required this.model,
    required this.onTapCard,
  });

  final ManufacturerModel model;
  final void Function(ManufacturerModel model) onTapCard;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppInjection.getIt<ManufacturerCubit>().showMedicinesOfModel(model);
      },
      child: Container(
        padding: AppPadding.padding10,
        height: AppSize.widthManufacturer,
        width: AppSize.widthManufacturer,
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: AutoSizeText(
                  getManufacturerName(model, split: false),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.f18w500black,
                  maxLines: 3,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                AppInjection.getIt<ManufacturerCubit>().showDetailsModel(model);
              },
              icon: const SvgImage(
                path: AppSvg.edit,
                color: AppColor.white,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ManufacturersListWidget extends StatelessWidget {
  const ManufacturersListWidget({
    super.key,
    required this.data,
    required this.onTapCard,
  });

  final List<ManufacturerModel> data;
  final void Function(ManufacturerModel model) onTapCard;

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
                  (index) => ManufacturerWidget(
                    model: data[index],
                    onTapCard: onTapCard,
                  ),
                ),
              ),
            ],
          );
  }
}
