import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../core/class/parent_state.dart';
import '../../../core/constant/app_constant.dart';
import '../../../core/constant/app_keys_request.dart';
import '../../../core/constant/app_local_data.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/functions/functions.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../data/remote/auth_data.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitialState());

  static ResetPasswordCubit get(BuildContext context) =>
      BlocProvider.of(context);

  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final authRemoteData = AppInjection.getIt<AuthRemoteData>();
  final formKey = GlobalKey<FormState>();
  late String code = '';
  String? email;
  bool obscureText = true;

  void initial() async {
    getVerifyCode();
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmController.dispose();
    return super.close();
  }

  void showPassword() {
    obscureText = !obscureText;
    emit(ResetPasswordChangeShowPasswordState());
  }

  String get message =>
      '${AppText.enterTheVerificationCodeYouReceivedOnGmail.tr}\n$email';

  void onSubmit(String verificationCode) {
    code = verificationCode;
  }

  Future<void> getVerifyCode() async {
    email = null;
    emit(ResetPasswordLoadingGetState());
    final data = {
      AppRKeys.em_ph: AppLocalData.user!.email,
      AppRKeys.role: AppConstant.warehouseowner,
    };
    final response = await authRemoteData.getVerificationCode(data: data);
    if (isClosed) return;
    response.fold((l) {
      emit(ResetPasswordFailureGetState(l));
    }, (response) async {
      final status = response[AppRKeys.status];
      if (status == 402) {
        final message = AppText.verifyCodeNotSentTryAgain.tr;
        emit(ResetPasswordFailureGetState(FailureState(message: message)));
      } else if (status == 405) {
        final message = AppText.verifyCodeNotSentTryAgain.tr;
        emit(ResetPasswordFailureGetState(FailureState(message: message)));
      } else if (status == 200) {
        email = AppLocalData.user!.email;
        emit(ResetPasswordSuccessGetState());
      } else {
        emit(ResetPasswordFailureGetState(FailureState()));
      }
    });
  }

  Future<void> reset() async {
    if (!formKey.currentState!.validate()) return;
    if (code.length < 6) {
      emit(ResetPasswordFailureState(
          FailureState(message: AppText.enterTheCompleteVerificationCode.tr)));
      return;
    }
    if (passwordController.text != confirmController.text) {
      emit(ResetPasswordFailureState(
          FailureState(message: AppText.passwordsNoMatch.tr)));
      return;
    }
    emit(ResetPasswordLoadingState());
    final data = {
      AppRKeys.em_ph: AppLocalData.user!.email,
      AppRKeys.password: passwordController.text,
      AppRKeys.verification_code: code,
      AppRKeys.role: AppConstant.warehouseowner,
    };
    final response = await authRemoteData.resetPassword(data: data);
    if (isClosed) return;
    response.fold((l) {
      emit(ResetPasswordFailureState(l));
    }, (response) async {
      if (response[AppRKeys.status] == 402) {
        final message = AppText.somethingWentWrong.tr;
        emit(ResetPasswordFailureState(FailureState(message: message)));
      } else if (response[AppRKeys.status] == 403) {
        final message = AppText.verifyCodeNotCorrect.tr;
        emit(ResetPasswordFailureState(FailureState(message: message)));
      } else if (response[AppRKeys.status] == 405) {
        final message = AppText.goToTheOtherPlatform.tr;
        emit(ResetPasswordFailureState(FailureState(message: message)));
      } else {
        await storeUser(response[AppRKeys.data][AppRKeys.user]);
        emit(ResetPasswordSuccessState());
      }
    });
  }
}
