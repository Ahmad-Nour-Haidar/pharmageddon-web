import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_web/view/widgets/rich_text_span.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_text.dart';
import '../../core/functions/functions.dart';
import '../../core/resources/app_text_theme.dart';
import '../../model/order_details_model.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.index,
    required this.model,
  });

  final int index;
  final OrderDetailsModel model;

  String get name {
    return getOrderDetailsModelName(model);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: AppPadding.padding7,
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.white, width: 4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichTextSpan(s1: '${AppText.name.tr} : ', s2: name),
              RichTextSpan(
                s1: '${AppText.totalQuantity.tr} : ',
                s2: model.totalQuantity.toString().trn,
              ),
              RichTextSpan(
                s1: '${AppText.totalPrice.tr} : ',
                s2: '${model.totalPrice} ${AppText.sp.tr}'.trn,
              ),
            ],
          ),
        ),
        Positioned.fill(
          top: 7,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: AppColor.background,
              child: Text(
                ' ( ${index + 1} ) '.trn,
                style: AppTextStyle.f20w600green2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OrderDetailsList extends StatelessWidget {
  const OrderDetailsList({
    super.key,
    required this.data,
  });

  final List<OrderDetailsModel> data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => OrderDetailsWidget(
          index: index,
          model: data[index],
        ),
      ),
    );
  }
}
