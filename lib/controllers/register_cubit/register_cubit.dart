import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/controllers/register_cubit/register_state.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_constant.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_local_data.dart';
import '../../core/constant/app_text.dart';
import '../../core/functions/check_errors.dart';
import '../../core/functions/functions.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/auth_data.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final userNameController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authRemoteData = AppInjection.getIt<AuthRemoteData>();
  bool obscureText = true;

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    userNameController.dispose();
    addressController.dispose();
    return super.close();
  }

  void showPassword() {
    obscureText = !obscureText;
    emit(RegisterChangeShowPasswordState());
  }

  void register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(RegisterLoadingState());
    final data = {
      AppRKeys.email: emailController.text,
      AppRKeys.username: userNameController.text,
      AppRKeys.phone: phoneController.text,
      AppRKeys.password: passwordController.text,
      AppRKeys.address: addressController.text,
      AppRKeys.role: AppConstant.warehouseowner,
    };
    final response = await authRemoteData.register(data: data);
    if (isClosed) return;
    response.fold((l) {
      emit(RegisterFailureState(l));
    }, (response) async {
      if (response[AppRKeys.status] == 400) {
        final List list =
            response[AppRKeys.message][AppRKeys.validation_errors];
        const s = 'There is already an account for the warehouse owner.';
        if (list.contains(s)) {
          final m = AppText.thereIsAlreadyAnAccountForTheWarehouseOwner.tr;
          emit(RegisterFailureState(FailureState(message: m)));
        } else {
          var s = checkErrorMessages(
              response[AppRKeys.message][AppRKeys.validation_errors]);
          s = '${AppText.field.tr} $s ${AppText.alreadyBeenTaken.tr}';
          emit(RegisterFailureState(FailureState(message: s)));
        }
      } else {
        await storeUser(response);
        emit(RegisterSuccessState());
      }
    });
  }

  void logout() async {
    emit(RegisterLoadingState());
    final token = AppLocalData.user!.authorization ?? '';
    final response = await authRemoteData.logout(token: token);
    if (isClosed) return;
    response.fold((l) {
      emit(RegisterFailureState(l));
    }, (response) async {});
  }
}
