import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../core/class/parent_state.dart';
import '../../../core/constant/app_constant.dart';
import '../../../core/constant/app_keys_request.dart';
import '../../../core/constant/app_local_data.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/enums/status_request.dart';
import '../../../core/functions/functions.dart';
import '../../../core/notifications/app_firebase.dart';
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
  var statusRequest = StatusRequest.none;

  bool get isLoading => statusRequest == StatusRequest.loading;

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

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    statusRequest = StatusRequest.loading;
    emit(LoginLoadingState());
    final data = {
      AppRKeys.em_ph: emPhController.text,
      AppRKeys.role: AppConstant.warehouseowner,
      AppRKeys.password: passwordController.text,
    };
    final response = await authRemoteData.login(data: data);
    statusRequest = StatusRequest.none;
    if (isClosed) return;
    response.fold((l) {
      emit(LoginFailureState(l));
    }, (response) async {
      final status = response[AppRKeys.status];
      if (status == 402) {
        final s = AppText.somethingWentWrong.tr;
        emit(LoginFailureState(FailureState(message: s)));
      } else if (status == 403) {
        final s = AppText.emailOrPasswordIsWrong.tr;
        emit(LoginFailureState(FailureState(message: s)));
      } else if (status == 404) {
        emit(LoginNotVerifyState());
      } else if (status == 405) {
        final state = FailureState(message: AppText.goToTheOtherPlatform.tr);
        emit(LoginFailureState(state));
      } else if (status == 200) {
        await storeUser(response[AppRKeys.data][AppRKeys.user]);
        if (AppLocalData.user!.emailVerifiedAt == null) {
          emit(LoginNotVerifyState());
        } else {
          AppFirebase.setToken();
          emit(LoginSuccessState());
        }
      } else {
        emit(LoginFailureState(FailureState()));
      }
    });
  }
}
