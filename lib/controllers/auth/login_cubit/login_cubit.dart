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
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  final emPhController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authRemoteData = AppInjection.getIt<AuthRemoteData>();
  bool obscureText = true;
  bool onEmail = true;

  @override
  Future<void> close() {
    emPhController.dispose();
    passwordController.dispose();
    return super.close();
  }

  void showPassword() {
    obscureText = !obscureText;
    emit(LoginChangeState());
  }

  void changeIsEmail() {
    onEmail = !onEmail;
    emit(LoginChangeState());
  }

  void login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(LoginLoadingState());
    final data = {
      AppRKeys.em_ph: emPhController.text,
      AppRKeys.role: AppConstant.warehouseowner,
      AppRKeys.password: passwordController.text,
    };
    final response = await authRemoteData.login(data: data);
    if (isClosed) return;
    response.fold((l) {
      emit(LoginFailureState(l));
    }, (response) async {
      if (response[AppRKeys.status] == 402) {
        final s = AppText.somethingWentWrong.tr;
        emit(LoginFailureState(FailureState(message: s)));
      } else if (response[AppRKeys.status] == 403) {
        final s = AppText.emailOrPasswordIsWrong.tr;
        emit(LoginFailureState(FailureState(message: s)));
      } else if (response[AppRKeys.status] == 404) {
        emit(LoginNotVerifyState());
      } else if (response[AppRKeys.status] == 405) {
        final state = FailureState(message: AppText.goToTheOtherPlatform.tr);
        emit(LoginFailureState(state));
      } else {
        await storeUser(response);
        if (AppLocalData.user!.emailVerifiedAt == null) {
          emit(LoginNotVerifyState());
        } else {
          emit(LoginSuccessState());
        }
      }
    });
  }
}
