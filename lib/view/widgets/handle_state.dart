import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:pharmageddon_web/core/constant/app_size.dart';
import '../../core/class/parent_state.dart';

void handleState({
  required ParentState state,
  required BuildContext context,
  void Function()? onOk,
}) {
  if (!context.mounted) return;
  switch (state.runtimeType) {
    case OfflineState:
      {
        showAwesomeHandleState(
          context: context,
          title: state.message,
          dialogType: DialogType.error,
          onOk: onOk,
        );
        return;
      }
    case ServerFailureState:
      {
        showAwesomeHandleState(
          context: context,
          title: state.message,
          dialogType: DialogType.error,
          onOk: onOk,
        );
        return;
      }
    case FailureState:
      {
        showAwesomeHandleState(
          context: context,
          title: state.message,
          dialogType: DialogType.error,
          onOk: onOk,
        );
        return;
      }
    case SuccessState:
      {
        showAwesomeHandleState(
          context: context,
          title: state.message,
          dialogType: DialogType.success,
          onOk: onOk,
        );
        return;
      }
    case WarningState:
      {
        showAwesomeHandleState(
          context: context,
          title: state.message,
          dialogType: DialogType.warning,
          onOk: onOk,
        );
        return;
      }
  }
}

void showAwesomeHandleState({
  required BuildContext context,
  required String title,
  required DialogType dialogType,
  void Function()? onOk,
}) {
  AwesomeDialog(
    context: context,
    width: AppSize.width * .4,
    title: title,
    dialogType: dialogType,
    btnOkOnPress: onOk,
  ).show();
}
