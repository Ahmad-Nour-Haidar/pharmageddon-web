import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_lottie.dart';
import '../../core/constant/app_size.dart';
import '../../core/constant/app_svg.dart';
import '../../core/enums/order_status.dart';
import '../../core/functions/functions.dart';
import '../../model/order_model.dart';

class AppWidget {
  final noData = Center(
    child: Lottie.asset(AppLottie.noData,
        width: 220, height: 220, fit: BoxFit.fill),
  );

  final noDataAfterSearch = Center(
    child: Lottie.asset(AppLottie.noDataAfterSearch,
        width: 220, height: 220, fit: BoxFit.fill),
  );

  final reports = Center(
    child: Lottie.asset(
      AppLottie.reports,
      width: AppSize.width * .5,
      height: AppSize.width * .5,
      fit: BoxFit.fill,
    ),
  );

  Widget getOrderIcon(OrderModel model) {
    const s = 20.0;
    if (model.orderStatus == OrderStatus.preparing) {
      return Tooltip(
        message: model.orderStatus!.name.tr,
        child: const SvgImage(
          path: AppSvg.timePast,
          color: AppColor.red,
          size: s,
        ),
      );
    }
    if (model.orderStatus == OrderStatus.hasBeenSent) {
      return Tooltip(
        message: model.orderStatus!.name.tr,
        child: SvgImage(
          path: isEnglish() ? AppSvg.shippingFast : AppSvg.shippingFastLeft,
          color: AppColor.blue,
          size: s,
        ),
      );
    }
    return Tooltip(
      message: model.orderStatus!.name.tr,
      child: const SvgImage(
        path: AppSvg.checkCircle,
        color: AppColor.green,
        size: s,
      ),
    );
  }
}
