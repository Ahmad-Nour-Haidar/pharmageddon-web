import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_web/view/widgets/row_text_span.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_text.dart';
import '../../core/functions/functions.dart';
import '../../core/services/dependency_injection.dart';
import '../../model/order_model.dart';
import 'app_widget.dart';

class ReportWidget extends StatelessWidget {
  const ReportWidget({
    super.key,
    required this.model,
  });

  final OrderModel model;

  @override
  Widget build(BuildContext context) {
    final tag = UniqueKey();
    return Material(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 4,
      child: Container(
        padding: AppPadding.padding10,
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: tag,
              child: Row(
                children: [
                  RowTextSpan(
                    s1: '${AppText.id.tr} : ',
                    s2: model.id.toString().trn,
                  ),
                  const Spacer(),
                  AppInjection.getIt<AppWidget>().getOrderIcon(model),
                  const Gap(10),
                ],
              ),
            ),
            const Gap(5),
            FittedBox(
              child: RowTextSpan(
                s1: '${AppText.pharmacist.tr} : ',
                s2: model.pharmacistUsername.toString(),
              ),
            ),
            RowTextSpan(
              s1: '${AppText.totalQuantity.tr} : ',
              s2: model.totalQuantity.toString().trn,
            ),
            RowTextSpan(
              s1: '${AppText.totalPrice.tr} : ',
              s2: '${model.totalPrice.toString().trn} ${AppText.sp.tr}',
            ),
            RowTextSpan(
              s1: '${AppText.paymentState.tr} : ',
              s2: getPaymentStatus(model),
            ),
            RowTextSpan(
              s1: '${AppText.date.tr} : ',
              s2: formatYYYYMd(model.createdAt),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportListWidget extends StatelessWidget {
  const ReportListWidget({
    super.key,
    required this.data,
  });

  final List<OrderModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: data.isEmpty
          ? [const Gap(100), AppInjection.getIt<AppWidget>().noData]
          : [
              Wrap(
                spacing: 30,
                runSpacing: 20,
                children: List.generate(
                  data.length,
                  (index) => ReportWidget(model: data[index]),
                ),
              ),
              const Gap(30),
            ],
    );
  }
}
