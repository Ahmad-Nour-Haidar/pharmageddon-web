import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_web/view/widgets/rich_text_span.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_text.dart';
import '../../core/functions/functions.dart';
import '../../core/services/dependency_injection.dart';
import '../../model/order_model.dart';
import 'app_widget.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.model,
    this.onTap,
  });

  final OrderModel model;
  final void Function(OrderModel model)? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => onTap == null ? null : onTap!(model),
        child: Container(
          padding: AppPadding.padding10,
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RichTextSpan(
                    s1: '${AppText.id.tr} : ',
                    s2: model.id.toString().trn,
                  ),
                  const Spacer(),
                  AppInjection.getIt<AppWidget>().getOrderIcon(model),
                  const Gap(10),
                ],
              ),
              FittedBox(
                child: RichTextSpan(
                  s1: '${AppText.pharmacist.tr} : ',
                  s2: model.pharmacistUsername.toString(),
                ),
              ),
              RichTextSpan(
                s1: '${AppText.totalQuantity.tr} : ',
                s2: model.totalQuantity.toString().trn,
              ),
              RichTextSpan(
                s1: '${AppText.totalPrice.tr} : ',
                s2: '${model.totalPrice.toString().trn} ${AppText.sp.tr}',
              ),
              RichTextSpan(
                s1: '${AppText.paymentState.tr} : ',
                s2: getPaymentStatus(model),
              ),
              RichTextSpan(
                s1: '${AppText.date.tr} : ',
                s2: formatYYYYMd(model.createdAt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderListWidget extends StatelessWidget {
  const OrderListWidget({
    super.key,
    required this.data,
    this.onTap,
  });

  final List<OrderModel> data;
  final void Function(OrderModel model)? onTap;

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
                  (index) => OrderWidget(
                    model: data[index],
                    onTap: onTap,
                  ),
                ),
              ),
              const Gap(20),
            ],
          );
  }
}
