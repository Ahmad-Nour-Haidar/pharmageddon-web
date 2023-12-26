import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_web/view/widgets/rich_text_span.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_text.dart';
import '../../core/functions/functions.dart';
import '../../core/services/dependency_injection.dart';
import '../../model/order_model.dart';
import 'app_widget.dart';

class TopWidgetOrderDetailsScreen extends StatelessWidget {
  const TopWidgetOrderDetailsScreen({
    super.key,
    required this.model,
  });

  final OrderModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.padding7,
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichTextSpan(
                s1: '${AppText.id.tr} : ',
                s2: model.id.toString().trn,
              ),
              AppInjection.getIt<AppWidget>().getOrderIcon(model),
            ],
          ),
          RichTextSpan(
            s1: '${AppText.totalQuantity.tr} : ',
            s2: model.totalQuantity.toString().trn,
          ),
          RichTextSpan(
            s1: '${AppText.totalPrice.tr} : ',
            s2: '${model.totalPrice} ${AppText.sp.tr}'.trn,
          ),
          RichTextSpan(
            s1: '${AppText.paymentState.tr} : ',
            s2: getPaymentStatus(model),
          ),
          RichTextSpan(
            s1: '${AppText.date.tr} : ',
            s2: formatYYYYMdEEEE(model.createdAt),
          ),
        ],
      ),
    );
  }
}
