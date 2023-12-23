import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:pharmageddon_web/core/constant/app_size.dart';
import '../../core/class/parent_state.dart';

void handleState({
  required ParentState state,
  required BuildContext context,
}) {
  switch (state.runtimeType) {
    case OfflineState:
      {
        showAwesomeHandleState(
          context: context,
          title: state.message,
          dialogType: DialogType.error,
        );
        return;
      }
    case ServerFailureState:
      {
        showAwesomeHandleState(
          context: context,
          title: state.message,
          dialogType: DialogType.error,
        );
        return;
      }
    case FailureState:
      {
        showAwesomeHandleState(
          context: context,
          title: state.message,
          dialogType: DialogType.error,
        );
        return;
      }
    case SuccessState:
      {
        showAwesomeHandleState(
          context: context,
          title: state.message,
          dialogType: DialogType.success,
        );
        return;
      }
    case WarningState:
      {
        showAwesomeHandleState(
          context: context,
          title: state.message,
          dialogType: DialogType.warning,
        );
        return;
      }
  }
}

void showAwesomeHandleState({
  required BuildContext context,
  required String title,
  required DialogType dialogType,
}) {
  AwesomeDialog(
    context: context,
    width: AppSize.width * .5,
    title: title,
    dialogType: dialogType,
  ).show();
}
