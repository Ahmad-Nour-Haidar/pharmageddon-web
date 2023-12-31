import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../core/class/parent_state.dart';
import '../../../core/constant/app_constant.dart';
import '../../../core/constant/app_keys_request.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/functions/functions.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../data/remote/auth_data.dart';
import 'check_email_state.dart';

class CheckEmailCubit extends Cubit<CheckEmailState> {
  CheckEmailCubit() : super(CheckEmailInitialState());

  static CheckEmailCubit get(BuildContext context) => BlocProvider.of(context);

  final emPHController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authRemoteData = AppInjection.getIt<AuthRemoteData>();
  bool onEmail = true;

  @override
  Future<void> close() {
    emPHController.dispose();
    return super.close();
  }

  void check() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(CheckEmailLoadingState());
    final data = {
      AppRKeys.em_ph: emPHController.text,
      AppRKeys.role: AppConstant.warehouseowner,
    };
    final response = await authRemoteData.checkEmail(data: data);
    if (isClosed) return;
    response.fold((l) {
      emit(CheckEmailFailureState(l));
    }, (response) async {
      final status = response[AppRKeys.status];
      if (status == 200) {
        await storeUser(response[AppRKeys.data][AppRKeys.user]);
        emit(CheckEmailSuccessState());
      } else if (status == 405) {
        final message = AppText.goToTheOtherPlatform.tr;
        emit(CheckEmailFailureState(FailureState(message: message)));
      } else if (status == 403) {
        final message = AppText.userNotFound.tr;
        emit(CheckEmailFailureState(FailureState(message: message)));
      } else {
        emit(CheckEmailFailureState(FailureState()));
      }
    });
  }
}
