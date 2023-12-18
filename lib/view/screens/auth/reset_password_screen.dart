import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/controllers/reset_password_cubit/reset_password_cubit.dart';
import 'package:pharmageddon_web/controllers/reset_password_cubit/reset_password_state.dart';

import '../../../core/class/validation.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/constant/app_svg.dart';
import '../../../core/functions/functions.dart';
import '../../../core/functions/navigator.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_layout_builder.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/handle_state.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<ResetPasswordCubit>()..initial(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is ResetPasswordFailureGetState) {
            handleState(context: context, state: state.state);
          }
          if (state is ResetPasswordNotVerifyState) {
            pushNamedAndRemoveUntil(AppRoute.verifyCode, context);
          }
          if (state is ResetPasswordSuccessState) {
            pushNamedAndRemoveUntil(AppRoute.home, context);
          }
        },
        builder: (context, state) {
          final cubit = ResetPasswordCubit.get(context);
          return CustomLayoutBuilder(
            widget: (maxWidth, maxHeight) {
              // printme.cyan(maxWidth);
              // printme.cyan(maxHeight);
              return Scaffold(
                body: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      height: maxHeight,
                      width: maxWidth,
                      child: SvgPicture.asset(
                        AppSvg.background,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 45),
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: maxWidth * .06,
                                vertical: 30.0,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius:
                                    BorderRadius.circular(AppSize.radius20),
                              ),
                              child: Form(
                                key: cubit.formKey,
                                child: ListView(
                                  children: [
                                    Text(
                                      AppText.resetPassword.tr,
                                      style: AppTextTheme.f26w600black,
                                    ),
                                    const Gap(25),
                                    if (state is ResetPasswordLoadingGetState)
                                      const SpinKitFoldingCube(
                                          color: AppColor.primaryColor),
                                    if (cubit.email != null)
                                      Text(
                                        cubit.message,
                                        style: AppTextTheme.f18w500black,
                                      ),
                                    const Gap(30),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: OtpTextField(
                                        fieldWidth: 50.0,
                                        borderRadius: BorderRadius.circular(
                                            AppSize.size15),
                                        numberOfFields: 6,
                                        borderColor: AppColor.primaryColor,
                                        focusedBorderColor:
                                            AppColor.secondColor,
                                        enabledBorderColor:
                                            AppColor.primaryColor,
                                        showFieldAsBox: true,
                                        onSubmit:
                                            cubit.onSubmit, // end onSubmit
                                      ),
                                    ),
                                    const Gap(20),
                                    // password
                                    CustomTextFormField(
                                      controller: cubit.passwordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: ValidateInput.isPassword,
                                      textInputAction: TextInputAction.done,
                                      fillColor: AppColor.transparent,
                                      colorPrefixIcon: AppColor.gray,
                                      prefixIcon: AppSvg.eye,
                                      hintText: AppText.password.tr,
                                      suffixIcon: cubit.obscureText
                                          ? AppSvg.eye
                                          : AppSvg.eyeClose,
                                      onTapSuffix: cubit.showPassword,
                                      obscureText: cubit.obscureText,
                                    ),
                                    // confirm password
                                    const Gap(10),
                                    CustomTextFormField(
                                      controller: cubit.confirmController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: ValidateInput.isPassword,
                                      textInputAction: TextInputAction.done,
                                      fillColor: AppColor.transparent,
                                      colorPrefixIcon: AppColor.gray,
                                      prefixIcon: AppSvg.eye,
                                      hintText: AppText.password.tr,
                                      suffixIcon: cubit.obscureText
                                          ? AppSvg.eye
                                          : AppSvg.eyeClose,
                                      onTapSuffix: cubit.showPassword,
                                      obscureText: cubit.obscureText,
                                    ),
                                    const Gap(15),
                                    if (state is ResetPasswordLoadingState)
                                      const SpinKitThreeBounce(
                                        color: AppColor.primaryColor,
                                      ),
                                    if (state is! ResetPasswordLoadingState)
                                      CustomButton(
                                        onTap: cubit.reset,
                                        text: AppText.reset.tr,
                                      ),
                                    const Gap(15),
                                    Align(
                                      alignment: isEnglish()
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: TextButton(
                                        onPressed: cubit.getVerifyCode,
                                        child: Text(
                                          AppText.resendVerifyCode.tr,
                                          style: AppTextTheme.f18w400TextColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    AppSvg.logo,
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                                const Gap(20),
                                Center(
                                  child: Text(
                                    'Pharmageddon',
                                    style: AppTextTheme.f24w600SecondColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
