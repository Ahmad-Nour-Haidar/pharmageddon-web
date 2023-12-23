import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_size.dart';
import '../../core/constant/app_text.dart';
import '../../core/resources/app_text_theme.dart';

void showAwesomeDelete({
  required BuildContext context,
  String desc = '',
  void Function()? btnOkOnPress,
}) {
  AwesomeDialog(
    context: context,
    width: AppSize.width * .5,
    btnOkText: AppText.ok.tr,
    btnCancelText: AppText.cancel.tr,
    title: AppText.confirmDeletion.tr,
    titleTextStyle: AppTextStyle.f18w600red,
    desc: desc,
    buttonsTextStyle: AppTextStyle.f15w500white,
    descTextStyle: AppTextStyle.f16w500black,
    dialogType: DialogType.question,
    btnOkOnPress: btnOkOnPress,
    btnCancelOnPress: () {},
    btnOkColor: AppColor.red,
    btnCancelColor: AppColor.green,
  ).show();
}

void showAwesomeActivate({
  required BuildContext context,
  String desc = '',
  void Function()? btnOkOnPress,
}) {
  AwesomeDialog(
    context: context,
    width: AppSize.width * .5,
    btnOkText: AppText.ok.tr,
    btnCancelText: AppText.cancel.tr,
    title: AppText.confirmDeletion.tr,
    titleTextStyle: AppTextStyle.f18w600red,
    desc: desc,
    buttonsTextStyle: AppTextStyle.f15w500white,
    descTextStyle: AppTextStyle.f16w500black,
    dialogType: DialogType.question,
    btnOkOnPress: btnOkOnPress,
    btnCancelOnPress: () {},
    btnOkColor: AppColor.contentColorGreen,
    btnCancelColor: AppColor.red,
  ).show();
}
