import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/enums/order_status.dart';
import '../../../model/order_model.dart';

class ButtonsOrderDetails extends StatelessWidget {
  const ButtonsOrderDetails({
    super.key,
    required this.model,
    required this.onTapSend,
    required this.onTapReceivedDone,
    required this.onTapPaid,
    required this.onTapCancel,
    required this.isLoadingSend,
    required this.isLoadingReceivedDone,
    required this.isLoadingPaid,
    required this.isLoadingCancel,
  });

  final OrderModel model;
  final void Function() onTapSend;
  final void Function() onTapReceivedDone;
  final void Function() onTapPaid;
  final void Function() onTapCancel;
  final bool isLoadingSend;
  final bool isLoadingReceivedDone;
  final bool isLoadingPaid;
  final bool isLoadingCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (model.orderStatus == OrderStatus.preparing)
          _getButton(
            text: AppText.send.tr,
            isLoading: isLoadingSend,
            color: AppColor.green2,
            onPressed: onTapSend,
          ),
        if (model.orderStatus == OrderStatus.hasBeenSent)
          _getButton(
            text: AppText.received.tr,
            isLoading: isLoadingReceivedDone,
            color: AppColor.blue,
            onPressed: onTapReceivedDone,
          ),
        if (model.paymentStatus == 0 &&
            model.orderStatus == OrderStatus.received)
          _getButton(
            text: AppText.paid.tr,
            isLoading: isLoadingPaid,
            color: AppColor.snackbarColor,
            onPressed: onTapPaid,
          ),
        if (model.orderStatus == OrderStatus.preparing)
          _getButton(
            text: AppText.cancel.tr,
            isLoading: isLoadingCancel,
            color: AppColor.red,
            onPressed: onTapCancel,
          ),
      ],
    );
  }

  _getButton({
    required String text,
    required bool isLoading,
    required Color color,
    required void Function() onPressed,
  }) {
    return Expanded(
      child: SizedBox(
        height: 35,
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: color,
                    strokeWidth: 3,
                  ),
                ),
              )
            : TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(foregroundColor: color),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: color,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
